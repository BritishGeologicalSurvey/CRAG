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
