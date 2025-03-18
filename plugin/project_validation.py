import dataclasses
from enum import Enum
from pathlib import Path

from qgis.PyQt.QtCore import Qt
from qgis.PyQt.QtWidgets import (
    QDialog,
    QHBoxLayout,
    QLabel,
    QMessageBox,
    QPushButton,
    QTextEdit,
    QVBoxLayout,
)

from .config import (
    FEATURE_STR_IDENTIFIERS,
    FEATURE_TABLES,
    LOCALITY_POINT_CHILDREN,
)
from .utils import (  # noqa
    FieldDataCaptureProject,
    get_table_rows,
    get_msgbox_icon_pixmap,
    ipdb_breakpoint,
)

ATTACHMENT_TABLES = {
    "media": "media_link",
    "photo": "photo_file",
}
ATTACHMENT_DIRS = {
    "media": "media",
    "photo": "photos",
}


class ValidationStatus(Enum):
    """
    Class to store validation statuses as enums.
    Includes some methods for comparing values according to this discussion:
    https://stackoverflow.com/questions/39268052/how-to-compare-enums-in-python
    """
    FAIL = 0
    WARNING = 10
    PASS = 20

    def __lt__(self, other) -> bool:
        """
        Less than implementation.
        """
        if self.__class__ is other.__class__:
            # We have to get the actual integer value from the object
            return self.value < other.value
        return NotImplemented

    def __gt__(self, other) -> bool:
        """
        Greater than implementation.
        """
        if self.__class__ is other.__class__:
            # We have to get the actual integer value from the object
            return self.value > other.value
        return NotImplemented


@dataclasses.dataclass
class ValidationResult:
    validation_function: str
    # Set the status to PASS initially and change it later if required
    status: ValidationStatus = dataclasses.field(default_factory=lambda: ValidationStatus.PASS)
    # Make the list of messages default to an empty list
    messages: list[str] = dataclasses.field(default_factory=list)


class ValidationDialog(QDialog, FieldDataCaptureProject):
    """
    QDialog for displaying the results of validating a Field Data Capture project.
    """
    def __init__(self, results: list[ValidationResult]):
        super().__init__()

        self.status_to_str = {
            ValidationStatus.FAIL: "failed",
            ValidationStatus.WARNING: "warning",
            ValidationStatus.PASS: "passed",
        }
        self.status_to_icon = {
            ValidationStatus.FAIL: QMessageBox.Critical,
            ValidationStatus.WARNING: QMessageBox.Warning,
            ValidationStatus.PASS: QMessageBox.Information,
        }

        self.setWindowTitle("Project Validation")
        self.setWindowFlags(
            Qt.Window | Qt.WindowCloseButtonHint
        )

        self.setup_ui_elements()
        self.add_validation_results(results)
        self.exec()


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the Validation Dialog window.
        Also sets the layout for the dialog box.
        """
        self.result_icon = QLabel()
        self.result_label = QLabel()

        self.text_edit = QTextEdit()
        self.text_edit.setReadOnly(True)
        self.text_edit.hide()

        self.ok_button = QPushButton("Ok")
        self.ok_button.clicked.connect(lambda: self.closeEvent(None))

        # Create layout for icon and main label
        icon_layout = QHBoxLayout()
        icon_layout.addWidget(self.result_icon)
        icon_layout.addSpacing(10)
        icon_layout.addWidget(self.result_label)
        icon_layout.addStretch(1)
        icon_layout.setContentsMargins(*(10,) * 4)

        # Create dialog layout
        dialog_layout = QVBoxLayout()
        dialog_layout.addLayout(icon_layout)
        dialog_layout.addWidget(self.text_edit)
        dialog_layout.addWidget(self.ok_button, alignment=Qt.AlignRight)
        self.setLayout(dialog_layout)


    def add_validation_results(self, results: list[ValidationResult]) -> None:
        """
        Add the given list of validation results to the dialog widgets.
        This includes setting the dialog width, filling the text edit widget
        with warning and fail messages, and applying the correct icon.
        """
        all_messages: list[str] = []
        result_statuses: set[ValidationStatus] = set()
        for result in results:
            result_statuses.add(result.status)

            if result.status < ValidationStatus.PASS:
                display_messages = [
                    # Add bullet point before each message
                    "• " + message
                    for message in result.messages
                ]
                all_messages.append("\n".join(display_messages))

        # Get final status
        final_status = min(result_statuses)

        if final_status < ValidationStatus.PASS:
            self.setMinimumWidth(500)
            self.text_edit.setText("\n\n".join(all_messages))
            self.text_edit.show()

        self.result_icon.setPixmap(get_msgbox_icon_pixmap(self.status_to_icon[final_status]))
        self.result_label.setText(
            f"Validation for project '{self.project_dir.name}': {self.status_to_str[final_status].upper()}",
        )


def validate_project(project_dir: Path) -> list[ValidationResult]:
    """
    Run all checks against the given project directory.
    """
    checks = [
        check_features_valid_parents,
        check_locality_children_valid_parents,
        check_field_project_plugin_version,
        check_attached_filepaths_not_null,
        check_attached_filepaths_exist,
        check_attachment_filepaths_recorded,
        check_no_conflict_gpkg_exists,
    ]

    results = [
        check_func(FieldDataCaptureProject(project_dir))
        for check_func in checks
    ]

    return results


def check_features_valid_parents(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all of the geometry features in the given project have a valid parent field_project.
    """
    result = ValidationResult(validation_function=check_features_valid_parents.__name__)

    field_project_uuid = get_table_rows(project.db_file, "SELECT uuid FROM field_project")[0]["uuid"]

    # Check all feature tables other than field_project
    for table in sorted(FEATURE_TABLES - {"field_project"}):
        feature_identifier = FEATURE_STR_IDENTIFIERS[table]
        rows = get_table_rows(project.db_file, f"SELECT field_project_fuid, {feature_identifier} FROM {table}")

        # Perform check
        bad_rows = [
            row
            for row in rows
            if row["field_project_fuid"] != field_project_uuid
        ]

        # Prepare results
        # If failed
        if len(bad_rows) > 0:
            result.status = ValidationStatus.FAIL
            for bad_row in bad_rows:
                result.messages.append(
                    f"Record in '{table}' with invalid parent 'field_project' found: {bad_row[feature_identifier]}"
                )

    return result


