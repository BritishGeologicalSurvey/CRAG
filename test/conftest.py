import sqlite3
from pathlib import Path
from typing import Generator

import pytest
import etlhelper as etl
from qgis.core import QgsProject
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
def test_data_gpkg(data_model_gpkg):
    add_test_data(data_model_gpkg)
    yield data_model_gpkg


@pytest.fixture()
def fdc() -> FieldDataCapture:
    """
    An instance of the FieldDataCapture plugin for tests, using a mock iface.
    """
    return FieldDataCapture(get_iface())


@pytest.fixture()
def qgs_project(project_dir: Path) -> Path:
    """
    Create a QGIS project for testing.
    Returns the filepath for the project file within the project directory.
    """
    project_file = project_dir / "test_project.qgz"
    # We have to convert the Path object to a string for PyGIS
    QgsProject.instance().write(str(project_file))
    return project_file
