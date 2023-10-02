import datetime as dt
import sqlite3
from typing import (
    Optional,
    Any,
)

import pytest
import etlhelper as etl

TABLES = {
    "features": [
        "locality_point",
    ],
    "attributes": [
        # Dictionaries
        "dic_activity",
        "dic_manmade_code",
        "dic_media",
        "dic_sample",
        "dic_structure_category",
        "dic_structure_code",
        "dic_superficial_category",
        "dic_superficial_code",
        # Attributes
        "locality_manmade_landform",
        "locality_media",
        "locality_sample",
        "locality_structural_measurement",
        "locality_superficial_landform",
        # Metadata
        "activity",
        "user_details",
    ]
}


@pytest.mark.parametrize(
    ["tables", "expected_col_names"],
    [
        (   # Spatial (feature) tables
            {"locality_point"},
            {"fid", "objectid", "uuid", "geometry", "user_entered", "date_entered", "user_updated", "date_updated"},
        ),
        (   # Non-spatial (attribute) tables
            {"locality_manmade_landform", "locality_media", "locality_sample", "locality_structural_measurement",
             "locality_superficial_landform"},
            {"fid", "objectid", "uuid", "user_entered", "date_entered", "user_updated", "date_updated"},
        ),
        (   # Dictionary tables
            {"dic_activity", "dic_manmade_code", "dic_media", "dic_sample", "dic_structure_category",
             "dic_structure_code", "dic_superficial_category", "dic_superficial_code"},
            {"fid", "code", "description", "translation"},
        ),
    ],
)
def test_data_model_columns_exist(
    data_model_gpkg: sqlite3.Connection,
    tables: set[str],
    expected_col_names: set[str],
):
    for table in tables:
        # Act
        table_info = etl.table_info(table=table, conn=data_model_gpkg)
        # Only get the columns from the actual list of columns that we want to check
        check_cols = [col for col in table_info if col.name in expected_col_names]
        check_col_names = {col.name for col in check_cols}

        # Assert
        assert check_col_names == expected_col_names


@pytest.mark.parametrize(
    ["table", "new_data", "expected_string"],
    [
        # Table: locality_manmade_landform
        ("locality_manmade_landform", {"dip": 0}, None),
        ("locality_manmade_landform", {"dip": 90}, None),
        ("locality_manmade_landform", {"dip": -1}, "CHECK constraint failed: dip"),
        ("locality_manmade_landform", {"dip": 91}, "CHECK constraint failed: dip"),

        # Table: locality_structural_measurement
        ("locality_structural_measurement", {"dip": 0}, None),
        ("locality_structural_measurement", {"dip": 90}, None),
        ("locality_structural_measurement", {"dip": -1}, "CHECK constraint failed: dip"),
        ("locality_structural_measurement", {"dip": 91}, "CHECK constraint failed: dip"),
        ("locality_structural_measurement", {"dip_direction": 0}, None),
        ("locality_structural_measurement", {"dip_direction": 359}, None),
        ("locality_structural_measurement", {"dip_direction": -1}, "CHECK constraint failed: dip_direction"),
        ("locality_structural_measurement", {"dip_direction": 360}, "CHECK constraint failed: dip_direction"),

        # Table: locality_superficial_landform
        ("locality_superficial_landform", {"dip": 0}, None),
        ("locality_superficial_landform", {"dip": 90}, None),
        ("locality_superficial_landform", {"dip": -1}, "CHECK constraint failed: dip"),
        ("locality_superficial_landform", {"dip": 91}, "CHECK constraint failed: dip"),
    ],
)
def test_data_model_columns_constraints(
    request: pytest.FixtureRequest,
    data_model_gpkg: sqlite3.Connection,
    table: str,
    new_data: dict[str, Any],
    expected_string: Optional[str],
):
    # Arrange
    # Get the dict row fixture for the given table
    row: dict[str, Any] = request.getfixturevalue(table + "_dict_row")
    row.update(new_data)
    rows = [row]

    # Act
    if expected_string is not None:
        # Check that the correct error is raised
        with pytest.raises(etl.exceptions.ETLHelperInsertError) as excinfo:
            etl.load(table=table, conn=data_model_gpkg, rows=rows)

        # Assert
        assert expected_string in str(excinfo.value)
    else:
        # Inserting the row should not raise an error
        etl.load(table=table, conn=data_model_gpkg, rows=rows)


@pytest.mark.parametrize(
    ["table"],
    [
        ("locality_manmade_landform",),
        ("locality_media",),
        ("locality_point",),
        ("locality_sample",),
        ("locality_structural_measurement",),
        ("locality_superficial_landform",),
    ],
)
def test_data_model_columns_uuid_unique(
    request: pytest.FixtureRequest,
    data_model_gpkg: sqlite3.Connection,
    table: str,
):
    # Arrange
    # Get the dict row fixture for the given table
    row: dict[str, Any] = request.getfixturevalue(table + "_dict_row")
    expected_string = f"UNIQUE constraint failed: {table}.uuid"

    # Create a list of multiple rows
    # Replace the fid so that it is unique, but leave the uuid the same so that they will be duplicates
    rows = [
        {**row, **{"fid": x}}
        for x in range(3)
    ]

    # Act
    # Check that the correct error is raised
    with pytest.raises(etl.exceptions.ETLHelperInsertError) as excinfo:
        etl.load(table=table, conn=data_model_gpkg, rows=rows)

    # Assert
    assert expected_string in str(excinfo.value)


@pytest.mark.parametrize(["table"],
    [(table,) for table in TABLES['attributes'] if table.startswith('dic_') ],
)
def test_dic_constraints(
    data_model_gpkg: sqlite3.Connection,
    table: str,
):
    # Arrange
    # TODO: update tests when new dictionary format is decided
    not_null_columns = {"fid", "code", "user_entered", "date_entered"}

    # Act and assert
    for column in etl.table_info(table, data_model_gpkg):
        if column.name in not_null_columns:
            assert column.not_null, f"{table}.{column.name} is missing not null constraint"

    # TODO: add tests for unique constraint on "code" column.
    minimal_row = {
        "fid": 1,
        "code": "repeated value",
        "description": "test_description",
        "user_entered": "test_user",
        "date_entered": dt.date.today()
    }


def test_gpkg_contents(data_model_gpkg: sqlite3.Connection):
    # Arrange
    expected_contents = [
        ["activity", "attributes"],
        ["dic_activity", "attributes"],
        ["dic_manmade_code", "attributes"],
        ["dic_media", "attributes"],
        ["dic_sample", "attributes"],
        ["dic_structure_category", "attributes"],
        ["dic_structure_code", "attributes"],
        ["dic_superficial_category", "attributes"],
        ["dic_superficial_code", "attributes"],
        ["locality_manmade_landform", "attributes"],
        ["locality_media", "attributes"],
        ["locality_sample", "attributes"],
        ["locality_structural_measurement", "attributes"],
        ["locality_superficial_landform", "attributes"],
        ["user_details", "attributes"],
        ["locality_point", "features"],
    ]

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
    actual_contents = etl.fetchall(query, conn=data_model_gpkg, row_factory=etl.row_factories.list_row_factory)

    # Assert
    assert actual_contents == expected_contents
