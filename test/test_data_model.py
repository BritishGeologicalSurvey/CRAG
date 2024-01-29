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
    # The following only appear in individual tables
    "structure_type_code": "TEXT NOT NULL",
    "manmade_type_code": "TEXT NOT NULL",
    "lithology_code": "TEXT NOT NULL",
    "media_type_code": "TEXT NOT NULL",
    "photo_file": "TEXT NOT NULL",
    "sample_id": "TEXT NOT NULL",
    "sample_type_code": "TEXT NOT NULL",
    "superficial_type_code": "TEXT NOT NULL",
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

        # Only assert a constraint if the column name is in the table definition
        if col_name in create_sql:
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
        # Test NOT NULL constraint here, instead of with columns_constraints, because doesn't apply to all tables
        ("structural_measurement", "dip", None,
         "NOT NULL constraint failed: structural_measurement.dip"),
        ("structural_measurement", "dip_direction", None,
         "NOT NULL constraint failed: structural_measurement.dip_direction"),

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
    update_sql = f'UPDATE {table} SET {field}=? WHERE fid=1'

    # Act
    if error_message is None:
        # Inserting the row should not raise an error
        etl.execute(update_sql, test_data_gpkg, parameters=(value,))
    else:
        # Check that the correct error is raised
        with pytest.raises(etl.exceptions.ETLHelperQueryError) as excinfo:
            etl.execute(update_sql, test_data_gpkg, parameters=(value,))

        # Assert
        assert error_message in str(excinfo.value)


def test_gpkg_contents(data_model_gpkg: sqlite3.Connection):
    # Arrange
    expected_contents = [(table, "features") for table in FEATURE_TABLES]
    expected_contents += [(table, "features") for table in VIEWS
                          if table != "view_next_locality_id"]
    expected_contents += [(table, "attributes") for table in ATTRIBUTE_TABLES | {"view_next_locality_id"}]
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


@pytest.mark.parametrize("view", [view for view in VIEWS if view != "view_next_locality_id"])
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
    required_cols = {"field_project", "locality_point", "locality_uuid", "x", "y"}
    assert required_cols.issubset(all_col_names)


def test_view_next_locality_id(test_data_gpkg: sqlite3.Connection):
    # Arrange
    expected_1 = [("test_point", "test_point_003")]
    expected_2 = [("test_point", "test_point_003")]
    expected_3 = []

    # Act
    query = "SELECT * FROM view_next_locality_id"

    # Act 1
    result_1 = etl.fetchall(query, conn=test_data_gpkg, row_factory=etl.row_factories.tuple_row_factory)
    # Assert 1
    assert result_1 == expected_1

    # Act 2
    # Delete 'test_point_001', the next ID increment should remain the same because 'test_point_002' is the max
    etl.execute("DELETE FROM locality_point WHERE name = 'test_point_001'", conn=test_data_gpkg)
    result_2 = etl.fetchall(query, conn=test_data_gpkg, row_factory=etl.row_factories.tuple_row_factory)
    # Assert 2
    assert result_2 == expected_2

    # Act 3
    # Delete 'test_point_002', now there should be no next ID increment because there are no points left
    etl.execute("DELETE FROM locality_point WHERE name = 'test_point_002'", conn=test_data_gpkg)
    result_3 = etl.fetchall(query, conn=test_data_gpkg, row_factory=etl.row_factories.tuple_row_factory)
    # Assert 3
    assert result_3 == expected_3


@pytest.mark.parametrize('table', FEATURE_TABLES | ATTRIBUTE_TABLES)
def test_clear_update_field_on_insert_trigger(test_data_gpkg: sqlite3.Connection, table: str):
    # The script that loads test data inserts values for the user_updated and date_updated fields.
    # The table_clear_updated triggers fire for inserts, so these values should have been cleared.
    insert_result = etl.fetchone(
        f"SELECT user_updated, date_updated FROM {table} WHERE fid = 1",
        test_data_gpkg,
        row_factory=etl.row_factories.tuple_row_factory,
    )

    assert insert_result == (None, None)

    # Next we confirm that the trigger doesn't fire for updates
    # Update the existing project to include new user_updated and date_updated values
    etl.execute(
        f"UPDATE {table} SET user_updated = 'leorud', date_updated = '2023-11-31T16:20:11.012'",
        test_data_gpkg
    )

    # Assert that data were not wiped
    update_result = etl.fetchone(
        f"SELECT user_updated, date_updated FROM {table} WHERE fid = 1",
        test_data_gpkg,
        row_factory=etl.row_factories.tuple_row_factory,
    )

    assert update_result == ("leorud", "2023-11-31T16:20:11.012")
