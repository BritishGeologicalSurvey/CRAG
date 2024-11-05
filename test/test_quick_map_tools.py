"""
These are tests for the QuickMapTools of the plugin
which depend on a running QGIS version which is supplied by the 'fdc_project' fixture.
"""
import os
import pwd
from copy import deepcopy
from typing import (
    Any,
    Iterable,
    Optional,
)
from unittest.mock import Mock

import pytest
from qgis.core import (
    QgsFeature,
    QgsProject,
    QgsVectorLayer,
)
from qgis.gui import QgsMapTool
from qgis.PyQt.QtCore import pyqtSignal
from qgis.PyQt.QtWidgets import QDialog
from plugin.config import (
    FEATURE_TABLES_LINES,
    LAYER_TREE_STRUCTURE_INDEXED,
)
from plugin.field_data_capture import FieldDataCapture
from plugin.line_layer_selector import LineLayerSelector
from plugin.quick_map_tools import (
    QuickMapToolBase,
    QuickAddTool,
    QuickEditTool,
    QuickDeleteTool,
)
from plugin.utils import ipdb_breakpoint  # noqa
from conftest import create_empty_geometry_feature

COMMON_TOOLS = (
    ["layer_names", "expected_tool", "expected_tool_name"],
    (
        ("locality_point", QuickAddTool, "fdc_locality_point_add"),
        ("locality_point", QuickEditTool, "fdc_locality_point_edit"),
        ("locality_point", QuickDeleteTool, "fdc_locality_point_delete"),
        (sorted(FEATURE_TABLES_LINES), QuickEditTool, "fdc_lines_edit"),
        (sorted(FEATURE_TABLES_LINES), QuickDeleteTool, "fdc_lines_delete"),
    ),
)
LINE_TYPE_CODES = (
    # artificial_line
    "cliffline_quarry",
    # bedrock_line
    "base_of_lava_flow",
    # mass_move_line
    "landslide_head_zone_limit",
    # superficial_line
    "axis_of_megagroove",
    # terrain_line
    "convex_break_of_slope",
)


@pytest.fixture()
def empty_geometry_feature_point() -> QgsFeature:
    return create_empty_geometry_feature("Point (-3 55)")


@pytest.fixture()
def empty_geometry_feature_line() -> QgsFeature:
    return create_empty_geometry_feature("LineString (-3 55, 55 -3)")


def monkeypatch_feature_form(
    monkeypatch: pytest.MonkeyPatch,
    save: bool,
    attributes: Optional[dict[str, Any]] = None,
) -> None:
    """
    Apply a monkeypatch to the open_custom_feature_form and open_feature_form methods of QuickMapToolsBase which
    setup the real signals but trigger them manually.
    Arguments can be given to specify if the form should save and any attribute changes
    that should be applied to the forms feature.
    """
    # Create real class with signals for dialog to ensure they trigger the correct methods later
    class TempDialog(QDialog):
        accepted = pyqtSignal()
        rejected = pyqtSignal()

    def mock_open_custom_feature_form(
        self: QuickMapToolBase,
        feature: QgsFeature,
        feature_layer: QgsVectorLayer,
    ) -> None:
        """
        We have to create a new instance of the TempDialog every time the method to get the dialog is called.
        This ensures that when we create signal connections, the most recent set of arguments in the lambdas are used,
        instead of the original lambda arguments.
        For this same reason, we save the instance as a new QuickMapToolBase attribute just for the test,
        so we can emit the correct signal later.
        """
        self.temp_dialog = TempDialog()
        self.temp_dialog.feature = Mock(return_value=feature)
        return self.temp_dialog

    monkeypatch.setattr(QuickMapToolBase, "open_custom_feature_form", mock_open_custom_feature_form)

    # Save the actual method before applying monkeypatch so we can still call it manually
    actual_open_feature_form = deepcopy(QuickMapToolBase.open_feature_form)

    def new_open_feature_form(
        self: QuickMapToolBase,
        feature: QgsFeature,
        feature_layer: QgsVectorLayer,
        reopen_form_on_add_locality: bool = True,
    ) -> None:
        # Call the actual method first to ensure the signals are setup correctly
        actual_open_feature_form(self, feature, feature_layer, reopen_form_on_add_locality)

        # Apply attribute changes to the forms feature like a user would
        if attributes is not None:
            for field_name, field_value in attributes.items():
                field_index = [field.name() for field in feature_layer.fields()].index(field_name)
                # Even though it is a temporary feature, we can use it's negative fid value from .id() to identify it
                feature_layer.changeAttributeValue(fid=feature.id(), field=field_index, newValue=field_value)

        # Trigger the respective signal to save/rollback the dialog changes
        signals = {
            True: self.temp_dialog.accepted,
            False: self.temp_dialog.rejected,
        }
        signals[save].emit()

    monkeypatch.setattr(QuickMapToolBase, "open_feature_form", new_open_feature_form)


