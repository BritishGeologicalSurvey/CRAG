"""
These are tests for the plugin which depend on a running QGIS version which is supplied by the 'fdc' fixture.
"""
import os
import pwd
from pathlib import Path
from typing import Optional
from unittest.mock import Mock
from xml.dom import minidom

import pytest
import etlhelper as etl
from qgis.core import (
    QgsAttributeEditorContainer,
    QgsFeature,
    QgsGeometry,
    QgsLayerTreeGroup,
    QgsProject,
    QgsVectorLayerUtils,
)
from qgis.gui import QgsMapTool
from qgis.PyQt.QtWidgets import QMessageBox

from conftest import setup_db_conn
from plugin.config import (
    ATTRIBUTE_TABLES,
    FEATURE_TABLES,
    TABLE_LIST,
)
from plugin.field_data_capture import FieldDataCapture
from plugin.quick_map_tools import (
    QuickAddTool,
    QuickEditTool,
    QuickDeleteTool,
)
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
    fdc.add_gpkg_layers_to_project()
    assert fdc.validate_qgis_state(project_active=True, db_file_exists=True, fdc_layers_exist=True)


def test_validation_bad(fdc: FieldDataCapture):
    assert not fdc.validate_qgis_state(project_active=True, fdc_layers_exist=True)


