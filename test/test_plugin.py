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
    QgsLayerTreeGroup,
    QgsProject,
    QgsVectorLayer,
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
        # Set the field_project_fuid to be the uuid of the field project from the test data set
        feature.setAttribute("field_project_fuid", "{d57614a8-21ba-47a5-8cb6-82c0b009ec1b}")
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
        # Currently having issues testing the Add tool because it uses QgsMapToolDigitizeFeature which errors
        # during initialisation in a test due to unexpected Mock objects
        # ("locality_point", "add", QuickAddTool),
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

    # Act
    # Enable quick tool
    fdc_project.toggle_quick_map_tool(layer_name, mode)

    # Assert
    # We cannot check the active layer as it is not a working function in the mocked iface
    assert expected_layer.isEditable()
    # Check that the plugin has created the tool
    assert isinstance(fdc_project.quick_map_tool, expected_tool)
    # Check that the tool has been applied to the canvas
    assert fdc_project.iface.mapCanvas().mapTool() == fdc_project.quick_map_tool
    # Check the attributes of the tool
    assert fdc_project.quick_map_tool.quick_mode == mode
    assert fdc_project.quick_map_tool._layer == expected_layer
    assert fdc_project.quick_map_tool.toolName() == f"{layer_name}_{mode}"


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
    # This test uses fdc rather than fdc_project
    # because it tests that the quick tool is not toggled when no project exists
    # Act
    # Enable quick tool
    fdc.toggle_quick_map_tool(layer_name, mode)

    # Assert
    # Check that the plugin has not created the tool
    assert fdc.quick_map_tool is None
    # Check that the tool has not been applied to the canvas
    assert not isinstance(fdc.iface.mapCanvas().mapTool(), expected_tool)


