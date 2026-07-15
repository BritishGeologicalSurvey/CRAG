# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
from pathlib import Path
from typing import (
    Any,
    Optional,
)

from qgis.core import (
    Qgis,
    QgsProject,
    QgsRuleBasedLabeling,
    QgsSettings,
    QgsVectorLayer,
)
from qgis.PyQt.QtCore import QUrl
from qgis.PyQt.QtGui import (
    QDesktopServices,
    QFont,
)
from qgis.PyQt.QtWidgets import (
    QFrame,
    QLabel,
    QMessageBox,
    QPushButton,
)

from .config import TABLE_LIST, MESSAGE_BAR_TIME_LIMIT
from .create_gpkg_from_sql import WORKDIR
from .utils import get_table_rows

SYSTEM_DIR_NAME = "_crag"
# Using locally downloaded woff2 of Google's Material Symbols Outlined font
# See: https://fonts.google.com/icons
# Licence: https://www.apache.org/licenses/LICENSE-2.0.html
FONT_FILENAME = "MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].woff2"


class CragProject:
    """
    Base/Mixin class for basic attributes of the project file structure.
    This class includes a base __init__ method which can be overwritten/ignored.
    It simply takes a project_dir value and uses it in-place of the default project_dir found from QGIS.
    """
    # This is the internal project_dir attribute
    _project_dir: Optional[Path] = None
    placeholder_filename = "_placeholder.txt"
    bgs_logo_filename = "BGS-Logo-Pos-RGB.svg"
    bgs_placeholder_logo_filename = "BGS-placeholder.png"
    layers_to_file_attributes = {
        "media": "media_link",
        "photo": "photo_file",
    }
    plugin_settings_prefix = "Crag"


    def __init__(self, project_dir: Optional[Path] = None):
        """
        Base init method which effectively sets the self.project_dir attribute using the given Path.
        """
        if project_dir is not None:
            # Overriding a class attribute within the __init__ makes it an instance attribute
            # This means the instance attribute is no longer shared with other instances
            self._project_dir = project_dir

    @property
    def project_instance(self) -> QgsProject:
        """
        Get the current project instance.
        """
        # This always returns a QgsProject, even if no project is open.
        return QgsProject.instance()

    @property
    def project_dir(self) -> Path:
        """
        Get the current project directory.
        If a project_dir value was given during initalisation, return that value.
        Otherwise, return the current project_dir from QGIS.
        """
        if self._project_dir is None:
            return Path(QgsProject.instance().readPath("./"))
        else:
            return self._project_dir

    #
    # Files and paths visible in the project directory
    #
    @property
    def db_file(self) -> Path:
        """
        Get the db file path from the current project.
        """
        return self.project_dir / f"{self.qgz_file.stem}.gpkg"

    @property
    def qgz_file(self) -> Path:
        """
        Get the qgz file from the current project.  We assume that only one .qgz file is present
        in the project folder as this is a requirement for Mergin Maps syncing.
        """
        return next(self.project_dir.glob('*.qgz'))

    @property
    def photos_dir(self) -> Path:
        """
        Get the photos directory path from the current project.
        """
        return self.project_dir / "photos"

    @property
    def media_dir(self) -> Path:
        """
        Get the media directory path from the current project.
        """
        return self.project_dir / "media"

    @property
    def unlinked_files_dir(self) -> Path:
        """
        Get the unlinked files directory path from the current project.
        """
        return self.project_dir / "unlinked_files"

    @property
    def baseline_data_dir(self) -> Path:
        """
        Get the baseline data directory path from the current project.
        """
        return self.project_dir / "baseline_data"

    @property
    def html_report_file(self) -> Path:
        """
        Get the HTML field report file path from the current project.
        """
        return self.project_dir / f"{self.qgz_file.stem}_field_report.html"

    @property
    def pdf_report_file(self) -> Path:
        """
        Get the PDF field report file path from the current project.
        """
        return self.project_dir / f"{self.qgz_file.stem}_field_report.pdf"

    @property
    def system_files_dir(self) -> Path:
        """
        Get the system files directory path from the current project.
        """
        return self.project_dir / SYSTEM_DIR_NAME

    #
    # Files and paths hidden in the system files directory
    #
    @property
    def styles_dir(self) -> Path:
        """
        Get the styles directory path from the current project.
        """
        return self.system_files_dir / "styles"

    @property
    def thumbnails_dir(self) -> Path:
        """
        Get the thumbnails directory path from the current project.
        """
        return self.system_files_dir / "_thumbnails"

    @property
    def icons_dest_dir(self) -> Path:
        """
        Get the icons directory path from the project folder.
        """
        return self.system_files_dir / "icons"

    @property
    def css_dest_dir(self) -> Path:
        """
        Get the ccs directory from the current project.
        """
        return self.system_files_dir / "css"

    @property
    def font_dest_dir(self) -> Path:
        """
        Get the font directory from the current project.
        """
        return self.system_files_dir / "fonts"

    #
    # Files and paths in the plugin directory
    #
    @property
    def icons_src_dir(self) -> Path:
        """
        Get the icons directory path from the plugin folder.
        """
        return WORKDIR / "icons"

    @property
    def css_src_file(self) -> Path:
        """
        Get the ccs file path from the plugin folder.
        """
        return WORKDIR / "css" / "style.css"

    @property
    def font_src_file(self) -> Path:
        """
        Get the font file path from the plugin folder.
        """
        return WORKDIR / "fonts" / FONT_FILENAME

    @property
    def templates_dir(self) -> Path:
        """
        Get the Jinja2 template directory path from the plugin folder.
        """
        return WORKDIR / "templates"

    @property
    def help_file(self) -> Path:
        """
        Get the help directory path from the plugin folder.
        """
        return WORKDIR / "help" / "index.html"

    @property
    def layers_to_dirs(self) -> dict[str, Path]:
        """
        Dictionary of layer names to their corresponding directories.
        """
        return {
            "media": self.media_dir,
            "photo": self.photos_dir,
        }


    @property
    def default_attachment_str(self) -> str:
        """
        The default string used to populate attachment filepaths in the forms.
        """
        return f"../{SYSTEM_DIR_NAME}/icons/{self.bgs_placeholder_logo_filename}"


    @property
    def bgs_logo_file(self) -> Path:
        """
        Path to the BGS logo file.
        """
        return self.icons_src_dir / self.bgs_logo_filename


    def copy_plugin_files_to_project(self, plugin_src: Path | str, project_dest: Path | str) -> None:
        """
        Copy the files from the given plugin source directory into the given project destination directory.
        If the src filepath is a directory, all files within it will be copied to the dest filepath directory.
        If the src filepath is a file, it will be copied to the dest filepath directory.

        The project_dest filepath must always be a directory.

        If plugin_src is a Path, it must be an absolute filepath in the plugin/ directory within the repository,
        If plugin_src is a a string, it must be relative to the plugin/ directory within the repository.
        If project_dest is a Path, it must be an absolute filepath in the project directory.
        If project_dest is a string, it must be relative to the project directory.
        """
        # Use given relative paths to create full paths
        if isinstance(plugin_src, str):
            plugin_src = WORKDIR / plugin_src

        if isinstance(project_dest, str):
            project_dest = self.project_dir / project_dest

        project_dest.mkdir(parents=True, exist_ok=True)

        if plugin_src.is_dir():
            src_files = list(plugin_src.glob("*"))
        else:
            src_files = [plugin_src]

        for src_file in src_files:
            dest_file = project_dest / src_file.name
            dest_file.write_bytes(src_file.read_bytes())


    def get_crag_layer(self, layer_name: str, warn: bool = True) -> Optional[QgsVectorLayer]:
        """
        Get the CRAG layer with the given name.
        Checks will ensure the found layer comes from the main GeoPackage of the project.
        By default will show a QGIS messageBar warning if the layer is not found.
        """
        valid_layers = [
            layer
            for layer in QgsProject.instance().mapLayersByName(layer_name)
            # Valid layers are determined by their data source path being equal to the main GeoPackage
            # This filepath can include the layer name e.g. (field-data-capture.gpkg|locality_point)
            if Path(layer.dataProvider().dataSourceUri().split("|")[0]) == self.db_file.absolute()
        ]

        if len(valid_layers) == 1:
            return valid_layers[0]

        if warn:
            message = f"Could not find the required layer: {layer_name}"
            self.iface.messageBar().pushMessage("CRAG", message, Qgis.Warning, MESSAGE_BAR_TIME_LIMIT)
        return None


    def project_is_active(self) -> bool:
        """
        Check if a saved project is currently open.
        """
        if QgsProject.instance().fileName() != '':
            return True
        else:
            message = "Please open an existing saved project."
            self.iface.messageBar().pushMessage("CRAG", message, Qgis.Warning, MESSAGE_BAR_TIME_LIMIT)
            return False


    def check_layer_exists(self, layer_name: str) -> bool:
        """
        Check if a given layer name exists in the list of current layers.
        """
        if self.get_crag_layer(layer_name, warn=False) is not None:
            return True
        else:
            return False


    def check_crag_layers_exist(self) -> bool:
        """
        Check if the CRAG layers exist in the current layers.
        """
        missing_layers = [
            table_name
            for table_name in TABLE_LIST
            if not self.check_layer_exists(table_name)
        ]
        if len(missing_layers) == 0:
            return True
        else:
            return False


    def check_field_project_exists(self) -> bool:
        """
        Check that the field_project layer has a saved feature.
        """
        layer_name = "field_project"
        # If the layer does not exist, it will have no features
        if not self.check_layer_exists(layer_name):
            return False

        field_project_layer = self.get_crag_layer("field_project")
        fp_features = list(field_project_layer.getFeatures())

        # If the number of features is less than 1 or the first feature has an unsaved fid value
        if len(fp_features) < 1 or fp_features[0].attribute("fid") in {"Autogenerate", ""}:
            return False

        return True


    def validate_qgis_state(
        self,
        project_active: bool = False,
        db_file_exists: bool = False,
        crag_layers_exist: bool = False,
        layer_name_exists: Optional[str] = None,
        field_project_exists: bool = False,
    ) -> bool:
        """
        Validate that the given options are currently OK in QGIS.
        Returns a boolean indicating the validity of the current state of QGIS.
        """
        # If we need to check project_active and the project is not active
        if project_active and not self.project_is_active():
            return False

        # If we need to check the db_file_exists and the db file does not exist
        if db_file_exists and not self.db_file.exists():
            message = f"Could not find file: {self.db_file}"
            self.iface.messageBar().pushMessage("CRAG", message, Qgis.Warning, MESSAGE_BAR_TIME_LIMIT)
            return False

        # If we need to check the crag_layers_exist and the crag layers do not exist
        if crag_layers_exist and not self.check_crag_layers_exist():
            message = "Could not find the required layers for CRAG."
            self.iface.messageBar().pushMessage("CRAG", message, Qgis.Warning, MESSAGE_BAR_TIME_LIMIT)
            return False

        # If we need to check that a given layer_name_exists and the given layer name does not exist
        if layer_name_exists is not None and not self.check_layer_exists(layer_name_exists):
            message = f"Could not find layer: {layer_name_exists}"
            self.iface.messageBar().pushMessage("CRAG", message, Qgis.Warning, MESSAGE_BAR_TIME_LIMIT)

        # If we need to check that there is 1 saved field_project and there isn't 1
        if field_project_exists and not self.check_field_project_exists():
            message = "No saved field_project feature found. Please ensure you have saved a field_project polygon."
            help_message = ("To create and draw a new ield_project polygon, go to:\n\n"
                            "'Plugins' -> 'CRAG' -> 'More...' -. 'Advanced...' -> 'Add Field Project'")

            message_bar = self.iface.messageBar().createMessage("CRAG", message)
            help_button = QPushButton(message_bar)
            help_button.setText("Help")
            help_button.pressed.connect(lambda: QMessageBox.information(None, "Information", help_message))
            message_bar.layout().addWidget(help_button)
            self.iface.messageBar().pushWidget(message_bar, Qgis.Warning)

            return False

        return True


    def open_local_filepath(self, filepath: Path) -> bool:
        """
        Open the given filepath with the OS native software.
        Returns a boolean indicating success of the process.
        """
        if not self.validate_qgis_state(project_active=True):
            return False

        if filepath.exists():
            QDesktopServices.openUrl(QUrl.fromLocalFile(str(filepath.absolute())))
            return True
        else:
            message = f"Could not find file: {filepath}"
            self.iface.messageBar().pushMessage("CRAG", message, Qgis.Warning, MESSAGE_BAR_TIME_LIMIT)
            return False


    def get_layer_label_rule(self, layer: str, label_description: str) -> QgsRuleBasedLabeling.Rule:
        """
        Get the Rule that is applied to generate the map label for the given layer, where QgsRuleBasedLabeling is used.
        NOTE: when modifying the expression of a label, the `rule.settings().fieldName` attribute should be used,
        not the `rule.settings().getLabelExpression().expression()` methods.
        If you try to change the expression with the latter, nothing happens,
        but if you use the former and include `rule.settings().isExpression = True`, it works as expected.
        """
        layer = self.get_crag_layer(layer)
        rule = [
            rule
            for rule in layer.labeling().rootRule().children()
            if rule.description() == label_description
        ][0]
        return rule


    def get_plugin_setting(self, name: str) -> Any:
        """
        Get the plugin setting with the given name from the QgsSettings.
        This will also try to convert the value from a string if required.
        Returns None if the value does not exist.
        """
        value = QgsSettings().value(f"{self.plugin_settings_prefix}/{name}", defaultValue=None)

        # If no setting is found
        if value is None:
            return value

        # Convert to bool
        bools = {
            "true": True,
            "false": False,
        }
        if isinstance(value, str) and value.lower() in bools:
            return bools[value.lower()]

        return value


    def set_plugin_setting(self, name: str, value: Any) -> None:
        """
        Save the given setting to the QgsSettings.
        """
        QgsSettings().setValue(f"{self.plugin_settings_prefix}/{name}", value)


    def get_unlinked_files(self, layer_name: str) -> list[Path]:
        """
        Get the unlinked files for the given layer.
        The given layer should be from: photos, media.
        Ignores files in the unlinked sub-directory.
        """
        attachment_dir = self.layers_to_dirs[layer_name]
        attachment_col = self.layers_to_file_attributes[layer_name]

        # First get actual recorded paths
        recorded_attachments = {
            Path(row[attachment_col])
            for row in get_table_rows(
                self.db_file,
                f"SELECT {attachment_col} FROM {layer_name}",  # nosec: B608 no user input
            )
            if row[attachment_col] is not None
        }

        unrecorded_attachments = [
            attachment
            for attachment in attachment_dir.rglob("*")
            if all((
                attachment.is_file(),
                attachment.relative_to(attachment_dir) not in recorded_attachments,
                attachment.name not in {self.placeholder_filename, self.bgs_placeholder_logo_filename},
            ))
        ]

        return unrecorded_attachments


    def create_bordered_frame(self) -> QFrame:
        """
        Create a QFrame with a styled border.
        """
        frame = QFrame()
        frame.setObjectName("MainFrame")
        frame.setFrameShape(QFrame.Shape.Panel)
        frame.setStyleSheet("#MainFrame { border: 1px solid silver; }")
        return frame


    def create_bold_label(self, text: str) -> QLabel:
        """
        Create a label with the given text in bold font.
        """
        font = QFont()
        font.setBold(True)
        label = QLabel(text)
        label.setFont(font)
        return label