def check_locality_children_valid_parents(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all of the locality_point child features in the given project have a valid parent locality_point.
    """
    result = ValidationResult(validation_function=check_locality_children_valid_parents.__name__)

    locality_point_uuids = {
        row["uuid"]
        for row in get_table_rows(project.db_file, "SELECT uuid FROM locality_point")
    }

    for table in sorted(LOCALITY_POINT_CHILDREN):
        feature_identifier = FEATURE_STR_IDENTIFIERS[table]
        rows = get_table_rows(project.db_file, f"SELECT locality_fuid, {feature_identifier} FROM {table}")

        # Perform check
        bad_rows = [
            row
            for row in rows
            if row["locality_fuid"] not in locality_point_uuids
        ]

        # Prepare results
        # If failed
        if len(bad_rows) > 0:
            result.status = ValidationStatus.FAIL
            for bad_row in bad_rows:
                result.messages.append(
                    f"Record in '{table}' with invalid parent 'locality_point' found: {bad_row[feature_identifier]}"
                )

    return result


def check_field_project_plugin_version(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that a plugin version is included in the field_project record of the given project.
    """
    result = ValidationResult(validation_function=check_field_project_plugin_version.__name__)

    # Perform check
    plugin_version = get_table_rows(
        project.db_file,
        "SELECT qgis_plugin_version FROM field_project",
    )[0]["qgis_plugin_version"]

    # Prepare results
    # If failed
    if plugin_version is None:
        result.status = ValidationStatus.FAIL
        result.messages.append("The 'field_project' record does not include a valid 'qgis_plugin_version'")

    return result


def check_attached_filepaths_not_null(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all filepaths which are saved into the given project (e.g. photos/media)
    are not null.
    """
    result = ValidationResult(validation_function=check_attached_filepaths_not_null.__name__)

    for table, attachment_col in ATTACHMENT_TABLES.items():
        # Perform check
        null_attachments = [
            row["fid"]
            for row in get_table_rows(project.db_file, f"SELECT fid, {attachment_col} FROM {table}")
            if row[attachment_col] is None
        ]

        # Prepare results
        # If failed
        if len(null_attachments) > 0:
            result.status = ValidationStatus.FAIL
            for fid in null_attachments:
                result.messages.append(
                    f"File referenced in '{table}' table is NULL, feature ID: {fid}"
                )

    return result


def check_attached_filepaths_exist(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all filepaths which are saved into the given project (e.g. photos/media)
    have a matching and existing file within the file.
    """
    result = ValidationResult(validation_function=check_attached_filepaths_exist.__name__)

    for table, attachment_col in ATTACHMENT_TABLES.items():
        attachment_dir: Path = getattr(project, f"{ATTACHMENT_DIRS[table]}_dir")

        # Perform check
        non_existing_attachments = [
            row[attachment_col]
            for row in get_table_rows(project.db_file, f"SELECT {attachment_col} FROM {table}")
            # If the attachment_column has a valid value but the filepath does not exist
            if row[attachment_col] is not None and not (attachment_dir / row[attachment_col]).exists()
        ]

        # Prepare results
        # If failed
        if len(non_existing_attachments) > 0:
            result.status = ValidationStatus.FAIL
            for attachment in non_existing_attachments:
                result.messages.append(
                    f"File referenced in '{table}' table not found: {attachment}"
                )

    return result


def check_attachment_filepaths_recorded(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all attachment filepaths which are saved into the given project directory (e.g. photos/media)
    have a matching record within the database.
    """
    result = ValidationResult(validation_function=check_attachment_filepaths_recorded.__name__)

    for table, attachment_col in ATTACHMENT_TABLES.items():
        attachment_dir: Path = getattr(project, f"{ATTACHMENT_DIRS[table]}_dir")

        # Perform check
        recorded_attachments = {
            Path(row[attachment_col])
            for row in get_table_rows(project.db_file, f"SELECT {attachment_col} FROM {table}")
            if row[attachment_col] is not None
        }

        unrecorded_attachments = [
            attachment
            for attachment in attachment_dir.rglob("*")
            if all((
                attachment.is_file(),
                attachment.name != project.placeholder_filename.name,
                attachment.relative_to(attachment_dir) not in recorded_attachments,
            ))
        ]

        # Prepare results
        # If failed
        if len(unrecorded_attachments) > 0:
            result.status = ValidationStatus.FAIL
            for attachment in unrecorded_attachments:
                result.messages.append(
                    f"Unlinked file in '{table}' directory: {attachment}"
                )

    return result


def check_no_conflict_gpkg_exists(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that no conflict GeoPackage files exist in the given project.
    These are determined by finding GeoPackage files with 'conflicted copy' in their name.
    """
    result = ValidationResult(validation_function=check_no_conflict_gpkg_exists.__name__)

    # Perform check
    conflict_files = list(project.project_dir.glob("*conflicted copy*.gpkg"))

    # Prepare results
    # If failed
    if len(conflict_files) > 0:
        result.status = ValidationStatus.WARNING
        for conflict_file in conflict_files:
            result.messages.append(f"Conflict GeoPackage file found: {conflict_file.name}")

    return result
