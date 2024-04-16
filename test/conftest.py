import sqlite3
from pathlib import Path
from typing import Generator

import pytest
import etlhelper as etl
from qgis.core import QgsProject
from qgis.gui import QgsAdvancedDigitizingDockWidget
from qgis.PyQt.QtWidgets import QMessageBox
from qgis.testing.mocked import get_iface

from plugin.create_gpkg_from_sql import main as gpkg_from_sql
from plugin.create_gpkg_from_sql import add_test_data
from plugin.field_data_capture import FieldDataCapture


def setup_db_conn(db_file: Path) -> sqlite3.Connection:
    """
    Setup the connection to the given database file.
    """
    # Create database connection
    db = etl.DbParams(dbtype="SQLITE", filename=db_file)
    conn = etl.connect(db)

    # Enable sqlite extensions and load spatialite
    conn.enable_load_extension(True)
    try:
        etl.execute("""SELECT load_extension("mod_spatialite")""", conn=conn)
    except etl.exceptions.ETLHelperQueryError:
        msg = "spatialite must be installed on the system to run these tests, see README for details"
        raise OSError(msg)

    return conn


@pytest.fixture()
def project_dir(tmp_path: Path) -> Path:
    """
    Project directory used across tests for file structure.
    """
    project_dir = tmp_path / "test_project_dir"
    project_dir.mkdir(parents=True, exist_ok=True)
    return project_dir


@pytest.fixture()
def data_model_gpkg(project_dir: Path) -> Generator[sqlite3.Connection, None, None]:
    """
    Create a connection to the test GeoPackage and enable spatialite.
    """
    # Create geopackage file
    db_file = project_dir / "field-data-capture.gpkg"
    gpkg_from_sql(db_file=db_file)

    conn = setup_db_conn(db_file)
    yield conn

    # Close database and delete geopackage file
    conn.close()
    db_file.unlink()


@pytest.fixture()
def test_data_gpkg(data_model_gpkg) -> sqlite3.Connection:
    add_test_data(data_model_gpkg)
    return data_model_gpkg


@pytest.fixture()
def fdc(monkeypatch: pytest.MonkeyPatch) -> Generator[FieldDataCapture, None, None]:
    """
    An instance of the FieldDataCapture plugin for tests, using a mock iface.
    Also uses monkeypatch to prevent basic QMessageBox popups, including information and warning.
    QMessageBoxes just return QMessageBox.Ok by default.
    """
    # Setup plugin
    iface = get_iface()
    field_data_capture = FieldDataCapture(iface)

    # Apply monkeypatch for QMessageBox
    message_types = [
        "information",
        "warning",
    ]
    for message_type in message_types:
        # Usually, QMessageBoxes prevent tests from progressing, as they require user input
        # To show a message, the code would usually be:
        # result = QMessageBox.warning(parent, title, message)
        # The monkeypatched version swallows the arguments and always returns QMessageBox.Ok
        monkeypatch.setattr(QMessageBox, message_type, lambda *args: QMessageBox.Ok)

    # Apply monkeypatch for unsaved edits message box because it is setup manually
    monkeypatch.setattr(QMessageBox, "exec_", lambda *args: True)
    monkeypatch.setattr(QMessageBox, "setIconPixmap", lambda *args: True)

    # Apply monkeypatch for iface.cadDockWidget
    cadDockWidget = QgsAdvancedDigitizingDockWidget(iface.mapCanvas())
    monkeypatch.setattr(iface, "cadDockWidget", lambda *args: cadDockWidget)

    yield field_data_capture

    # We disable the quick map tool after the test to avoid the automatic deactivation of the tool
    # from qgis causing an error with deleted c++ objects during teardown
    if field_data_capture.quick_map_tool is not None:
        field_data_capture.disable_current_quick_map_tool()
    # Reset the QGIS interface
    iface.reset_mock()


@pytest.fixture()
def qgs_project(project_dir: Path) -> Generator[Path, None, None]:
    """
    Create a QGIS project for testing.
    Returns the filepath for the project file within the project directory.
    """
    project_file = project_dir / "test_project.qgz"
    project = QgsProject.instance()
    # We have to convert the Path object to a string for PyGIS
    project.write(str(project_file))
    yield project_file
    # Close the project
    project.clear()


@pytest.fixture()
def monkeypatch_qmsgbox_question_yes(monkeypatch: pytest.MonkeyPatch) -> None:
    """
    A monkeypatch to prevent QMessageBox.question popups from showing during tests.
    Instead, calls to it will return QMessageBox.Yes.
    """
    monkeypatch.setattr(QMessageBox, "question", lambda *args: QMessageBox.Yes)


@pytest.fixture()
def monkeypatch_qmsgbox_question_no(monkeypatch: pytest.MonkeyPatch) -> None:
    """
    A monkeypatch to prevent QMessageBox.question popups from showing during tests.
    Instead, calls to it will return QMessageBox.No.
    """
    monkeypatch.setattr(QMessageBox, "question", lambda *args: QMessageBox.No)


@pytest.fixture()
def fdc_project(fdc: FieldDataCapture, qgs_project: Path):
    """
    Setup an Field Data Capture project for use in tests.
    Also runs fdc.initGui for button testing.
    """
    fdc.add_gpkg_to_project()
    fdc.add_gpkg_layers_to_project()
    fdc.add_test_data_to_project()
    fdc.initGui()
    return fdc