def test_setup_project_logic_good(
    fdc: FieldDataCapture,
    qgs_project: Path,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    # Setup mock/monkeypatch for function calls
    check_functions: dict[str, Mock] = {
        "add_gpkg_to_project": None,
        "add_gpkg_layers_to_project": None,
        "open_layer_form": None,
    }
    for function_name in check_functions.keys():
        # All functions will return True which should mean they are all called
        mock_function = Mock(return_value=True)
        monkeypatch.setattr(FieldDataCapture, function_name, mock_function)
        check_functions[function_name] = mock_function

    # Act
    # A saved QGIS project is open so this should work and call all functions once
    fdc.run_function_list(functions=[
        fdc.add_gpkg_to_project,
        fdc.add_gpkg_layers_to_project,
        lambda: fdc.open_layer_form(layer_name="field_project"),
    ])

    # Assert
    for mock_function in check_functions.values():
        mock_function.assert_called_once()


def test_setup_project_logic_bad(
    fdc: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    # Setup mock/monkeypatch for function calls
    check_functions: dict[str, Mock] = {
        "add_gpkg_to_project": None,
        "add_gpkg_layers_to_project": None,
        "open_layer_form": None,
    }
    for function_name in check_functions.keys():
        # All functions return False which should mean only the first function is called
        mock_function = Mock(return_value=False)
        monkeypatch.setattr(FieldDataCapture, function_name, mock_function)
        check_functions[function_name] = mock_function

    # Act
    # No QGIS project is open, so only the first function should be called once
    fdc.run_function_list(functions=[
        fdc.add_gpkg_to_project,
        fdc.add_gpkg_layers_to_project,
        lambda: fdc.open_layer_form(layer_name="field_project"),
    ])

    # Assert
    # Check that the first function was called once
    first_mock_function = check_functions.pop("add_gpkg_to_project")
    first_mock_function.assert_called_once()
    # Check that all other functios were not called
    for mock_function in check_functions.values():
        mock_function.assert_not_called()


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
    expected_root_names = [
        "locality_point",
        "lines",
        "views",
        "locality_data",
        "metadata",
    ]
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
        for qml_file in fdc.styles_dir.glob("*.qml")
    ]
    assert expected_qml_files == actual_qml_files


def test_add_test_data_to_project(fdc: FieldDataCapture, qgs_project: Path):
    # Arrange
    fdc.add_gpkg_to_project()
    fdc.add_gpkg_layers_to_project()
    expected_row_counts = {
        "field_project": 1,
        "locality_point": 2,
        "structural_measurement": 2,
        "lithology": 3,
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

    # Check that relation widgets reference layers in current project
    map_layers = QgsProject.instance().mapLayers()
    for layer in map_layers.values():
        widgets = fdc.editor_widget_metadata(layer)
        for widget in widgets.values():
            if widget["type"] == "RelationReference":
                assert widget["config"]["ReferencedLayerId"] in map_layers


def test_export_qml_styles(
    fdc: FieldDataCapture,
    qgs_project: Path,
    monkeypatch_qmsgbox_question_yes,
):
    # Arrange
    expected_categories = {
        "Symbology",
        "Labeling",
        "Fields",
        "Forms",
        "MapTips",
    }
    fdc.add_gpkg_to_project()
    fdc.add_gpkg_layers_to_project()
    # Get a dictionary of filepaths as keys and modified timestamps as values
    existing_qml_files = {
        str(qml_filepath): qml_filepath.stat().st_mtime
        for qml_filepath in fdc.styles_dir.glob("*.qml")
    }

    # Act
    function_return = fdc.export_qml_styles()

    # Assert
    assert function_return
    for qml_filepath in fdc.styles_dir.glob("*.qml"):

        # Ensure the previously existing timestamp is smaller than the current file timestamp
        # this essentially means that the file has been changed
        assert existing_qml_files[str(qml_filepath)] < qml_filepath.stat().st_mtime

        # Ensure that the correct categories have been exported in the XML data
        xml_data = minidom.parse(str(qml_filepath))
        categories_str = xml_data.getElementsByTagName("qgis")[0].attributes["styleCategories"].value
        categories_set = set(categories_str.split("|"))
        assert categories_set == expected_categories


def test_export_qml_styles_no_layers(
    fdc: FieldDataCapture,
    qgs_project: Path,
):
    # Arrange
    fdc.add_gpkg_to_project()

    # Act
    # No current style files exist because the layers have not been loaded
    # Therefore this should make no change
    function_return = fdc.export_qml_styles()

    # Assert
    assert not function_return
    # Ensure the styles directory does not exist
    assert not fdc.styles_dir.exists()


def test_auto_increment_locality_point_name(fdc_project: FieldDataCapture):
    # Arrange
    # This is the username which the tests will use for default values, as there is no mergin name
    username = pwd.getpwuid(os.getuid()).pw_name
    # Generate a list of expected locality point names based on the current username
    expected_locality_point_names = [
        f"{username}_00{idx}"
        for idx in range(1, 3)
    ]

    # Act
    layer = QgsProject.instance().mapLayersByName("locality_point")[0]
    for expected_name in expected_locality_point_names:
        layer.startEditing()
        # Create a new feature with automatically generated values from the layer
        feature = QgsVectorLayerUtils.createFeature(layer)
        # Give the feature some geometry
        geometry_wkt = "Point (-3 55)"
        geometry = QgsGeometry.fromWkt(geometry_wkt)
        feature.setGeometry(geometry)
        # Set the field_project_fuid to be the uuid of the field project from the test data set
        feature.setAttribute("field_project_fuid", "{85d48fd4-e66f-4436-833b-9e37691a7d4f}")
        feature.setAttribute("exposure_type_code", "auger_borehole")
        layer.addFeature(feature)
        layer.commitChanges()

        # Assert
        assert feature.attribute("name") == expected_name


@pytest.mark.parametrize(
    "child_layer_name",
    (
        "lithology",
        "manmade_landform",
        "media",
        "photo",
        "sample",
        "structural_measurement",
        "superficial_landform",
    ),
)
def test_warn_unsaved_locality_data(
    fdc_project: FieldDataCapture,
    child_layer_name: str,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    point_fid = 1
    point_edit_field = "map_face_note"
    point_new_value = "dummy_value"
    child_fid = 1
    child_edit_field = "user_entered"  # Every table has user_entered with no on_update rules
    child_new_value = "dummy_user"
    unsaved_layers = ["locality_point", child_layer_name]

    # Manually make an edit to the locality_point layer and do not save it
    locality_point_layer = QgsProject.instance().mapLayersByName("locality_point")[0]
    locality_point_layer.startEditing()
    point_edit_field_index = [field.name() for field in locality_point_layer.fields()].index(point_edit_field)
    locality_point_layer.changeAttributeValue(fid=point_fid, field=point_edit_field_index, newValue=point_new_value)

    # Manually make an edit to the given child layer and do not save it
    child_layer = QgsProject.instance().mapLayersByName(child_layer_name)[0]
    child_layer.startEditing()
    child_edit_field_index = [field.name() for field in child_layer.fields()].index(child_edit_field)
    child_layer.changeAttributeValue(fid=child_fid, field=child_edit_field_index, newValue=child_new_value)

    # Monkeypatch the QMessageBox methods to check they are called with the correct values
    mock_message_box_set_text = Mock()
    monkeypatch.setattr(QMessageBox, "setText", mock_message_box_set_text)

    # Act
    unsaved_edits = fdc_project.warn_unsaved_locality_data()

    # Assert
    assert unsaved_edits
    mock_message_box_set_text.assert_called_once()
    assert mock_message_box_set_text.call_args[0][0].endswith("\n".join(unsaved_layers))


@pytest.mark.parametrize(
    ["layer_name", "mode", "expected_tool"],
    (
        ("locality_point", "add", QuickAddTool),
        ("locality_point", "edit", QuickEditTool),
        ("locality_point", "delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_enable(
    fdc_project: FieldDataCapture,
    layer_name: str,
    mode: str,
    expected_tool: QgsMapTool,
):
    # Arrange
    expected_layer = QgsProject.instance().mapLayersByName("locality_point")[0]
    expected_tool_name = f"fdc_{layer_name}_{mode}"

    # Act
    # Enable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    # We cannot check the active layer as it is not a working function in the mocked iface
    assert expected_layer.isEditable()
    # Check that the tool has been applied to the canvas
    map_tool = fdc_project.iface.mapCanvas().mapTool()
    assert isinstance(map_tool, expected_tool)
    # Check the attributes of the tool
    assert map_tool.quick_mode == mode
    assert map_tool._layer == expected_layer
    assert map_tool.toolName() == expected_tool_name
    # Check that the button is toggled
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


@pytest.mark.parametrize(
    ["layer_name", "mode", "expected_tool"],
    (
        ("locality_point", "add", QuickAddTool),
        ("locality_point", "edit", QuickEditTool),
        ("locality_point", "delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_enable_bad(
    fdc: FieldDataCapture,
    layer_name: str,
    mode: str,
    expected_tool: QgsMapTool,
):
    # Arrange
    expected_tool_name = f"fdc_{layer_name}_{mode}"
    # This test uses fdc rather than fdc_project
    # because it tests that the quick tool is not toggled when no project exists
    # Act
    # Enable quick tool
    fdc.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    # Check that the tool has not been applied to the canvas
    assert not isinstance(fdc.iface.mapCanvas().mapTool(), expected_tool)
    # Check that the button is not toggled
    assert not fdc.quick_map_tool_buttons[expected_tool_name].isChecked()


@pytest.mark.parametrize(
    ["layer_name", "mode", "expected_tool"],
    (
        ("locality_point", "add", QuickAddTool),
        ("locality_point", "edit", QuickEditTool),
        ("locality_point", "delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_disable(
    fdc_project: FieldDataCapture,
    layer_name: str,
    mode: str,
    expected_tool: QgsMapTool,
):
    # Arrange
    expected_tool_name = f"fdc_{layer_name}_{mode}"
    # Enable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Act
    # Disable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    # Check that the tool is not applied to the canvas
    assert not isinstance(fdc_project.iface.mapCanvas().mapTool(), expected_tool)
    # Check that the button is not toggled
    assert not fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


@pytest.mark.parametrize(
    ["layer_name", "mode", "expected_tool"],
    (
        ("locality_point", "add", QuickAddTool),
        ("locality_point", "edit", QuickEditTool),
        ("locality_point", "delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_disable_bad(
    fdc_project: FieldDataCapture,
    layer_name: str,
    mode: str,
    expected_tool: QgsMapTool,
):
    # Arrange
    expected_tool_name = f"fdc_{layer_name}_{mode}"
    # Enable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Act
    # Remove the lithology layer so that the state is invalid for the plugin
    lithology_layer = QgsProject.instance().mapLayersByName("lithology")[0]
    QgsProject.instance().removeMapLayer(lithology_layer)
    # Try to disable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    # The tool should have been disabled properly even though the state is invalid
    # Check that the tool is not applied to the canvas
    assert not isinstance(fdc_project.iface.mapCanvas().mapTool(), expected_tool)
    # Check that the button is not toggled
    assert not fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


@pytest.mark.parametrize(
    ["layer_name", "new_mode", "expected_tool"],
    (
        ("locality_point", "edit", QuickEditTool),
        ("locality_point", "delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_switch_tool(
    fdc_project: FieldDataCapture,
    layer_name: str,
    new_mode: str,
    expected_tool: QgsMapTool,
):
    # Arrange
    old_tool_name = f"fdc_{layer_name}_add"
    expected_tool_name = f"fdc_{layer_name}_{new_mode}"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    # Act
    # Enable quick add tool
    fdc_project.quick_map_tool_buttons[old_tool_name].trigger()
    # Enable quick delete tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    map_tool = fdc_project.iface.mapCanvas().mapTool()
    # Check that the tool has been applied to the canvas
    assert isinstance(map_tool, expected_tool)
    # Check the attributes of the tool
    assert map_tool.quick_mode == new_mode
    assert map_tool._layer == layer
    assert map_tool.toolName() == expected_tool_name
    # Check that the buttons are toggled correctly
    assert not fdc_project.quick_map_tool_buttons[old_tool_name].isChecked()
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


@pytest.mark.parametrize(
    ["mode", "expected_tool"],
    (
        ("add", QuickAddTool),
        ("edit", QuickEditTool),
        ("delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_locality_warn_edits(fdc_project: FieldDataCapture, mode: str, expected_tool: QgsMapTool):
    # Arrange
    layer_name = "locality_point"
    point_fid = 1
    edit_field = "map_face_note"
    new_value = "dummy_value"
    expected_tool_name = f"fdc_{layer_name}_{mode}"
    # Manually make an edit without any tools and do not save it
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    layer.startEditing()
    edit_field_index = [field.name() for field in layer.fields()].index(edit_field)
    layer.changeAttributeValue(fid=point_fid, field=edit_field_index, newValue=new_value)

    # Act
    # Try to enable quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    # Check that the button is not toggled
    assert not fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()
    # Check that the tool has not been applied to the canvas
    assert not isinstance(fdc_project.iface.mapCanvas().mapTool(), expected_tool)
    # Check that the layer is still editable
    assert layer.isEditable()
    # Check that the layer still has the manual changes
    assert layer.isModified()
    assert layer.getFeature(point_fid).attribute(edit_field) == new_value


def test_quick_map_tools_locality_add_confirm(
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    layer_name = "locality_point"
    exposure_field = "exposure_type_code"
    exposure_value = "auger_borehole"
    expected_tool_name = f"fdc_{layer_name}_add"
    # Enable add quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    exposure_field_index = [field.name() for field in layer.fields()].index(exposure_field)

    # Apply monkeypatch for open feature form, which adds an exposure_type_code to the new feature like a user would
    def add_exposure(feature: QgsFeature) -> bool:
        # Even though it is a temporary feature, we can use it's negative fid value from .id() to identify it
        layer.changeAttributeValue(fid=feature.id(), field=exposure_field_index, newValue=exposure_value)
        # Return True to confirm the change
        return True
    monkeypatch.setattr(fdc_project.quick_map_tool, "open_custom_feature_form", add_exposure)

    # Act
    # Make a new and empty feature with just a point geometry
    geometry_wkt = "Point (-3 55)"
    geometry = QgsGeometry.fromWkt(geometry_wkt)
    geometry_feature = QgsFeature()
    geometry_feature.setGeometry(geometry)
    fdc_project.quick_map_tool.digitizingCompleted.emit(geometry_feature)

    # Assert
    # Check that the layer is saved
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that the new feature has the correct attributes and geometry
    expected_fid = 3
    new_feature: QgsFeature = list(layer.getFeatures())[-1]
    assert new_feature.attribute("fid") == expected_fid
    assert new_feature.attribute("name") == f"{pwd.getpwuid(os.getuid()).pw_name}_001"
    assert new_feature.attribute(exposure_field) == exposure_value
    assert new_feature.geometry().asWkt() == geometry_wkt
    # Check that the tool is still enabled
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickAddTool)
    assert fdc_project.iface.mapCanvas().mapTool().toolName() == expected_tool_name
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


def test_quick_map_tools_locality_add_cancel(
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    layer_name = "locality_point"
    exposure_field = "exposure_type_code"
    exposure_value = "auger_borehole"
    expected_tool_name = f"fdc_{layer_name}_add"
    # Enable add quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    exposure_field_index = [field.name() for field in layer.fields()].index(exposure_field)

    # Apply monkeypatch for open feature form, which adds an exposure_type_code to the new feature like a user would
    def add_exposure(feature: QgsFeature) -> bool:
        # Even though it is a temporary feature, we can use it's negative fid value from .id() to identify it
        layer.changeAttributeValue(fid=feature.id(), field=exposure_field_index, newValue=exposure_value)
        # Return False to cancel the change
        return False
    monkeypatch.setattr(fdc_project.quick_map_tool, "open_custom_feature_form", add_exposure)

    # Act
    # Make a new and empty feature with just a point geometry
    geometry_wkt = "Point (-3 55)"
    geometry = QgsGeometry.fromWkt(geometry_wkt)
    geometry_feature = QgsFeature()
    geometry_feature.setGeometry(geometry)
    fdc_project.quick_map_tool.digitizingCompleted.emit(geometry_feature)

    # Assert
    # Check that the layer is rolled back
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that there are only 2 features
    features = list(layer.getFeatures())
    assert len(features) == 2
    # Check that the expected new fid is not in any features
    expected_fid = 3
    feature_fids = {feature.attribute("fid") for feature in features}
    assert expected_fid not in feature_fids
    # Check that the tool is still enabled
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickAddTool)
    assert fdc_project.iface.mapCanvas().mapTool().toolName() == expected_tool_name
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


def test_quick_map_tools_locality_edit_confirm(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    layer_name = "locality_point"
    edit_field = "map_face_note"
    new_value = "dummy_value"
    expected_tool_name = f"fdc_{layer_name}_edit"
    # Enable edit quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    edit_field_index = [field.name() for field in layer.fields()].index(edit_field)

    # Apply monkeypatch for open feature form, which makes an edit to the map_face_note like a user would
    def edit_feature(feature: QgsFeature) -> bool:
        # Even though it is a temporary feature, we can use it's negative fid value from .id() to identify it
        layer.changeAttributeValue(fid=feature.id(), field=edit_field_index, newValue=new_value)
        # Return True to confirm the change
        return True
    monkeypatch.setattr(fdc_project.quick_map_tool, "open_custom_feature_form", edit_feature)

    # Act
    # Emit the signal which would open the form and auto save afterwards
    edit_feature_fid = 1
    feature_to_edit = layer.getFeature(edit_feature_fid)
    fdc_project.quick_map_tool.featureIdentified.emit(feature_to_edit)

    # Assert
    # Check that the layer is saved
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that the edit has been saved correctly
    assert layer.getFeature(edit_feature_fid).attribute(edit_field) == new_value
    # Check that the tool is still enabled
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickEditTool)
    assert fdc_project.iface.mapCanvas().mapTool().toolName() == expected_tool_name
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


def test_quick_map_tools_locality_edit_cancel(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    layer_name = "locality_point"
    edit_field = "map_face_note"
    new_value = "dummy_value"
    old_value = "test_point_001 note"
    expected_tool_name = f"fdc_{layer_name}_edit"
    # Enable edit quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    edit_field_index = [field.name() for field in layer.fields()].index(edit_field)

    # Apply monkeypatch for open feature form, which makes an edit to the map_face_note like a user would
    def edit_feature(feature: QgsFeature) -> bool:
        # Even though it is a temporary feature, we can use it's negative fid value from .id() to identify it
        layer.changeAttributeValue(fid=feature.id(), field=edit_field_index, newValue=new_value)
        # Return False to cancel the change
        return False
    monkeypatch.setattr(fdc_project.quick_map_tool, "open_custom_feature_form", edit_feature)

    # Act
    # Emit the signal which would open the form and auto save afterwards
    edit_feature_fid = 1
    feature_to_edit = layer.getFeature(edit_feature_fid)
    fdc_project.quick_map_tool.featureIdentified.emit(feature_to_edit)

    # Assert
    # Check that the layer is rolled back
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that the edit has not been saved
    assert layer.getFeature(edit_feature_fid).attribute(edit_field) == old_value
    # Check that the tool is still enabled
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickEditTool)
    assert fdc_project.iface.mapCanvas().mapTool().toolName() == expected_tool_name
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


def test_quick_map_tools_locality_delete_confirm(fdc_project: FieldDataCapture, monkeypatch_qmsgbox_question_yes):
    # Arrange
    layer_name = "locality_point"
    expected_tool_name = f"fdc_{layer_name}_delete"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Enable delete quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    delete_feature_fid = 1
    delete_locality_fuid = layer.getFeature(delete_feature_fid).attribute("uuid")

    # Act
    # Delete one of the test points
    # Emit the signal which would delete an identified feature and save after confirmation
    feature_to_delete = layer.getFeature(delete_feature_fid)
    fdc_project.quick_map_tool.featureIdentified.emit(feature_to_delete)

    # Assert
    # Check that the layer is saved
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that there is only 1 feature remaining
    features = list(layer.getFeatures())
    assert len(features) == 1
    # Check that it's fid value is not the one we deleted
    assert features[0].attribute("fid") != delete_feature_fid

    # Check that the deleted feature children do not exist
    for child_layer_name in fdc_project.layer_tree_structure["locality_data"]:
        child_layer = QgsProject.instance().mapLayersByName(child_layer_name)[0]
        # The child layer should have been autosaved
        assert not child_layer.isEditable()
        assert not child_layer.isModified()
        # For each of the features in the child layer, check the locality_fuid does not match the deleted fid
        for child_feature in child_layer.getFeatures():
            assert child_feature.attribute("locality_fuid") != delete_locality_fuid

    # Check that the tool is still enabled
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickDeleteTool)
    assert fdc_project.iface.mapCanvas().mapTool().toolName() == expected_tool_name
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


def test_quick_map_tools_locality_delete_cancel(fdc_project: FieldDataCapture, monkeypatch_qmsgbox_question_no):
    # Arrange
    layer_name = "locality_point"
    expected_tool_name = f"fdc_{layer_name}_delete"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Enable delete quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    delete_feature_fid = 1
    delete_locality_fuid = layer.getFeature(delete_feature_fid).attribute("uuid")

    # Act
    # Delete one of the test points
    # Emit the signal which would delete an identified feature and save after confirmation
    feature_to_delete = layer.getFeature(delete_feature_fid)
    fdc_project.quick_map_tool.featureIdentified.emit(feature_to_delete)

    # Assert
    # Check that the layer is rolled back
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that there are still 2 features
    features = list(layer.getFeatures())
    assert len(features) == 2
    # Check that it's fid value is not deleted
    assert delete_feature_fid in {feature.attribute("fid") for feature in features}

    # Check that the child features have not been deleted
    for child_layer_name in fdc_project.layer_tree_structure["locality_data"]:
        child_layer = QgsProject.instance().mapLayersByName(child_layer_name)[0]
        # The child layer should not have been changed
        assert not child_layer.isEditable()
        assert not child_layer.isModified()
        # For each of the features in the child layer, check the delete fid is in one of the locality_fuid values
        child_locality_fuids = {child_feature.attribute("locality_fuid") for child_feature in child_layer.getFeatures()}
        assert delete_locality_fuid in child_locality_fuids

    # Check that the tool is still enabled
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickDeleteTool)
    assert fdc_project.iface.mapCanvas().mapTool().toolName() == expected_tool_name
    assert fdc_project.quick_map_tool_buttons[expected_tool_name].isChecked()


@pytest.mark.parametrize(
    "layer_name",
    ATTRIBUTE_TABLES.union(FEATURE_TABLES),
)
def test_attribute_form_widgets(fdc_project: FieldDataCapture, layer_name: str):
    # Arrange
    hidden_widgets = {
        "fid",
        "objectid",
        "uuid",
        "user_entered",
        "date_entered",
        "user_updated",
        "date_updated",
    }
    apply_on_update_widgets = {
        "user_updated",
        "date_updated",
    }
    expected_expressions = {
        "uuid": "uuid()",
        "user_entered": "@user_account_name",
        "date_entered": "now()",
        "user_updated": "@user_account_name",
        "date_updated": "now()",
    }

    # Assert
    hidden_type_widgets = set()
    # Check the layer fields directly
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    for field_idx, field_name in enumerate(layer.fields().names()):

        # Get the widget config
        widget = layer.editorWidgetSetup(field_idx)
        # Get the default config
        default = layer.defaultValueDefinition(field_idx)

        if field_name in apply_on_update_widgets:
            assert default.applyOnUpdate()

        if field_name in expected_expressions:
            assert default.expression() == expected_expressions[field_name]

        # Create a set of hidden widgets which have the type 'Hidden' (for default forms)
        # We don't assert this because drag and drop forms may not have this set
        if field_name in hidden_widgets and widget.type() == "Hidden":
            hidden_type_widgets.add(field_name)

    # Check the layer form structure (required for drag and drop forms)
    # We get the root widget of form from the drag and drop design layout
    form_root = layer.editFormConfig().invisibleRootContainer()
    # Then we use a recursive search method to find all child widgets which exist in the form
    all_form_widgets = recursive_search_form(parent_widget=form_root)
    form_widget_names = {widget.name() for widget in all_form_widgets}

    # Check that the hidden widget names are not in the list of actual widget names (for drag and drop forms)
    # OR
    # that the hidden widgets have the type 'Hidden' (for default forms)
    assert form_widget_names.intersection(hidden_widgets) == set() or hidden_widgets == hidden_type_widgets


def recursive_search_form(
    parent_widget: QgsAttributeEditorContainer,
    form_elements: Optional[list[QgsAttributeEditorContainer]] = None,
) -> list[QgsAttributeEditorContainer]:
    """
    Recursively search for form tabs from the root object of the form.
    """
    if form_elements is None:
        form_elements = []

    # Add the new parent widget to the list of elements
    form_elements.append(parent_widget)

    # If the parent widget has a method to access further child elements
    if hasattr(parent_widget, "children"):
        children = parent_widget.children()
        for form_element in children:
            form_elements = recursive_search_form(form_element, form_elements)

    return form_elements


@pytest.mark.parametrize(
    "layer_name",
    FEATURE_TABLES - {"field_project"},
)
def test_default_field_project_fuid_attribute(fdc_project: FieldDataCapture, layer_name: str):
    # Arrange
    expected_field_project_fuid = "{85d48fd4-e66f-4436-833b-9e37691a7d4f}"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    # Act
    # Create a new feature with the default values applied
    feature = QgsVectorLayerUtils.createFeature(layer)

    # Assert
    assert expected_field_project_fuid == feature.attribute("field_project_fuid")
