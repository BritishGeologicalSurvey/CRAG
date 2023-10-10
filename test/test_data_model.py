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
        "dic_exposure_type",
        "dic_rock_all",
        "dic_project_type",
        "dic_manmade_code",
        "dic_media",
        "dic_sample",
        "dic_structure_category",
        "dic_structure_code",
        "dic_superficial_category",
        "dic_superficial_code",
        # Attributes
        "exposure",
        "manmade_landform",
        "media",
        "photo",
        "sample",
        "structural_measurement",
        "superficial_landform",
        # Metadata
        "project",
    ]
}


@pytest.mark.parametrize(
    ["tables", "expected_col_names"],
    [
        (   # Spatial (feature) tables
            {"locality_point"},
            {"fid", "objectid", "uuid", "geometry", "comment", "user_entered", "date_entered", "user_updated", "date_updated"},
        ),
        (   # Non-spatial (attribute) tables
            {"exposure", "manmade_landform", "media", "photo", "sample", "structural_measurement",
             "superficial_landform"},
            {"fid", "objectid", "uuid", "comment", "user_entered", "date_entered", "user_updated", "date_updated"},
        ),
        (   # Dictionary tables
            {"dic_exposure_type", "dic_rock_all", "dic_project_type", "dic_manmade_code", "dic_media", "dic_sample", "dic_structure_category",
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
        ("manmade_landform",),
        ("exposure",),
        ("media",),
        ("photo",),
        ("locality_point",),
        ("sample",),
        ("structural_measurement",),
        ("superficial_landform",),
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


@pytest.mark.parametrize(
        ["table"],
        [
            (table,) for table in TABLES['attributes']
            if table.startswith('dic_')
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
    expected_contents = [
        ["dic_exposure_type", "attributes"],
        ["dic_manmade_code", "attributes"],
        ["dic_media", "attributes"],
        ["dic_project_type", "attributes"],
        ["dic_rock_all", "attributes"],
        ["dic_sample", "attributes"],
        ["dic_structure_category", "attributes"],
        ["dic_structure_code", "attributes"],
        ["dic_superficial_category", "attributes"],
        ["dic_superficial_code", "attributes"],
        ["exposure", "attributes"],
        ["manmade_landform", "attributes"],
        ["media", "attributes"],
        ["photo", "attributes"],
        ["project", "attributes"],
        ["sample", "attributes"],
        ["structural_measurement", "attributes"],
        ["superficial_landform", "attributes"],
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
