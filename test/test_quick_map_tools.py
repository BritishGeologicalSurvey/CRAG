"""
These are tests for the QuickMapTools of the plugin
which depend on a running QGIS version which is supplied by the 'fdc_project' fixture.
"""
import os
import pwd

import pytest
from qgis.core import (
    QgsFeature,
    QgsGeometry,
    QgsProject,
)
from qgis.gui import QgsMapTool

from plugin.field_data_capture import FieldDataCapture
from plugin.quick_map_tools import (
    QuickAddTool,
    QuickEditTool,
    QuickDeleteTool,
)
from plugin.utils import ipdb_breakpoint  # noqa


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


def test_quick_map_tools_field_project_add_confirm(
    fdc: FieldDataCapture,
    qgs_project,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    layer_name = "field_project"
    expected_tool_name = f"fdc_{layer_name}_add"
    properties = {
        "short_name": "test_field_project",
        "field_project_type": "field_work",
        "local_epsg": 27700,
    }
    # Prepare monkeypatch for open feature form, which adds project properties like a user would

    def add_project_properties(feature: QgsFeature) -> bool:
        layer = QgsProject.instance().mapLayersByName(layer_name)[0]
        for field_name, field_value in properties.items():
            field_index = [field.name() for field in layer.fields()].index(field_name)
            # Even though it is a temporary feature, we can use it's negative fid value from .id() to identify it
            layer.changeAttributeValue(fid=feature.id(), field=field_index, newValue=field_value)
        # Return True to confirm the change
        return True

    # Act 1
    fdc.button_setup_project.trigger()
    monkeypatch.setattr(fdc.quick_map_tool, "open_custom_feature_form", add_project_properties)

    # Assert 1
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Check that the layer is not modified yet
    assert not layer.isModified()
    # Check that the layer has enabled editing mode
    assert layer.isEditable()
    # Check that the tool has been enabled
    assert isinstance(fdc.iface.mapCanvas().mapTool(), QuickAddTool)
    assert fdc.iface.mapCanvas().mapTool().toolName() == expected_tool_name

    # Act 2
    # Make a new and empty feature with just a polygon geometry
    geometry_wkt = "Polygon ((-3.06646639970546664 56.02224055154277949, -0.86620852862676745 52.89687413861690857, -1.3338961920444623 52.75580097369699217, -3.55541259327851167 55.88561238892003047, -3.06646639970546664 56.02224055154277949))"  # noqa
    geometry = QgsGeometry.fromWkt(geometry_wkt)
    geometry_feature = QgsFeature()
    geometry_feature.setGeometry(geometry)
    fdc.quick_map_tool.digitizingCompleted.emit(geometry_feature)

    # Assert 2
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Check that the layer is saved
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that the tool has been disabled
    assert not isinstance(fdc.iface.mapCanvas().mapTool(), QuickAddTool)
    # Check that the new feature has the correct attributes and geometry
    expected_fid = 1
    new_feature: QgsFeature = list(layer.getFeatures())[-1]
    assert new_feature.attribute("fid") == expected_fid
    assert new_feature.attribute("qgis_plugin_version") == "0.1"
    for field_name, field_value in properties.items():
        assert new_feature.attribute(field_name) == field_value
    assert new_feature.geometry().asWkt() == geometry_wkt


def test_quick_map_tools_field_project_add_cancel(
    fdc: FieldDataCapture,
    qgs_project,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    layer_name = "field_project"
    expected_tool_name = f"fdc_{layer_name}_add"

    # Act
    fdc.button_setup_project.trigger()
    # Apply monkeypatch for open feature form, which cancels the form like a user would
    monkeypatch.setattr(fdc.quick_map_tool, "open_custom_feature_form", lambda *args: False)
    # Make a new and empty feature with just a polygon geometry
    geometry_wkt = "Polygon ((-3.06646639970546664 56.02224055154277949, -0.86620852862676745 52.89687413861690857, -1.3338961920444623 52.75580097369699217, -3.55541259327851167 55.88561238892003047, -3.06646639970546664 56.02224055154277949))"  # noqa
    geometry = QgsGeometry.fromWkt(geometry_wkt)
    geometry_feature = QgsFeature()
    geometry_feature.setGeometry(geometry)
    fdc.quick_map_tool.digitizingCompleted.emit(geometry_feature)

    # Assert
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Check that the layer has been rolled back
    assert not layer.isModified()
    # Check that the layer has re-enabled editing mode
    assert layer.isEditable()
    # Check that the tool has been re-enabled
    assert isinstance(fdc.iface.mapCanvas().mapTool(), QuickAddTool)
    assert fdc.iface.mapCanvas().mapTool().toolName() == expected_tool_name


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