def assert_tool_enabled(
    fdc: FieldDataCapture,
    layer_names: str | Iterable[str],
    expected_tool: QgsMapTool,
    expected_tool_name: str,
) -> None:
    """
    Assert that a tool defined by the given attributes is currently enabled.
    Also checks that the given layer(s) are in the correct state.
    """
    # Get layer(s) for checking
    # If a single layer is given for the tool
    if isinstance(layer_names, str):
        expected_layers = [QgsProject.instance().mapLayersByName(layer_names)[0]]
    # If a list of layers is given for the tool
    else:
        expected_layers = [
            QgsProject.instance().mapLayersByName(layer)[0]
            for layer in layer_names
        ]

    # Check layer(s)
    for expected_layer in expected_layers:
        # We cannot check the active layer as it is not a working function in the mocked iface
        # The selection model is also just a Mock object and cannot be directly checked either
        assert expected_layer.isEditable()
        assert not expected_layer.isModified()

    # Check that the tool has been applied to the canvas
    map_tool = fdc.iface.mapCanvas().mapTool()
    assert isinstance(map_tool, expected_tool)
    # Check the attributes of the tool
    assert map_tool.toolName() == expected_tool_name
    assert set(map_tool.get_layer()) == set(expected_layers)
    # Check that the button is toggled, but only if it is not the add field_project tool because it is a one time use
    if expected_tool_name != "fdc_field_project_add":
        assert fdc.quick_map_tool_buttons[expected_tool_name].isChecked()


def assert_no_tool_enabled(fdc: FieldDataCapture, layer: Optional[QgsVectorLayer] = None) -> None:
    """
    Assert that no tool is currently enabled.
    Also takes an optional layer to check if it is re-enabed editing mode and saved/rolled back.
    """
    # Check that a QuickMapTool has not been applied to the canvas
    assert not isinstance(fdc.iface.mapCanvas().mapTool(), QuickMapToolBase)
    for tool_button in fdc.quick_map_tool_buttons.values():
        # Check that the button is not toggled
        assert not tool_button.isChecked()

    if layer is not None:
        assert layer.isEditable()
        assert not layer.isModified()


@pytest.mark.parametrize(*COMMON_TOOLS)
def test_enable_good(
    layer_names: str | Iterable[str],
    expected_tool: QgsMapTool,
    expected_tool_name: str,
    fdc_project: FieldDataCapture,
):
    # Act
    # Enable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    assert_tool_enabled(fdc_project, layer_names, expected_tool, expected_tool_name)


@pytest.mark.parametrize(*COMMON_TOOLS)
def test_enable_bad(
    layer_names: str | Iterable[str],
    expected_tool: QgsMapTool,
    expected_tool_name: str,
    fdc: FieldDataCapture,
):
    # This test uses the 'fdc' fixture rather than 'fdc_project' because
    # it tests that the quick tool is not toggled when no project exists.
    # Act
    # Enable quick tool
    fdc.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    assert_no_tool_enabled(fdc)


@pytest.mark.parametrize(*COMMON_TOOLS)
def test_disable_good(
    layer_names: str | Iterable[str],
    expected_tool: QgsMapTool,
    expected_tool_name: str,
    fdc_project: FieldDataCapture,
):
    # Enable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Act
    # Disable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    assert_no_tool_enabled(fdc_project)


@pytest.mark.parametrize(*COMMON_TOOLS)
def test_disable_bad(
    layer_names: str | Iterable[str],
    expected_tool: QgsMapTool,
    expected_tool_name: str,
    fdc_project: FieldDataCapture,
):
    # Arrange
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
    assert_no_tool_enabled(fdc_project)


