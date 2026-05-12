# Copyright 2026 British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
import json
from unittest.mock import Mock

import pytest
from qgis.PyQt.QtWidgets import QRadioButton

from plugin.field_data_capture import FieldDataCapture
from plugin.line_layer_selector import LineLayerSelector
from plugin.utils import (  # noqa
    get_combobox_items_dict,
    set_combobox_index_by_data,
    ipdb_breakpoint,
)


@pytest.fixture()
def line_selector(fdc_project: FieldDataCapture) -> LineLayerSelector:
    """
    Return an instance of the line layer selector, with a Field Data Capture project ready to use.
    """
    return LineLayerSelector()


def test_default_state(line_selector: LineLayerSelector):
    # Arrange
    default_data = {
        "layer": "Filter by parent line layer",
        "category": "Filter by category",
        "type": "Search or select line type",
    }

    # Put default values into lists
    for key, value in default_data.items():
        default_data[key] = [value]

    # The layer combobox should default to include all line layers
    default_data["layer"].extend(list(line_selector.layers_to_cats_to_types.keys()))

    # The line type combobox default to include all line types
    default_data["type"].extend(list(line_selector.line_type_layers.keys()))

    # Assert
    # Check comboboxes
    for line_attribute, combobox in line_selector.comboboxes.items():
        assert combobox.currentData() is None
        assert list(get_combobox_items_dict(combobox).keys()) == default_data[line_attribute]

    # Check line text is selected, ready to delete.  A test for `hasFocus` didn't work in pytest.
    assert line_selector.comboboxes["type"].lineEdit().selectedText() == default_data["type"][0]

    # Check radio buttons
    for line_dict in LineLayerSelector.default_types:
        assert line_dict["type"] in line_selector.recent_line_buttons
        recent_line_button = line_selector.recent_line_buttons[line_dict["type"]]
        assert isinstance(recent_line_button, QRadioButton)
        assert recent_line_button.text() == line_dict["type"]

    # Check that there are 2 items in the dialog layout, the all line types layout and the recent line types
    assert line_selector.layout().count() == 2


@pytest.mark.parametrize(
    ["layer", "category"],
    (
        ("artificial_line", "ARTIFICIAL_GROUND_BOUNDARY"),
        ("artificial_line", "ARTIFICIAL_GROUND_LINE_UNDERGROUND"),
        ("bedrock_line", "BEDROCK_HORIZON"),
        ("bedrock_line", "BEDROCK_BOUNDARY"),
        ("terrain_line", "TERRAIN_LINE"),
    ),
)
def test_selection_main_comboboxes(
    layer: str,
    category: str,
    line_selector: LineLayerSelector,
):
    # Arrange
    # The layer selection can update the category and type options
    expected_layer_categories = set(line_selector.layers_to_cats_to_types[layer].keys())
    expected_layer_line_types = {
        line_type
        for line_category in expected_layer_categories
        for line_type in line_selector.layers_to_cats_to_types[layer][line_category]
    }
    # The category selection can only update the type options
    expected_category_line_types = set(line_selector.layers_to_cats_to_types[layer][category])

    # Assert 0
    # Category combobox should be disabled to start with
    assert line_selector.comboboxes["category"].isEnabled() is False

    # Act 1 - Select a layer
    set_combobox_index_by_data(line_selector.comboboxes["layer"], layer)

    # Assert 1 - Check that categories and line_types are from given layer
    layer_categories_data_list = list(get_combobox_items_dict(line_selector.comboboxes["category"]).keys())
    assert set(layer_categories_data_list[1:]) == expected_layer_categories
    layer_line_types_data_list = list(get_combobox_items_dict(line_selector.comboboxes["type"]).keys())
    assert set(layer_line_types_data_list[1:]) == expected_layer_line_types
    assert line_selector.comboboxes["category"].isEnabled() is True

    # Act 2 - Select a category
    set_combobox_index_by_data(line_selector.comboboxes["category"], category)

    # Assert 2 - Check that line_types are from given category
    category_line_types_data_list = list(get_combobox_items_dict(line_selector.comboboxes["type"]).keys())
    assert set(category_line_types_data_list[1:]) == expected_category_line_types


