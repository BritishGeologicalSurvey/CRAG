import sqlite3
from pathlib import Path
from typing import Generator
from unittest.mock import Mock

import pytest
import etlhelper as etl
from qgis.core import QgsProject
from qgis.gui import QgsAdvancedDigitizingDockWidget
from qgis.PyQt.QtWidgets import QMessageBox
from qgis.testing.mocked import get_iface

from plugin.config import TABLE_LIST
from plugin.create_gpkg_from_sql import main as gpkg_from_sql
from plugin.create_gpkg_from_sql import add_test_data
from plugin.field_data_capture import FieldDataCapture
from plugin.line_layer_selector import LineLayerSelector
from plugin.photo_importer import PhotoImporter
from plugin.quick_map_tools import QuickMapToolBase
from plugin.report_builder import ReportBuilder


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


def create_fdc_project_files(
    project_dir: Path,
    insert_data_sql: Path,
    feature_filepaths: dict[str, list[Path]],
) -> None:
    """
    Create a project in the given directory,
    with a database which is populated with the given SQL,
    that contains some data and photo files.
    The first of each of the feature_files is placed into a sub directory.

    The feature_filepaths should follow the following format:

    feature_filepaths = {
        "photos": [
            Path("test/data/photos/exif_data.jpg"),
            Path("test/data/photos/no_exif_data.jpg"),
        ],
        "media": [],
    }
    """
    # Make the project directory
    project_dir.mkdir(exist_ok=True)

    # Make database file
    db_file = project_dir / "field-data-capture.gpkg"
    gpkg_from_sql(db_file=db_file)
    with setup_db_conn(db_file) as conn:
        conn.executescript(insert_data_sql.read_text())

    for feature_dir, feature_files in feature_filepaths.items():
        project_feature_dir = project_dir / feature_dir
        project_feature_dir.mkdir(exist_ok=True)

        for idx, feature_file in enumerate(feature_files):
            # Put the first file into a sub directory of the feature directory to ensure it is still copied
            if idx == 0:
                new_feature_file = project_feature_dir / "sub_dir" / feature_file.name
                new_feature_file.parent.mkdir(parents=True, exist_ok=True)
            else:
                new_feature_file = project_feature_dir / feature_file.name
            new_feature_file.write_bytes(feature_file.read_bytes())

    return project_dir


def locality_point_count(fdc: FieldDataCapture) -> int:
    """
    Helper function to get number of locality_points
    """
    conn = setup_db_conn(fdc.db_file)
    row_count = etl.fetchone(
        "SELECT COUNT() FROM locality_point",
        conn,
        row_factory=etl.row_factories.tuple_row_factory,
    )[0]
    return row_count


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
    Also runs fdc.initGui for button testing.
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
        "critical",
    ]
    for message_type in message_types:
        # Usually, QMessageBoxes prevent tests from progressing, as they require user input
        # To show a message, the code would usually be:
        # result = QMessageBox.warning(parent, title, message)
        # The monkeypatched version swallows the arguments and always returns QMessageBox.Ok through a Mock object
        qmsgbox_mock = Mock(return_value=QMessageBox.Ok)
        monkeypatch.setattr(QMessageBox, message_type, qmsgbox_mock)

    # Apply monkeypatch for unsaved edits message box because it is setup manually
    monkeypatch.setattr(QMessageBox, "exec", lambda *args: True)
    monkeypatch.setattr(QMessageBox, "setIconPixmap", lambda *args: True)

    # Apply monkeypatch for iface.cadDockWidget
    cadDockWidget = QgsAdvancedDigitizingDockWidget(iface.mapCanvas())
    monkeypatch.setattr(iface, "cadDockWidget", lambda *args: cadDockWidget)

    # Apply monkeypatch for getting plugin metadata in QuickMapTools
    monkeypatch.setattr(QuickMapToolBase, "get_local_version", lambda *args: "fdc_test_fixture")

    # Apply monkeypatch for LineLayerSelector
    monkeypatch.setattr(LineLayerSelector, "exec", Mock())

    # Apply monkeypatch for searching GUI elements in QuickMapTools
    monkeypatch.setattr(
        QuickMapToolBase,
        "recursive_find_selection_model_indexes",
        lambda *args, **kwargs: {table: None for table in TABLE_LIST},
    )
    monkeypatch.setattr(iface, "layerTreeView", lambda *args: Mock())

    # Apply monkeypatch for PhotoImporter
    monkeypatch.setattr(PhotoImporter, "exec", lambda *args: True)

    field_data_capture.initGui()

    yield field_data_capture

    # We disable the quick map tool after the test to avoid the automatic deactivation of the tool
    # from qgis causing an error with deleted c++ objects during teardown
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
def fdc_project(fdc: FieldDataCapture, qgs_project: Path) -> FieldDataCapture:
    """
    Setup an Field Data Capture project for use in tests.
    """
    fdc.add_gpkg_to_project()
    fdc.add_gpkg_layers_to_project()
    fdc.add_test_data_to_project()
    return fdc


@pytest.fixture()
def report_builder(fdc_project: FieldDataCapture) -> ReportBuilder:
    """
    Setup Report Builder for use in tests.
    """
    report_builder = ReportBuilder(fdc_project.project_dir, fdc_project.db_file)

    return report_builder
