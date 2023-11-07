import sqlite3
from typing import Optional

import pytest
import etlhelper as etl

from plugin.config import (
    ATTRIBUTE_TABLES,
    DICTIONARIES,
    FEATURE_TABLES,
    VIEWS
)

COLUMN_CONSTRAINTS = {
    # column_name: constraint
    "fid": "INTEGER NOT NULL,",  # include the comma to ensure extra constraints aren't added
    "objectid": "INTEGER UNIQUE",
    "uuid": "TEXT NOT NULL UNIQUE",
    "user_entered": "TEXT NOT NULL",
    "date_entered": "DATETIME NOT NULL",
}


def test_data_loading(test_data_gpkg):
    # Testing that the fixutre works
    assert True


@pytest.mark.parametrize(
    ["tables", "expected_col_names"],
    [
        (   # Spatial (feature) tables
            FEATURE_TABLES,
            {"fid", "objectid", "uuid", "geometry", "comment", "user_entered", "date_entered", "user_updated",
             "date_updated"},
        ),
        (   # Non-spatial (attribute) tables
            ATTRIBUTE_TABLES,
            {"fid", "objectid", "uuid", "comment", "user_entered", "date_entered", "user_updated", "date_updated"},
        ),
        (   # Dictionary tables
            DICTIONARIES,
            {"fid", "code", "description", "translation"},
        ),
    ],
)
def test_data_model_columns(
    data_model_gpkg: sqlite3.Connection,
    tables: set[str],
    expected_col_names: set[str],
):
    for table in tables:
        # Act
        table_info = etl.table_info(table=table, conn=data_model_gpkg)
        all_col_names = [col.name for col in table_info]

        # Only get the columns from the actual list of columns that we want to check
        check_col_names = {col_name for col_name in all_col_names if col_name in expected_col_names}
        # Assert names are correct
        assert check_col_names == expected_col_names

        assert_column_constraints(data_model_gpkg, table)


def assert_column_constraints(
    data_model_gpkg: sqlite3.Connection,
    table: str,
) -> None:
    """
    Assert that the required columns in the given table have applied the correct constraints.
    """
    create_sql: str = etl.fetchone(
        'select sql from sqlite_schema where type="table" and tbl_name=?',
        data_model_gpkg, parameters=(table,)
    ).sql

    # Translate tabs to spaces
    create_sql = create_sql.replace("\t", " ")

    for col_name, col_constraints in COLUMN_CONSTRAINTS.items():

        # Don't check the constraints for dic tables on uuid and objectid
        if table.startswith("dic_") and col_name in ["uuid", "objectid"]:
            continue

        search_str = f'"{col_name}" {col_constraints}'
        assert search_str in create_sql

    assert 'PRIMARY KEY("fid" AUTOINCREMENT)' in create_sql


@pytest.mark.parametrize(
    ["table", "field", "value", "error_message"],
    [
        # Table: manmade_landform
        ("manmade_landform", "dip", 0, None),
        ("manmade_landform", "dip", 90, None),
        ("manmade_landform", "dip", -1, "CHECK constraint failed: dip"),
        ("manmade_landform", "dip", 91, "CHECK constraint failed: dip"),
        ("manmade_landform", "dip_direction", 0, None),
        ("manmade_landform", "dip_direction", 359, None),
        ("manmade_landform", "dip_direction", -1, "CHECK constraint failed: dip_direction"),
        ("manmade_landform", "dip_direction", 360, "CHECK constraint failed: dip_direction"),

        # Table: structural_measurement
        ("structural_measurement", "dip", 0, None),
        ("structural_measurement", "dip", 90, None),
        ("structural_measurement", "dip", -1, "CHECK constraint failed: dip"),
        ("structural_measurement", "dip", 91, "CHECK constraint failed: dip"),
        ("structural_measurement", "dip_direction", 0, None),
        ("structural_measurement", "dip_direction", 359, None),
        ("structural_measurement", "dip_direction", -1, "CHECK constraint failed: dip_direction"),
        ("structural_measurement", "dip_direction", 360, "CHECK constraint failed: dip_direction"),

        # Table: superficial_landform
        ("superficial_landform", "dip", 0, None),
        ("superficial_landform", "dip", 90, None),
        ("superficial_landform", "dip", -1, "CHECK constraint failed: dip"),
        ("superficial_landform", "dip", 91, "CHECK constraint failed: dip"),
    ],
)
def test_data_model_columns_constraints(
    test_data_gpkg: sqlite3.Connection,
    table: str,
    field: str,
    value: int,
    error_message: Optional[str],
):
    # Arrange
    # Get the dict row fixture for the given table
    update_sql = f'UPDATE {table} SET "{field}"={value} WHERE fid=1'

    # Act
    if error_message is None:
        # Inserting the row should not raise an error
        etl.execute(update_sql, test_data_gpkg)
    else:
        # Check that the correct error is raised
        with pytest.raises(etl.exceptions.ETLHelperQueryError) as excinfo:
            etl.execute(update_sql, test_data_gpkg)

        # Assert
        assert error_message in str(excinfo.value)