# Ignore first common tool as it is fdc_locality_point_add which is used as old tool
@pytest.mark.parametrize(COMMON_TOOLS[0], COMMON_TOOLS[1][1:])
def test_switch_tool(
    layer_names: str | Iterable[str],
    expected_tool: QgsMapTool,
    expected_tool_name: str,
    fdc_project: FieldDataCapture,
):
    # Arrange
    old_tool_name = "fdc_locality_point_add"

    # Act
    # Enable quick add locality point tool
    fdc_project.quick_map_tool_buttons[old_tool_name].trigger()
    # Enable new quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Assert
    assert_tool_enabled(fdc_project, layer_names, expected_tool, expected_tool_name)
    # Check that the old button is not toggled
    assert not fdc_project.quick_map_tool_buttons[old_tool_name].isChecked()


@pytest.mark.parametrize(*COMMON_TOOLS)
def test_manually_disable_editing(
    layer_names: str | Iterable[str],
    expected_tool: QgsMapTool,
    expected_tool_name: str,
    fdc_project: FieldDataCapture,
):
    # Arrange
    # Enable quick tool
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()

    # Act
    # Disable editing on the first layer manually, this used to cause the tool to break
    fdc_project.quick_map_tool.get_layer()[0].rollBack()

    # Assert
    assert_no_tool_enabled(fdc_project)


@pytest.mark.parametrize(
    ["layer_name", "line_type_code"],
    zip(
        # Ignore the first value from each because it will be the already activated tool
        sorted(FEATURE_TABLES_LINES)[1:],
        LINE_TYPE_CODES[1:],
    ),
)
def test_reopen_line_layer_selector(
    layer_name: str,
    line_type_code: str,
    fdc_project: FieldDataCapture,
):
    # Arrange
    expected_tool = QuickAddTool
    expected_tool_name = f"fdc_{layer_name}_add"
    start_layer_name = "artificial_line"
    start_line_type_code = "cliffline_quarry"
    # Press button to activate QuickAddTool for lines
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
    # Emit signal as if user selected the starting line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(start_layer_name, start_line_type_code)

    # Act 1
    # Press button to activate QuickAddTool for lines whilst tool is already active
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()

    # Assert 1
    # Check that LineLayerSelector has been reopened
    assert isinstance(fdc_project.line_layer_selector, LineLayerSelector)
    # Check that the button is still toggled
    assert fdc_project.quick_map_tool_buttons["fdc_lines_add"].isChecked()

    # Act 2
    # Emit signal as if user selected a new line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(layer_name, line_type_code)

    # Assert 2
    assert_tool_enabled(fdc_project, layer_name, expected_tool, expected_tool_name)
    # Check that the button is still toggled
    assert fdc_project.quick_map_tool_buttons["fdc_lines_add"].isChecked()
    # Check that the LineLayerSelector was opened twice
    assert LineLayerSelector.exec.call_count == 2


@pytest.mark.parametrize("mode", ("add", "edit", "delete"))
def test_locality_warn_edits(mode: str, fdc_project: FieldDataCapture):
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
    assert_no_tool_enabled(fdc_project)
    # Check that the layer is still editable
    assert layer.isEditable()
    # Check that the layer still has the manual changes
    assert layer.isModified()
    assert layer.getFeature(point_fid).attribute(edit_field) == new_value


def test_field_project_add_confirm(
    fdc: FieldDataCapture,
    qgs_project,
    monkeypatch: pytest.MonkeyPatch,
    empty_geometry_feature_polygon: QgsFeature,
):
    # Arrange 1
    layer_name = "field_project"
    expected_tool_name = f"fdc_{layer_name}_add"

    # Act 1 - enable the tool
    fdc.button_setup_project.trigger()

    # Assert 1 - confirm tool setup
    assert_tool_enabled(fdc, layer_name, QuickAddTool, expected_tool_name)
    # Check that the layer is not modified yet
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    assert not layer.isModified()

    # Arrange 2 - apply changes to feature
    attributes = {
        "short_name": "test_field_project",
        "local_epsg": 27700,
    }
    monkeypatch_feature_form(monkeypatch, save=True, attributes=attributes)

    # Act 2 - add a new project
    fdc.quick_map_tool.digitizingCompleted.emit(empty_geometry_feature_polygon)

    # Assert 2 - confirm tool teardown and project creation
    assert_no_tool_enabled(fdc, layer)
    # Check that the new feature has the correct attributes and geometry
    expected_fid = 1
    new_feature: QgsFeature = list(layer.getFeatures())[-1]
    assert new_feature.attribute("fid") == expected_fid
    assert new_feature.attribute("qgis_plugin_version") == "fdc_test_fixture"
    for field_name, field_value in attributes.items():
        assert new_feature.attribute(field_name) == field_value
    assert new_feature.geometry().asWkt() == empty_geometry_feature_polygon.geometry().asWkt()