@pytest.mark.parametrize(
    ["layer_name", "mode", "expected_tool"],
    (
        # Currently having issues testing the Add tool because it uses QgsMapToolDigitizeFeature which errors
        # during initialisation in a test due to unexpected Mock objects
        # ("locality_point", "add", QuickAddTool),
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
    # Enable quick tool
    fdc_project.toggle_quick_map_tool(layer_name, mode)

    # Act
    # Disable quick tool
    fdc_project.toggle_quick_map_tool(layer_name, mode)

    # Assert
    # Check that the plugin has not created the tool
    assert fdc_project.quick_map_tool is None
    # Check that the tool has not been applied to the canvas
    assert not isinstance(fdc_project.iface.mapCanvas().mapTool(), expected_tool)


def test_quick_map_tools_switch_tool(fdc_project: FieldDataCapture):
    # Arrange
    layer_name = "locality_point"
    layer = QgsProject.instance().mapLayersByName("locality_point")[0]
    new_mode = "delete"
    # Enable quick edit tool
    fdc_project.toggle_quick_map_tool(layer_name, mode="edit")

    # Act
    # Enable quick delete tool
    fdc_project.toggle_quick_map_tool(layer_name, mode=new_mode)

    # Assert
    # Check that the plugin has created the tool
    assert isinstance(fdc_project.quick_map_tool, QuickDeleteTool)
    # Check that the tool has been applied to the canvas
    assert fdc_project.iface.mapCanvas().mapTool() == fdc_project.quick_map_tool
    # Check the attributes of the tool
    assert fdc_project.quick_map_tool.quick_mode == new_mode
    assert fdc_project.quick_map_tool._layer == layer
    assert fdc_project.quick_map_tool.toolName() == f"{layer_name}_{new_mode}"


@pytest.mark.parametrize(
    ["mode", "expected_tool"],
    (
        # Currently having issues testing the Add tool because it uses QgsMapToolDigitizeFeature which errors
        # during initialisation in a test due to unexpected Mock objects
        # ("add", QuickAddTool),
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
    # Manually make an edit without any tools and do not save it
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    layer.startEditing()
    edit_field_index = [field.name() for field in layer.fields()].index(edit_field)
    layer.changeAttributeValue(fid=point_fid, field=edit_field_index, newValue=new_value)

    # Act
    # Try to enable quick locality point mode
    process_result = fdc_project.toggle_quick_map_tool(layer_name, mode)

    # Assert
    # Check that the process did not complete
    assert not process_result
    # Check that the plugin has not created the tool
    assert fdc_project.quick_map_tool is None
    # Check that the tool has not been applied to the canvas
    assert not isinstance(fdc_project.iface.mapCanvas().mapTool(), expected_tool)
    # Check that the layer is still editable
    assert layer.isEditable()
    # Check that the layer still has the manual changes
    assert layer.isModified()
    assert layer.getFeature(point_fid).attribute(edit_field) == new_value


@pytest.mark.skip("Not working yet")
@pytest.mark.parametrize(
    ["mode", "expected_tool"],
    (
        # Currently having issues testing the Add tool because it uses QgsMapToolDigitizeFeature which errors
        # during initialisation in a test due to unexpected Mock objects
        # ("add", QuickAddTool),
        ("edit", QuickEditTool),
        ("delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_change_layer(fdc_project: FieldDataCapture, mode: str, expected_tool: QgsMapTool):
    # Arrange
    # Enable quick locality point mode
    fdc_project.toggle_quick_map_tool(layer_name="locality_point", mode=mode)

    # Act
    # Select a difference layer
    new_layer = QgsProject.instance().mapLayersByName("bedrock_line")[0]
    fdc_project.iface.setActiveLayer(new_layer)

    # Assert
    # We don't check if the layer is editable because it will not exist anymore
    # Check that the tool is not applied to the canvas
    assert not isinstance(fdc_project.iface.mapCanvas().mapTool(), expected_tool)


@pytest.mark.skip("Not working yet")
@pytest.mark.parametrize(
    ["mode", "expected_tool"],
    (
        # Currently having issues testing the Add tool because it uses QgsMapToolDigitizeFeature which errors
        # during initialisation in a test due to unexpected Mock objects
        # ("add", QuickAddTool),
        ("edit", QuickEditTool),
        ("delete", QuickDeleteTool),
    ),
)
def test_quick_map_tools_close_project(fdc_project: FieldDataCapture, mode: str, expected_tool: QgsMapTool):
    # Arrange
    # Enable quick locality point mode
    fdc_project.toggle_quick_map_tool(layer_name="locality_point", mode=mode)

    # Act
    # Close the test project
    QgsProject.instance().clear()

    # Assert
    # We don't check if the layer is editable because it will not exist anymore
    # Check that the tool is not applied to the canvas
    assert not isinstance(fdc_project.iface.mapCanvas().mapTool(), expected_tool)


@pytest.mark.skip("Needs Refactoring for QuickMapTools but QuickAddTool does not yet work in tests")
def test_quick_locality_add(
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    # Enable add quick locality point mode
    fdc_project.toggle_quick_locality_mode("add")
    layer = QgsProject.instance().mapLayersByName("locality_point")[0]

    # Monkeypatch the iface.openFeatureForm function to ensure it was called
    mock_function = Mock()
    monkeypatch.setattr(fdc_project.iface, "openFeatureForm", mock_function)

    # Act 1
    # Add a new locality_point feature
    # Create a new feature with automatically generated values from the layer
    feature_1 = QgsVectorLayerUtils.createFeature(layer)
    # Set the field_project_fuid to be the uuid of the field project from the test data set
    feature_1.setAttribute("field_project_fuid", "{d57614a8-21ba-47a5-8cb6-82c0b009ec1b}")
    feature_1.setAttribute("exposure_type_code", "auger_borehole")
    layer.addFeature(feature_1)
    # Emit the GUI signal that triggers the auto save of the new feature
    layer.editCommandEnded.emit()

    # Assert 1
    # Check that the layer is saved
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    expected_fid_1 = 3
    new_feature_1 = list(layer.getFeatures())[-1]
    assert new_feature_1.attribute("fid") == expected_fid_1
    # The 'fid' is only stored until the form is re-opened
    # Therefore, when we come to check the 'fid' it should have been discarded
    assert fdc_project.quick_locality_fid is None
    mock_function.assert_called_with(layer, new_feature_1)

    # Act 2
    # Add another new locality_point feature
    # Create a new feature with automatically generated values from the layer
    feature_2 = QgsVectorLayerUtils.createFeature(layer)
    # Set the field_project_fuid to be the uuid of the field project from the test data set
    feature_2.setAttribute("field_project_fuid", "{d57614a8-21ba-47a5-8cb6-82c0b009ec1b}")
    feature_2.setAttribute("exposure_type_code", "auger_borehole")
    layer.addFeature(feature_2)
    # Emit the GUI signal that triggers the auto save of the new feature
    layer.editCommandEnded.emit()

    # Assert 2
    expected_fid_2 = 4
    new_feature_2 = list(layer.getFeatures())[-1]
    assert new_feature_2.attribute("fid") == expected_fid_2
    # The 'fid' is only stored until the form is re-opened
    # Therefore, when we come to check the 'fid' it should have been discarded
    assert fdc_project.quick_locality_fid is None
    mock_function.assert_called_with(layer, new_feature_2)

    # Act 3
    # Disable add quick locality point mode
    fdc_project.toggle_quick_locality_mode(mode="add")

    # Assert 3
    assert not layer.isEditable()
    assert fdc_project.quick_locality_slots == []
    assert not fdc_project.current_quick_locality_mode
    assert fdc_project.quick_locality_fid is None


def test_quick_map_tools_locality_edit(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    layer_name = "locality_point"
    edit_field = "map_face_note"
    new_value = "dummy_value"
    # Enable edit quick locality point mode
    fdc_project.toggle_quick_map_tool(layer_name, mode="edit")
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    edit_field_index = [field.name() for field in layer.fields()].index(edit_field)

    # Act
    # Apply monkeypatch for openFeatureForm, which makes an edit to the map_face_note like a user would
    def edit_point(_layer: QgsVectorLayer, feature: QgsFeature, *args, **kwargs) -> bool:
        _layer.changeAttributeValue(fid=feature.attribute("fid"), field=edit_field_index, newValue=new_value)
        return True
    monkeypatch.setattr(fdc_project.iface, "openFeatureForm", edit_point)
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
    # Check that the tool is still applied to the canvas
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickEditTool)


def test_quick_map_tools_locality_delete(fdc_project: FieldDataCapture, monkeypatch_qmsgbox_question_yes):
    # Arrange
    layer_name = "locality_point"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Enable delete quick locality point mode
    fdc_project.toggle_quick_map_tool(layer_name, mode="delete")
    delete_feature_fid = 1

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
    features = list(layer.getFeatures())
    # Check that there is only 1 feature remaining
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
            assert child_feature.attribute("locality_fuid") != delete_feature_fid

    # Check that the tool is still applied to the canvas
    assert isinstance(fdc_project.iface.mapCanvas().mapTool(), QuickDeleteTool)


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
    FEATURE_TABLES,
)
def test_default_field_project_fuid_attribute(fdc_project: FieldDataCapture, layer_name: str):
    # Arrange
    expected_field_project_fuid = "{d57614a8-21ba-47a5-8cb6-82c0b009ec1b}"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    # Act
    # Create a new feature with the default values applied
    feature = QgsVectorLayerUtils.createFeature(layer)

    # Assert
    assert expected_field_project_fuid == feature.attribute("field_project_fuid")