def test_gpkg_contents(data_model_gpkg: sqlite3.Connection):
    # Arrange
    expected_contents = [(table, "features") for table in FEATURE_TABLES]
    expected_contents += [(table, "features") for table in VIEWS]
    expected_contents += [(table, "attributes") for table in ATTRIBUTE_TABLES]
    expected_contents += [(table, "attributes") for table in DICTIONARIES]

    # Act
    query = """
        SELECT
            table_name,
            data_type
        FROM
            gpkg_contents
        ORDER BY
            data_type ASC,
            table_name ASC
    """
    actual_contents = etl.fetchall(query, conn=data_model_gpkg,
                                   row_factory=etl.row_factories.tuple_row_factory)

    # Assert
    assert sorted(actual_contents) == sorted(expected_contents)


@pytest.mark.parametrize("view", VIEWS)
def test_views(
    data_model_gpkg: sqlite3.Connection,
    view: str
):
    # Arrange
    query = f"SELECT * FROM {view}"

    # Act
    # Simplest check is that the view can be called without raising an error
    result = etl.fetchall(query, conn=data_model_gpkg)

    # Assert
    assert isinstance(result, list)

    # Check that required columns are in the view
    view_info = etl.table_info(table=view, conn=data_model_gpkg)
    all_col_names = {col.name for col in view_info}
    required_cols = {"project", "locality_point", "locality_uuid", "x", "y"}
    assert required_cols.issubset(all_col_names)


def test_clear_updated_trigger(data_model_gpkg: sqlite3.Connection):
    # Act
    # Insert a new project row with user_updated and date_updated values
    data_model_gpkg.execute("INSERT INTO project VALUES(1,NULL,'{d57614a8-21ba-47a5-8cb6-82c0b009ec1b}','test_project','test project title','test project description','test_user','active','2023-01-01','2023-12-31','DESK',27700,'test project comment','colb','2023-10-31T16:20:11.012','colb','2023-10-31T16:20:11.012')")  # noqa

    # Assert
    # Check that the user_updated and date_updated values are both NULL
    insert_result = etl.fetchone(
        "SELECT user_updated, date_updated FROM project WHERE fid = 1",
        data_model_gpkg,
        row_factory=etl.row_factories.tuple_row_factory,
    )
    assert insert_result == (None, None)

    # Act 2
    # Update the existing project to include new user_updated and date_updated values
    data_model_gpkg.execute("UPDATE project SET user_updated = 'leorud', date_updated = '2023-11-31T16:20:11.012'")

    # Assert
    # Check that the user_updated and date_updated values are both complete
    update_result = etl.fetchone(
        "SELECT user_updated, date_updated FROM project WHERE fid = 1",
        data_model_gpkg,
        row_factory=etl.row_factories.tuple_row_factory,
    )
    assert update_result == ("leorud", "2023-11-31T16:20:11.012")
