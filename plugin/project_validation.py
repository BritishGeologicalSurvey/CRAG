import dataclasses
from enum import Enum
from pathlib import Path

from .config import (
    FEATURE_STR_IDENTIFIERS,
    FEATURE_TABLES,
    ATTRIBUTE_TABLES,
)
from .utils import (  # noqa
    FieldDataCaptureProject,
    get_table_rows,
    ipdb_breakpoint,
)


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


def validate_project(project_dir: Path) -> list[ValidationResult]:
    """
    Run all checks against the given project directory.
    """
    checks = [
        check_project_name,
        check_features_valid_parents,
        check_locality_children_valid_parents,
        check_field_project_plugin_version,
        check_unlinked_attachment_files,
        check_attached_filepaths_not_null,
        check_attached_filepaths_not_placeholder,
        check_attached_filepaths_exist,
        check_attachment_filepaths_recorded,
        check_no_conflict_gpkg_exists,
        check_required_filepaths_in_project_dir,
    ]

    results = [
        check_func(FieldDataCaptureProject(project_dir))
        for check_func in checks
    ]

    return results


def check_project_name(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that the field_project.short_name is the basename for the qgz and gpkg files
    """
    result = ValidationResult(validation_function=check_project_name.__name__)

    field_project_short_name = get_table_rows(project.db_file, "SELECT short_name FROM field_project")[0]["short_name"]

    # Check all feature tables other than field_project
    for file in (project.db_file, project.qgz_file):
        if file.stem != field_project_short_name:
            result.status = ValidationStatus.FAIL
            result.messages.append(
                f"File name '{file}' does not match 'field_project.short_name': {field_project_short_name}"
            )

    return result


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

    for table in sorted(ATTRIBUTE_TABLES):
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


def check_unlinked_attachment_files(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that there are no unlinked files in the photos/media unlinked sub-directory.
    """
    result = ValidationResult(validation_function=check_unlinked_attachment_files.__name__)

    for table, table_dir in project.layers_to_dirs.items():
        # Perform check
        unlinked_dir = table_dir / project.unlinked_dir_name
        unlinked_files = [
            filepath
            for filepath in unlinked_dir.rglob("*")
            if filepath.name != project.placeholder_filename
        ]

        # Prepare results
        # If failed
        number_unlinked_files = len(unlinked_files)
        if number_unlinked_files > 0:
            result.status = ValidationStatus.WARNING
            result.messages.append(
                f"Directory 'unlinked' for '{table}' table contains {number_unlinked_files} file(s), "
                "these files will not be included in reports or visible in QGIS forms."
            )

    return result


def check_attached_filepaths_not_null(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all filepaths which are saved into the given project (e.g. photos/media)
    are not null.
    """
    result = ValidationResult(validation_function=check_attached_filepaths_not_null.__name__)

    for table, attachment_col in project.layers_to_file_attributes.items():
        # Perform check
        null_attachments = [
            row["fid"]
            for row in get_table_rows(project.db_file, f"SELECT fid FROM {table} WHERE {attachment_col} IS NULL")
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


def check_attached_filepaths_not_placeholder(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all filepaths which are saved into the given project (e.g. photos/media)
    are not the BGS placeholder image.
    """
    result = ValidationResult(validation_function=check_attached_filepaths_not_placeholder.__name__)

    for table, attachment_col in project.layers_to_file_attributes.items():
        # Perform check
        placeholder_attachments = [
            row["fid"]
            for row in get_table_rows(
                project.db_file,
                f"SELECT fid FROM {table} WHERE {attachment_col} = '{project.default_attachment_str}'",
            )
        ]

        # Prepare results
        # If failed
        if len(placeholder_attachments) > 0:
            result.status = ValidationStatus.FAIL
            for fid in placeholder_attachments:
                result.messages.append(
                    f"File referenced in '{table}' table is placeholder image, feature ID: {fid}"
                )

    return result


def check_attached_filepaths_exist(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all filepaths which are saved into the given project (e.g. photos/media)
    have a matching and existing file within the file.
    """
    result = ValidationResult(validation_function=check_attached_filepaths_exist.__name__)

    for table, attachment_col in project.layers_to_file_attributes.items():
        attachment_dir = project.layers_to_dirs[table]

        # Perform check
        non_existing_attachments = [
            row[attachment_col]
            for row in get_table_rows(
                project.db_file,
                f"SELECT {attachment_col} FROM {table} WHERE {attachment_col} != '{project.default_attachment_str}'",
            )
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

    for table in ["media", "photo"]:
        unrecorded_attachments = project.get_unlinked_files(table)

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


def check_required_filepaths_in_project_dir(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that all required files and paths are in the project directory.
    """
    result = ValidationResult(validation_function=check_required_filepaths_in_project_dir.__name__)

    # Files and directories required by the project
    required_filepaths = {project.db_file, project.qgz_file, project.photos_dir, project.media_dir,
                          project.baseline_data_dir, project.system_files_dir}

    # Perform check
    all_files = set(project.project_dir.glob("*"))

    # Prepare results
    # If failed
    if not required_filepaths.issubset(all_files):
        result.status = ValidationStatus.FAIL
        for filepath in required_filepaths:
            if filepath not in all_files:
                result.messages.append(f"Required file or directory missing from project directory: {filepath.name}")

    return result
