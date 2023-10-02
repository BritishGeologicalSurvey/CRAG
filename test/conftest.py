import sqlite3
import datetime as dt
from pathlib import Path
from typing import (
    Generator,
    Any,
)

import pytest
import etlhelper as etl

from create_gpkg_from_sql import main as gpkg_from_sql


@pytest.fixture()
def data_model_gpkg(tmp_path: Path) -> Generator[sqlite3.Connection, None, None]:
    """
    Create a connection to the test GeoPackage and enable spatialite.
    """
    # Create geopackage file
    db_file = tmp_path / "test_geopackage.gpkg"
    gpkg_from_sql(db_file=db_file)

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

    yield conn

    # Close database and delete geopackage file
    conn.close()
    db_file.unlink()


@pytest.fixture()
def locality_manmade_landform_dict_row() -> dict[str, Any]:
    return {"fid": 1, "objectid": None, "project_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "manmade_type_code": "b", "dip": 45, "dip_dir": 180, "length": None, "width": None, "comment": None,
            "user_entered": "c", "date_entered": dt.datetime.now(), "user_updated": None, "date_updated": None}


@pytest.fixture()
def locality_media_dict_row() -> dict[str, Any]:
    return {"fid": 1, "objectid": None, "project_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "media_type_code": "b", "media_link": "c", "comment": None, "user_entered": "d",
            "date_entered": dt.datetime.now(), "user_updated": None, "date_updated": None}


@pytest.fixture()
def locality_point_dict_row() -> dict[str, Any]:
    return {"fid": 1, "objectid": None, "uuid": "abc", "project_fuid": "a", "locality_name": None,
            "locality_description": None, "geological_note": None, "epsg_code": None, "geometry": None,
            "user_entered": "b", "date_entered": dt.datetime.now(), "user_updated": None, "date_updated": None}


@pytest.fixture()
def locality_sample_dict_row() -> dict[str, Any]:
    return {"fid": 1, "objectid": None, "project_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "sample_type_code": "b", "sample_description": None, "comment": None, "user_entered": "d",
            "date_entered": dt.datetime.now(), "user_updated": None, "date_updated": None}


@pytest.fixture()
def locality_structural_measurement_dict_row() -> dict[str, Any]:
    return {"fid": 1, "objectid": None, "project_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "structure_type_category": "b", "structure_type_code": "c", "dip": 45, "dip_direction": 180,
            "secondary_attrib": None, "third_attrib": None, "user_entered": "d",
            "date_entered": dt.datetime.now(), "user_updated": None, "date_updated": None}


@pytest.fixture()
def locality_superficial_landform_dict_row() -> dict[str, Any]:
    return {"fid": 1, "objectid": None, "project_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "superficial_type_category": "b", "superficial_type_code": "c", "dip": 45, "length": None, "width": None,
            "height_depth": None, "comment": None, "user_entered": "d", "date_entered": dt.datetime.now(),
            "user_updated": None, "date_updated": None}
