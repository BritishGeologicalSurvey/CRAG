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
def test_data_model_columns(data_model_gpkg, tables, expected_col_names):
    for table in tables:
        table_info = etl.table_info(table=table, conn=data_model_gpkg)
        # Get a list of only the columns we are checking for
        check_cols = [col for col in table_info if col.name in expected_col_names]

        check_col_names = [col.name for col in check_cols]
        # Sort the lists so that the table names lists match exactly
        check_col_names.sort()
        expected_col_names.sort()
        assert check_col_names == expected_col_names


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

    assert actual_contents == expected_contents