def test_field_project_add_cancel(
    fdc: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
    qgs_project,
    empty_geometry_feature_polygon: QgsFeature,
):
    # Arrange
    layer_name = "field_project"
    expected_tool_name = f"fdc_{layer_name}_add"

    monkeypatch_feature_form(monkeypatch, save=False)

    # Act
    fdc.button_setup_project.trigger()
    fdc.quick_map_tool.digitizingCompleted.emit(empty_geometry_feature_polygon)

    # Assert
    assert_tool_enabled(fdc, layer_name, QuickAddTool, expected_tool_name)


def test_locality_add_confirm(
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
    empty_geometry_feature_point: QgsFeature,
):
    # Arrange
    layer_name = "locality_point"
    locality_type_field = "locality_type_code"
    last_locality_type_value = "outcrop"
    expected_tool_name = f"fdc_{layer_name}_add"
    # Enable add quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=True)

    # Act
    fdc_project.quick_map_tool.digitizingCompleted.emit(empty_geometry_feature_point)

    # Assert
    # Check that the new feature has the correct attributes and geometry
    expected_fid = 3
    new_feature: QgsFeature = list(layer.getFeatures())[-1]
    assert new_feature.attribute("fid") == expected_fid
    assert new_feature.attribute("name") == f"{pwd.getpwuid(os.getuid()).pw_name}_001"
    assert new_feature.attribute(locality_type_field) == last_locality_type_value
    assert new_feature.geometry().asWkt() == empty_geometry_feature_point.geometry().asWkt()
    assert_tool_enabled(fdc_project, layer_name, QuickAddTool, expected_tool_name)


def test_locality_add_cancel(
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
    empty_geometry_feature_point: QgsFeature,
):
    # Arrange
    layer_name = "locality_point"
    expected_tool_name = f"fdc_{layer_name}_add"
    # Enable add quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=False)

    # Act
    fdc_project.quick_map_tool.digitizingCompleted.emit(empty_geometry_feature_point)

    # Assert
    # Check that there are only 2 features
    features = list(layer.getFeatures())
    assert len(features) == 2
    # Check that the expected new fid is not in any features
    expected_fid = 3
    feature_fids = {feature.attribute("fid") for feature in features}
    assert expected_fid not in feature_fids
    assert_tool_enabled(fdc_project, layer_name, QuickAddTool, expected_tool_name)


def test_locality_edit_confirm(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    layer_name = "locality_point"
    edit_field = "map_face_note"
    new_value = "dummy_value"
    expected_tool_name = f"fdc_{layer_name}_edit"
    # Enable edit quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=True, attributes={edit_field: new_value})

    # Act
    # Emit the signal which would open the form and auto save afterwards
    edit_feature_fid = 1
    feature_to_edit = layer.getFeature(edit_feature_fid)
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_edit, layer)

    # Assert
    # Check that the edit has been saved correctly
    assert layer.getFeature(edit_feature_fid).attribute(edit_field) == new_value
    assert_tool_enabled(fdc_project, layer_name, QuickEditTool, expected_tool_name)


def test_locality_edit_cancel(
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    layer_name = "locality_point"
    edit_field = "map_face_note"
    old_value = "test_point_001 note"
    expected_tool_name = f"fdc_{layer_name}_edit"
    # Enable edit quick locality point mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=False)

    # Act
    # Emit the signal which would open the form and auto save afterwards
    edit_feature_fid = 1
    feature_to_edit = layer.getFeature(edit_feature_fid)
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_edit, layer)

    # Assert
    # Check that the edit has not been saved
    assert layer.getFeature(edit_feature_fid).attribute(edit_field) == old_value
    assert_tool_enabled(fdc_project, layer_name, QuickEditTool, expected_tool_name)


