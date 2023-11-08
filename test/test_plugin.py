"""
These are tests for the plugin which depend on a running QGIS version which is supplied by the 'fdc' fixture.
"""
from pathlib import Path

import etlhelper as etl

from conftest import setup_db_conn
from plugin.config import TABLE_LIST
from plugin.field_data_capture import (
    FieldDataCapture,
    gpkg_from_sql,
)


def test_instantiation(fdc):
    assert isinstance(fdc, FieldDataCapture)


def test_project_fixture(fdc: FieldDataCapture, qgs_project: Path):
    # Check the project directory
    assert qgs_project.exists()
    assert fdc.project_dir.name == "test_project_dir"
    # Check the qgz file
    files = list(fdc.project_dir.glob("*"))
    assert len(files) == 1
    assert files[0].name == "test_project.qgz"


def test_add_gpkg_to_project(fdc: FieldDataCapture, qgs_project: Path):
    # Act
    # Directly call the backend method rather than the front end method to avoid message boxes
    gpkg_from_sql(db_file=fdc.db_file)

    # Check file exists
    assert (fdc.project_dir / fdc.gpkg_filename).exists()

    # Check tables are in file
    conn = setup_db_conn(fdc.db_file)
    table_rows = etl.fetchall(
        "SELECT name FROM sqlite_schema",
        conn,
        row_factory=etl.row_factories.list_row_factory,
    )
    all_table_names = {row[0] for row in table_rows}
    expected_table_names = set(TABLE_LIST)
    assert expected_table_names.issubset(all_table_names)
