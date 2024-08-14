import logging
import sqlite3
from pathlib import Path
from typing import (
    Any,
    Optional,
)

from qgis.core import QgsProject
from qgis.PyQt.QtCore import QUrl
from qgis.PyQt.QtGui import QDesktopServices
from qgis.PyQt.QtWidgets import QMessageBox
from PyQt5.QtCore import pyqtRemoveInputHook

from .config import TABLE_LIST
from .create_gpkg_from_sql import WORKDIR


class FieldDataCaptureProject:
    """
    Base/Mixin class for basic attributes of the project file structure.
    """
    project_dir: Path
    gpkg_filename = Path("field-data-capture.gpkg")
    report_filename = Path("field-report.html")
    css_filename = Path("style.css")
    # Using locally downloaded woff2 of Google's Material Symbols Outlined font
    # See: https://fonts.google.com/icons
    # Licence: https://www.apache.org/licenses/LICENSE-2.0.html
    font_filename = Path("MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].woff2")


    @property
    def project_dir(self) -> Path:
        """
        Get the current project directory.
        """
        return Path(QgsProject.instance().readPath("./"))

    @property
    def db_file(self) -> Path:
        """
        Get the db file path from the current project.
        """
        return self.project_dir / self.gpkg_filename

    @property
    def styles_dir(self) -> Path:
        """
        Get the styles directory path from the current project.
        """
        return self.project_dir / "styles"

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
    def icons_dir(self) -> Path:
        """
        Get the icons directory path from the plugin folder.
        """
        return WORKDIR / "icons"

    @property
    def report_file(self) -> Path:
        """
        Get the field report file path from the current project.
        """
        return self.project_dir / self.report_filename

    @property
    def css_src_file(self) -> Path:
        """
        Get the ccs file path from the plugin folder.
        """
        return WORKDIR / "css" / self.css_filename

    @property
    def css_dest_dir(self) -> Path:
        """
        Get the ccs directory from the current project.
        """
        return self.project_dir / "css"

    @property
    def font_src_file(self) -> Path:
        """
        Get the font file path from the plugin folder.
        """
        return WORKDIR / "fonts" / self.font_filename

    @property
    def font_dest_dir(self) -> Path:
        """
        Get the ccs directory from the current project.
        """
        return self.project_dir / "fonts"

    @property
    def templates_dir(self) -> Path:
        """
        Get the Jinja2 template directory path from the plugin folder.
        """
        return WORKDIR / "templates"


    @staticmethod
    def project_is_active() -> bool:
        """
        Check if a saved project is currently open.
        """
        if QgsProject.instance().fileName() != '':
            return True
        else:
            QMessageBox.warning(None, "Warning", "Please open an existing saved project.")
            return False


    @staticmethod
    def check_layer_exists(layer_name: str) -> bool:
        """
        Check if a given layer name exists in the list of current layers.
        """
        if len(QgsProject.instance().mapLayersByName(layer_name)) > 0:
            return True
        else:
            return False


    @staticmethod
    def check_fdc_layers_exist() -> bool:
        """
        Check if the Field Data Capture layers exist in the current layers.
        """
        missing_layers = [
            table_name
            for table_name in TABLE_LIST
            if not FieldDataCaptureProject.check_layer_exists(table_name)
        ]
        if len(missing_layers) == 0:
            return True
        else:
            return False


    @staticmethod
    def check_field_project_exists() -> bool:
        """
        Check that the field_project layer has a saved feature.
        """
        layer_name = "field_project"
        # If the layer does not exist, it will have no features
        if not FieldDataCaptureProject.check_layer_exists(layer_name):
            return False

        field_project_layer = QgsProject.instance().mapLayersByName("field_project")[0]
        fp_features = list(field_project_layer.getFeatures())

        # If the number of features is less than 1 or the first feature has an unsaved fid value
        if len(fp_features) < 1 or fp_features[0].attribute("fid") == "Autogenerate":
            return False

        return True


    def validate_qgis_state(
        self,
        project_active: bool = False,
        db_file_exists: bool = False,
        fdc_layers_exist: bool = False,
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
            QMessageBox.warning(None, "Warning", f"Could not find file:\n\n{self.db_file}")
            return False

        # If we need to check the fdc_layers_exist and the fdc layers do not exist
        if fdc_layers_exist and not self.check_fdc_layers_exist():
            QMessageBox.warning(None, "Warning", "Could not find the required layers for Field Data Capture.")
            return False

        # If we need to check that a given layer_name_exists and the given layer name does not exist
        if layer_name_exists is not None and not self.check_layer_exists(layer_name_exists):
            QMessageBox.warning(None, "Warning", f"Could not find layer: {layer_name_exists}")
            return False

        # If we need to check that there is 1 saved field_project and there isn't 1
        if field_project_exists and not self.check_field_project_exists():
            QMessageBox.warning(
                None,
                "Warning",
                (
                    "No saved field_project feature found. Please ensure you have saved a field_project polygon.\n\n"
                    "To create and draw a new one, go to 'Plugins' -> 'Field Data Capture' -> 'Add Field Project'"
                )
            )
            return False

        return True


    def open_local_filepath(self, filepath: Path) -> bool:
        """
        Open the given filepath with the OS native software.
        Returns a boolean indicating success of the process.
        """
        if not self.validate_qgis_state(project_active=True, db_file_exists=True, fdc_layers_exist=True, field_project_exists=True):  # noqa
            return False

        if filepath.exists():
            QDesktopServices.openUrl(QUrl.fromLocalFile(str(filepath.absolute())))
            return True
        else:
            QMessageBox.warning(None, "File Not Found", f"Could not find file: {filepath}")
            return False


def get_table_rows(db_file: Path, sql: str) -> list[dict[str, Any]]:
    """
    Get the rows from the given database file using the given SQL query.
    The rows are created using a dictionary row factory.
    """
    def dict_factory(cursor, row):
        """
        See https://docs.python.org/3/library/sqlite3.html#sqlite3-howto-row-factory
        """
        fields = [column[0] for column in cursor.description]
        return {key: value for key, value in zip(fields, row)}

    rows = []
    with sqlite3.connect(db_file) as conn:
        conn.enable_load_extension(True)
        conn.execute("SELECT load_extension('mod_spatialite');")
        conn.row_factory = dict_factory
        cursor = conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
    conn.close()

    return rows


def ipdb_breakpoint():
    """
    Drops code into IPython debugger when QGIS is run from command line.
    Otherwise returns an error.  Press 'c' to *continue* running code.
    """
    try:
        import ipdb  # noqa - don't import at top level as isn't in default QGIS install

        # Switch off unwanted IPython loggers
        for lib in ('asyncio', 'parso'):
            logging.getLogger(lib).setLevel(logging.WARNING)

        pyqtRemoveInputHook()
        ipdb.set_trace()
    except ModuleNotFoundError:
        pass