def test_locality_delete_confirm(fdc_project: FieldDataCapture, monkeypatch_qmsgbox_question_yes):
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
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_delete, layer)

    # Assert
    # Check that there is only 1 feature remaining
    features = list(layer.getFeatures())
    assert len(features) == 1
    # Check that it's fid value is not the one we deleted
    assert features[0].attribute("fid") != delete_feature_fid

    # Check that the deleted feature children do not exist
    for child_layer_name in LAYER_TREE_STRUCTURE_INDEXED["locality_data"]:
        child_layer = QgsProject.instance().mapLayersByName(child_layer_name)[0]
        # The child layer should have been autosaved
        assert not child_layer.isEditable()
        assert not child_layer.isModified()
        # For each of the features in the child layer, check the locality_fuid does not match the deleted fid
        for child_feature in child_layer.getFeatures():
            assert child_feature.attribute("locality_fuid") != delete_locality_fuid

    assert_tool_enabled(fdc_project, layer_name, QuickDeleteTool, expected_tool_name)


def test_locality_delete_cancel(fdc_project: FieldDataCapture, monkeypatch_qmsgbox_question_no):
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
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_delete, layer)

    # Assert
    # Check that there are still 2 features
    features = list(layer.getFeatures())
    assert len(features) == 2
    # Check that it's fid value is not deleted
    assert delete_feature_fid in {feature.attribute("fid") for feature in features}

    # Check that the child features have not been deleted
    for child_layer_name in LAYER_TREE_STRUCTURE_INDEXED["locality_data"]:
        child_layer = QgsProject.instance().mapLayersByName(child_layer_name)[0]
        # The child layer should not have been changed
        assert not child_layer.isEditable()
        assert not child_layer.isModified()
        # For each of the features in the child layer, check the delete fid is in one of the locality_fuid values
        child_locality_fuids = {child_feature.attribute("locality_fuid") for child_feature in child_layer.getFeatures()}
        assert delete_locality_fuid in child_locality_fuids

    assert_tool_enabled(fdc_project, layer_name, QuickDeleteTool, expected_tool_name)


@pytest.mark.parametrize(
    ["layer_name", "line_type_code"],
    zip(
        sorted(FEATURE_TABLES_LINES),
        LINE_TYPE_CODES,
    ),
)
def test_lines_add_confirm(
    layer_name: str,
    line_type_code: str,
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
    empty_geometry_feature_line: QgsFeature,
):
    # Arrange
    expected_tool_name = f"fdc_{layer_name}_add"
    # Enable add quick line mode for given layer
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=True)

    # Emit signal as if user selected a line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(layer_name, line_type_code)

    # Act
    fdc_project.quick_map_tool.digitizingCompleted.emit(empty_geometry_feature_line)

    # Assert
    # Check that the new feature has the correct attributes and geometry
    expected_fid = 2
    new_feature: QgsFeature = list(layer.getFeatures())[-1]
    assert new_feature.attribute("fid") == expected_fid
    assert new_feature.attribute("line_type_code") == line_type_code
    assert new_feature.geometry().asWkt() == empty_geometry_feature_line.geometry().asWkt()
    assert_tool_enabled(fdc_project, layer_name, QuickAddTool, expected_tool_name)


@pytest.mark.parametrize(
    ["layer_name", "line_type_code"],
    zip(
        sorted(FEATURE_TABLES_LINES),
        LINE_TYPE_CODES,
    ),
)
def test_lines_add_cancel(
    layer_name: str,
    line_type_code: str,
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
    empty_geometry_feature_line: QgsFeature,
):
    # Arrange
    expected_tool_name = f"fdc_{layer_name}_add"
    # Enable add quick line mode for given layer
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=False)

    # Emit signal as if user selected a line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(layer_name, line_type_code)

    # Act
    fdc_project.quick_map_tool.digitizingCompleted.emit(empty_geometry_feature_line)

    # Assert
    # Check that there are only 2 features
    features = list(layer.getFeatures())
    assert len(features) == 1
    # Check that the expected new fid is not in any features
    expected_fid = 2
    feature_fids = {feature.attribute("fid") for feature in features}
    assert expected_fid not in feature_fids
    assert_tool_enabled(fdc_project, layer_name, QuickAddTool, expected_tool_name)