@pytest.mark.parametrize(
    ["line_attribute_modify", "new_value", "comboboxes_reset"],
    (
        # Selecting a new layer should reset the category
        ("layer", "bedrock_line", ["category"]),
        ("layer", "terrain_line", ["category"]),
    ),
)
def test_default_reset(
    line_attribute_modify: str,
    new_value: str,
    comboboxes_reset: list[str],
    line_selector: LineLayerSelector,
):
    # Arrange
    # Select some data so that it can be reset
    # But not the type because that auto confirms the selection
    set_combobox_index_by_data(line_selector.comboboxes["layer"], "artificial_line")
    set_combobox_index_by_data(line_selector.comboboxes["category"], "ARTIFICIAL_GROUND_BOUNDARY")

    # Act
    # Select a different value which should reset some comboboxes
    set_combobox_index_by_data(line_selector.comboboxes[line_attribute_modify], new_value)

    # Assert
    for line_attribute in comboboxes_reset:
        assert line_selector.comboboxes[line_attribute].currentData() is None


@pytest.mark.parametrize(
    ["layer", "line_type"],
    (
        ("artificial_line", "small_quarry_or_pit"),
        ("artificial_line", "cliffline_quarry"),
        ("bedrock_line", "base_of_lava_flow"),
        ("terrain_line", "concave_break_of_slope"),
    ),
)
def test_line_type_selected(
    layer: str,
    line_type: str,
    fdc_project: FieldDataCapture,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    # Apply monkeypatch to LineLayerSelector.confirm_selection so we can check if it is called
    confirm_mock = Mock()
    monkeypatch.setattr(LineLayerSelector, "confirm_selection", confirm_mock)
    # Get LineLayerSelector manually after applying monkeypatch
    line_selector = LineLayerSelector()
    # Select a line layer so line type options are available
    set_combobox_index_by_data(line_selector.comboboxes["layer"], layer)

    # Act
    # Select a line type
    set_combobox_index_by_data(line_selector.comboboxes["type"], line_type)
    # Manually emit the activated signal because it ignores programmatic calls
    # The signal requires an integer, which is meant to represent an index but we do not use it
    line_selector.comboboxes["type"].activated.emit(0)

    # Assert
    confirm_mock.assert_called_once()


def test_line_selector_open(fdc_project: FieldDataCapture):
    # Act
    # Open line selector
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()

    # Assert
    # Button should be toggled
    assert fdc_project.quick_map_tool_buttons["fdc_lines_add"].isChecked()
    # Tool should be saved to FDC class
    assert isinstance(fdc_project.line_layer_selector, LineLayerSelector)
    # There should be no recent line types
    assert fdc_project.get_plugin_setting("recent_line_types") is None


def test_line_selector_close(fdc_project: FieldDataCapture):
    # Arrange
    # Open line selector
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()

    # Act
    # Close line selector without selecting a line type
    fdc_project.line_layer_selector.closeEvent()

    # Assert
    # Button should not be toggled
    assert not fdc_project.quick_map_tool_buttons["fdc_lines_add"].isChecked()
    # Tool should be deleted from FDC class
    assert fdc_project.line_layer_selector is None
    # There should be no recent line types
    assert fdc_project.get_plugin_setting("recent_line_types") is None


@pytest.mark.parametrize(
    ["line_dict", "expected_recent_line_types"],
    (
        # Select a new line type
        (
            {"layer": "artificial_line", "type": "cliffline_quarry"},
            [{"layer": "artificial_line", "type": "cliffline_quarry"}] + LineLayerSelector.default_types[:5]),  # noqa
        # Select an already existing duplicate line type
        (
            LineLayerSelector.default_types[3],
            [LineLayerSelector.default_types[3]] + LineLayerSelector.default_types[:3] + LineLayerSelector.default_types[4:6],  # noqa
        ),
    ),
)
def test_line_selector_add_recent(
    line_dict: dict[str, str],
    expected_recent_line_types: list[dict[str, str]],
    fdc_project: FieldDataCapture,
):
    # Act
    # Open line selector
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
    # Call the confirm method as if user selected a line type
    fdc_project.line_layer_selector.confirm_selection(line_layer=line_dict["layer"], line_type=line_dict["type"])

    # Assert
    # Button should remain toggled
    assert fdc_project.quick_map_tool_buttons["fdc_lines_add"].isChecked()
    # Tool should be deleted from FDC class
    assert fdc_project.line_layer_selector is None
    # Selected line type should be added to recents
    recent_line_types = json.loads(fdc_project.get_plugin_setting("recent_line_types"))
    assert recent_line_types == expected_recent_line_types
