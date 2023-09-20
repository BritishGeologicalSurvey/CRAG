import datetime as dt
from pathlib import Path

import pytest
import etlhelper as etl

from create_gpkg_from_sql import main as gpkg_from_sql


@pytest.fixture()
def data_model_gpkg(tmp_path: Path):
    # Create geopackage file
    db_file = tmp_path / "test_geopackage.gpkg"
    gpkg_from_sql(db_file=db_file)

    # Create database connection
    db = etl.DbParams(dbtype="SQLITE", filename=db_file)
    conn = etl.connect(db)
    yield conn

    # Close database and delete geopackage file
    conn.close()
    db_file.unlink()


@pytest.fixture()
def locality_manmade_landform_dict_row():
    return {"fid": 1, "objectid": None, "activity_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "manmade_type_code": "b", "dip": 45, "dip_dir": 180, "length": None, "width": None, "comment": None,
            "user_entered": "c", "date_entered": dt.datetime.now(), "user_updated": None, "date_updated": None}


@pytest.fixture()
def locality_structural_measurement_dict_row():
    return {"fid": 1, "objectid": None, "activity_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "structure_type_category": "b", "structure_type_code": "c", "dip": 45, "dip_direction": 180,
            "secondary_attrib": None, "third_attrib": None, "user_entered": "d",
            "date_entered": dt.datetime.now(), "user_updated": None, "date_updated": None}


@pytest.fixture()
def locality_superficial_landform_dict_row():
    return {"fid": 1, "objectid": None, "activity_fuid": None, "locality_fuid": "a", "uuid": "abc",
            "superficial_type_category": "b", "superficial_type_code": "c", "dip": 45, "length": None, "width": None,
            "height_depth": None, "comment": None, "user_entered": "d", "date_entered": dt.datetime.now(),
            "user_updated": None, "date_updated": None}