@pytest.mark.parametrize("layer_name", FEATURE_TABLES_LINES)
def test_lines_edit_confirm(
    layer_name: str,
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    edit_field = "line_label"
    new_value = "dummy_value"
    expected_tool_name = "fdc_lines_edit"
    # Enable edit quick line mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=True, attributes={edit_field: new_value})

    # Act
    # Emit the signal which would open the form and auto save afterwards
    edit_feature_fid = 1
    feature_to_edit = layer.getFeature(edit_feature_fid)
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_edit, layer)

    # Assert
    # Check that the edit has been saved correctly
    assert layer.getFeature(edit_feature_fid).attribute(edit_field) == new_value
    assert_tool_enabled(fdc_project, FEATURE_TABLES_LINES, QuickEditTool, expected_tool_name)


@pytest.mark.parametrize(
    ["layer_name", "old_value"],
    zip(
        sorted(FEATURE_TABLES_LINES),
        (
            # Test artificial_line line_label
            "test_line_artificial",
            # Test bedrock_line line_label
            "test_line_bedrock",
            # Test mass_move_line line_label
            "test_line_mass_move",
            # Test superficial_line line_label
            "test_line_superficial",
            # Test terrain_line line_label
            "test_line_terrain",
        ),
    ),
)
def test_lines_edit_cancel(
    layer_name: str,
    old_value: str,
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    edit_field = "line_label"
    expected_tool_name = "fdc_lines_edit"
    # Enable edit quick line mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]

    monkeypatch_feature_form(monkeypatch, save=False)

    # Act
    # Emit the signal which would open the form and auto save afterwards
    edit_feature_fid = 1
    feature_to_edit = layer.getFeature(edit_feature_fid)
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_edit, layer)

    # Assert
    # Check that the edit has not been saved
    assert layer.getFeature(edit_feature_fid).attribute(edit_field) == old_value
    assert_tool_enabled(fdc_project, FEATURE_TABLES_LINES, QuickEditTool, expected_tool_name)


@pytest.mark.parametrize("layer_name", FEATURE_TABLES_LINES)
def test_lines_delete_confirm(
    layer_name: str,
    fdc_project: FieldDataCapture,
    monkeypatch_qmsgbox_question_yes,
):
    # Arrange
    expected_tool_name = "fdc_lines_delete"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Enable delete quick lines mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    delete_feature_fid = 1

    # Act
    # Delete one of the test features
    # Emit the signal which would delete an identified feature and save after confirmation
    feature_to_delete = layer.getFeature(delete_feature_fid)
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_delete, layer)

    # Assert
    # Check that there are no features remaining
    assert len(list(layer.getFeatures())) == 0
    assert_tool_enabled(fdc_project, FEATURE_TABLES_LINES, QuickDeleteTool, expected_tool_name)


@pytest.mark.parametrize("layer_name", FEATURE_TABLES_LINES)
def test_lines_delete_cancel(
    layer_name: str,
    fdc_project: FieldDataCapture,
    monkeypatch_qmsgbox_question_no,
):
    # Arrange
    expected_tool_name = "fdc_lines_delete"
    layer = QgsProject.instance().mapLayersByName(layer_name)[0]
    # Enable delete quick lines mode
    fdc_project.quick_map_tool_buttons[expected_tool_name].trigger()
    delete_feature_fid = 1

    # Act
    # Delete one of the test features
    # Emit the signal which would delete an identified feature and save after confirmation
    feature_to_delete = layer.getFeature(delete_feature_fid)
    fdc_project.quick_map_tool.identified_feature.emit(feature_to_delete, layer)

    # Assert
    # Check that there is still 1 feature
    features = list(layer.getFeatures())
    assert len(features) == 1
    # Check that it's fid value is not deleted
    assert delete_feature_fid in {feature.attribute("fid") for feature in features}
    assert_tool_enabled(fdc_project, FEATURE_TABLES_LINES, QuickDeleteTool, expected_tool_name)
