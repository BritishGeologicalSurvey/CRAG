"""
These are tests for the plugin which depend on a running QGIS version which is supplied by the 'fdc' fixture.
"""
from pathlib import Path

import etlhelper as etl
from qgis.core import (
    QgsLayerTreeGroup,
    QgsProject,
)

from conftest import setup_db_conn
from plugin.config import TABLE_LIST
from plugin.field_data_capture import FieldDataCapture
from plugin.utils import ipdb_breakpoint  # noqa


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


def test_validation_good(fdc: FieldDataCapture, qgs_project: Path):
    fdc.add_gpkg_to_project()
    assert fdc.project_is_active()
    assert fdc.db_file.exists()


def test_validation_bad(fdc: FieldDataCapture):
    assert not fdc.project_is_active()


def test_add_gpkg_to_project(fdc: FieldDataCapture, qgs_project: Path):
    # Act
    fdc.add_gpkg_to_project()

    # Check file exists
    assert Path(fdc.project_dir / fdc.gpkg_filename).exists()

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


def test_add_gpkg_layers_to_project(fdc: FieldDataCapture, qgs_project: Path):
    # Arrange
    fdc.add_gpkg_to_project()
    expected_root_names = ["locality_point", "views", "locality_data", "metadata"]
    expected_qml_files = [
        # Make the expected path relative to the project root
        Path(qml_file.parent.name) / qml_file.name
        for qml_file in Path("plugin/styles").glob("*.qml")
    ]

    # Act
    fdc.add_gpkg_layers_to_project()

    # Assert
    # Check root layers
    root_layers = QgsProject.instance().layerTreeRoot().children()
    root_names = [layer.name() for layer in root_layers]
    assert expected_root_names == root_names

    # Get only groups from the root
    root_groups: list[QgsLayerTreeGroup] = [
        layer
        for layer in root_layers
        if isinstance(layer, QgsLayerTreeGroup)
    ]

    # Check layers in groups
    for group in root_groups:
        group_layer_names = [layer.name() for layer in group.children()]
        assert fdc.layer_tree_structure[group.name()] == group_layer_names

    # Check that dic layers are readonly
    for layer in QgsProject.instance().mapLayers().values():
        if layer.name().startswith("dic"):
            assert layer.readOnly()

    # Check that the style files have been copied into the project directory
    actual_qml_files = [
        # Make the actual path relative to the plugin root
        Path(qml_file.parent.name) / qml_file.name
        for qml_file in Path(fdc.project_dir / "styles").glob("*.qml")
    ]
    assert expected_qml_files == actual_qml_files


def test_add_test_data_to_project(fdc: FieldDataCapture, qgs_project: Path):
    # Arrange
    fdc.add_gpkg_to_project()
    fdc.add_gpkg_layers_to_project()
    expected_row_counts = {
        "project": 1,
        "locality_point": 2,
        "structural_measurement": 2,
        "exposure": 3,
        "media": 2,
        "photo": 2,
        "sample": 2,
        "superficial_landform": 2,
        "manmade_landform": 2,
    }

    # Act
    fdc.add_test_data_to_project()

    # Assert
    conn = setup_db_conn(fdc.db_file)
    for table, expected_row_count in expected_row_counts.items():
        actual_row_count = etl.fetchone(
            f"SELECT COUNT() FROM {table}",
            conn,
            row_factory=etl.row_factories.tuple_row_factory,
        )[0]
        assert expected_row_count == actual_row_count
