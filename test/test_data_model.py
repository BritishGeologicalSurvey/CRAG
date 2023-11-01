import sqlite3
from typing import (
    Optional,
    Any,
)

import pytest
import etlhelper as etl

from plugin.config import (
    ATTRIBUTE_TABLES,
    DICTIONARIES,
    FEATURE_TABLES,
    VIEWS
)


def test_data_loading(test_data_gpkg):
    assert True


@pytest.mark.parametrize(
    ["tables", "expected_col_names"],
    [
        (   # Spatial (feature) tables
            FEATURE_TABLES,
            {"fid", "objectid", "uuid", "geometry", "comment", "user_entered", "date_entered", "user_updated",
             "date_updated"},
        ),
        (   # Spatial views
            VIEWS,
            {"project", "locality_point", "locality_uuid", "x", "y"},
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
        # Table: manmade_landform
        ("manmade_landform", {"dip": 0}, None),
        ("manmade_landform", {"dip": 90}, None),
        ("manmade_landform", {"dip": -1}, "CHECK constraint failed: dip"),
        ("manmade_landform", {"dip": 91}, "CHECK constraint failed: dip"),

        # Table: structural_measurement
        ("structural_measurement", {"dip": 0}, None),
        ("structural_measurement", {"dip": 90}, None),
        ("structural_measurement", {"dip": -1}, "CHECK constraint failed: dip"),
        ("structural_measurement", {"dip": 91}, "CHECK constraint failed: dip"),
        ("structural_measurement", {"dip_direction": 0}, None),
        ("structural_measurement", {"dip_direction": 359}, None),
        ("structural_measurement", {"dip_direction": -1}, "CHECK constraint failed: dip_direction"),
        ("structural_measurement", {"dip_direction": 360}, "CHECK constraint failed: dip_direction"),

        # Table: superficial_landform
        ("superficial_landform", {"dip": 0}, None),
        ("superficial_landform", {"dip": 90}, None),
        ("superficial_landform", {"dip": -1}, "CHECK constraint failed: dip"),
        ("superficial_landform", {"dip": 91}, "CHECK constraint failed: dip"),
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
        (table,) for table in FEATURE_TABLES.union(ATTRIBUTE_TABLES)
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

    # This is a hack to cope with project data also requiring a unique short name
    # It will change when we get proper test data and stop using the fixtures
    if table == "project":
        for row in rows:
            row["short_name"] = str(row["fid"])

    # Act
    # Check that the correct error is raised
    with pytest.raises(etl.exceptions.ETLHelperInsertError) as excinfo:
        etl.load(table=table, conn=data_model_gpkg, rows=rows)

    # Assert
    assert expected_string in str(excinfo.value)


@pytest.mark.parametrize(
        ["table"],
        [
            (table,) for table in DICTIONARIES
        ],
)
def test_dic_constraints(
    data_model_gpkg: sqlite3.Connection,
    table: str,
):
    # Arrange
    # TODO: update tests when new dictionary format is decided
    not_null_columns = {"fid", "code", "user_entered", "date_entered"}

    # Test not-null columns
    # Act and assert
    for column in etl.table_info(table, data_model_gpkg):
        if column.name in not_null_columns:
            assert column.not_null, f"{table}.{column.name} is missing not null constraint"

    # Test unique constraint on "fid" and "code"
    # Arrange
    first_row = etl.fetchone(f"SELECT * FROM {table} ORDER BY fid LIMIT 1",
                             data_model_gpkg, row_factory=etl.row_factories.dict_row_factory)

    # Act and assert
    duplicate_fid = first_row.copy()
    duplicate_fid.update({"code": "this code does not exist"})
    with pytest.raises(etl.exceptions.ETLHelperInsertError) as excinfo:
        etl.load(table=table, conn=data_model_gpkg, rows=[duplicate_fid])
    assert f"UNIQUE constraint failed: {table}.fid" in str(excinfo.value)

    duplicate_code = first_row.copy()
    duplicate_code.update({"fid": -1})
    with pytest.raises(etl.exceptions.ETLHelperInsertError) as excinfo:
        etl.load(table=table, conn=data_model_gpkg, rows=[duplicate_code])
    assert f"UNIQUE constraint failed: {table}.code" in str(excinfo.value)


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
def test_views_are_callable(data_model_gpkg: sqlite3.Connection,
                            view: str):
    # Arrange
    query = f"SELECT * FROM {view}"

    # Act
    # Simplest check is that the view can be called without raising an error
    result = etl.fetchall(query, conn=data_model_gpkg)

    # Assert
    assert isinstance(result, list)
