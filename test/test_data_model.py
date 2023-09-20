from typing import (
    Optional,
    Any,
)

import pytest
import etlhelper as etl


@pytest.mark.parametrize(
    ["tables", "expected_col_names"],
    [
        (   # Spatial (feature) tables
            ["locality_point"],
            ["fid", "objectid", "uuid", "geometry", "user_entered", "date_entered", "user_updated", "date_updated"],
        ),
        (   # Non-spatial (attribute) tables
            ["locality_manmade_landform", "locality_media", "locality_sample", "locality_structural_measurement",
             "locality_superficial_landform"],
            ["fid", "objectid", "uuid", "user_entered", "date_entered", "user_updated", "date_updated"],
        ),
        (   # Dictionary tables
            ["dic_activity", "dic_manmade_code", "dic_media", "dic_sample", "dic_structure_category",
             "dic_structure_code", "dic_structure_secondary", "dic_structure_third", "dic_superficial_category",
             "dic_superficial_code", "dic_users"],
            ["fid", "code", "description", "translation"],
        ),
    ],
)
def test_data_model_columns(data_model_gpkg, tables: list[str], expected_col_names: list[str]):
    for table in tables:
        table_info = etl.table_info(table=table, conn=data_model_gpkg)
        # Only get the columns from the actual list of columns that we want to check
        check_cols = [col for col in table_info if col.name in expected_col_names]

        check_col_names = [col.name for col in check_cols]
        # Sort the lists so that the table names lists match exactly
        check_col_names.sort()
        expected_col_names.sort()
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
        ("locality_structural_measurement", {"dip_direction": 360}, None),
        ("locality_structural_measurement", {"dip_direction": -1}, "CHECK constraint failed: dip_direction"),
        ("locality_structural_measurement", {"dip_direction": 361}, "CHECK constraint failed: dip_direction"),

        # Table: locality_superficial_landform
        ("locality_superficial_landform", {"dip": 0}, None),
        ("locality_superficial_landform", {"dip": 90}, None),
        ("locality_superficial_landform", {"dip": -1}, "CHECK constraint failed: dip"),
        ("locality_superficial_landform", {"dip": 91}, "CHECK constraint failed: dip"),
    ],
)
def test_data_model_columns_constraints(
    request,
    data_model_gpkg,
    table: str,
    new_data: dict[str, Any],
    expected_string: Optional[str],
):
    # To use pytest fixtures with parameterisation, you have to access the fixture via request with it's string name
    row = request.getfixturevalue(table + "_dict_row")
    row.update(new_data)
    rows = [row]

    if expected_string is not None:
        # Check that the correct error is raised
        with pytest.raises(etl.exceptions.ETLHelperInsertError) as excinfo:
            etl.load(table=table, conn=data_model_gpkg, rows=rows)
        assert expected_string in str(excinfo.value)
    else:
        # Inserting the row should not raise an error
        etl.load(table=table, conn=data_model_gpkg, rows=rows)


def test_gpkg_contents(data_model_gpkg):
    # Arrange
    expected_contents = [
        ["activity", "attributes"],
        ["dic_activity", "attributes"],
        ["dic_manmade_code", "attributes"],
        ["dic_media", "attributes"],
        ["dic_sample", "attributes"],
        ["dic_structure_category", "attributes"],
        ["dic_structure_code", "attributes"],
        ["dic_structure_secondary", "attributes"],
        ["dic_structure_third", "attributes"],
        ["dic_superficial_category", "attributes"],
        ["dic_superficial_code", "attributes"],
        ["dic_users", "attributes"],
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
