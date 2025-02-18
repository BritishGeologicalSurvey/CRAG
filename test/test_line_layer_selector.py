from unittest.mock import Mock

import pytest

from plugin.field_data_capture import FieldDataCapture
from plugin.line_layer_selector import LineLayerSelector
from plugin.utils import (  # noqa
    get_combobox_items_dict,
    set_combobox_index_by_data,
    ipdb_breakpoint,
)

LINE_LAYER_TYPE = [
    {
        "layer": "artificial_line",
        "type": "cliffline_quarry",
    },
    {
        "layer": "bedrock_line",
        "type": "base_of_lava_flow",
    },
    {
        "layer": "mass_move_line",
        "type": "landslide_head_zone_limit",
    },
    {
        "layer": "superficial_line",
        "type": "axis_of_megagroove",
    },
    {
        "layer": "terrain_line",
        "type": "convex_break_of_slope",
    },
]


@pytest.fixture()
def default_data() -> dict[str, str]:
    return {
        "recent": "Select Line Type",
        "layer": "Select Line Layer",
        "category": "Select Line Category",
        "type": "Select Line Type",
    }


@pytest.fixture()
def line_selector(fdc_project: FieldDataCapture) -> LineLayerSelector:
    """
    Return an instance of the line layer selector, with a Field Data Capture project ready to use.
    """
    return LineLayerSelector()


def test_default_state(line_selector: LineLayerSelector, default_data: dict[str, str]):
    # Arrange
    # Put default values into lists
    for key, value in default_data.items():
        default_data[key] = [value]
    # The layer combobox should always have values as well as it's default data
    layers_to_cats_to_types = line_selector.get_layers_to_categories_to_types()
    default_data["layer"].extend(list(layers_to_cats_to_types.keys()))

    # Assert
    for line_attribute, combobox in line_selector.comboboxes.items():
        # All comboboxes should start with no selection
        assert combobox.currentData() is None
        assert list(get_combobox_items_dict(combobox).keys()) == default_data[line_attribute]

    # Check that recent combobox starts disabled as no recent line selection is provided
    assert not line_selector.comboboxes["recent"].isEnabled()


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
    layers_to_cats_to_types = line_selector.get_layers_to_categories_to_types()
    # The layer selection can update the category and type options
    expected_layer_categories = set(layers_to_cats_to_types[layer].keys())
    expected_layer_line_types = {
        line_type
        for line_category in expected_layer_categories
        for line_type in layers_to_cats_to_types[layer][line_category]
    }
    # The category selection can only update the type options
    expected_category_line_types = set(layers_to_cats_to_types[layer][category])

    # Act 1 - Select a layer
    set_combobox_index_by_data(line_selector.comboboxes["layer"], layer)

    # Assert 1 - Check that categories and line_types are from given layer
    layer_categories_data_list = list(get_combobox_items_dict(line_selector.comboboxes["category"]).keys())
    assert set(layer_categories_data_list[1:]) == expected_layer_categories
    layer_line_types_data_list = list(get_combobox_items_dict(line_selector.comboboxes["type"]).keys())
    assert set(layer_line_types_data_list[1:]) == expected_layer_line_types

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
    assert len(fdc_project.recent_quick_line_types) == 0


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
    assert len(fdc_project.recent_quick_line_types) == 0


def test_line_selector_add_recent(fdc_project: FieldDataCapture):
    # Arrange
    line_dict_1 = LINE_LAYER_TYPE[0]
    line_dict_2 = LINE_LAYER_TYPE[1]

    # Act 1
    # Open line selector
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
    # Emit signal as if user selected a line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(line_dict_1["layer"], line_dict_1["type"])

    # Assert 1
    # Button should remain toggled
    assert fdc_project.quick_map_tool_buttons["fdc_lines_add"].isChecked()
    # Tool should be deleted from FDC class
    assert fdc_project.line_layer_selector is None
    # Selected line type should be added to recents
    assert fdc_project.recent_quick_line_types == [line_dict_1]

    # Act 2
    # Open line selector
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
    # Emit signal as if user selected a line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(line_dict_2["layer"], line_dict_2["type"])

    # Assert 2
    # Both selected line types should be added to recents
    assert fdc_project.recent_quick_line_types == [line_dict_2, line_dict_1]


def test_line_selector_add_recent_duplicate(fdc_project: FieldDataCapture):
    # Arrange
    # Define first 3 line types to select and the duplicate line
    first_line_dicts = LINE_LAYER_TYPE[:3]
    line_dict_duplicate = first_line_dicts[0]
    # Define the expected line types in the recent lines
    # The selected line should be added to recents only once
    # But the order will change so that the duplicate is at the start of the list
    # Instead of the end
    # The list of first_line_dicts is also reversed as the newest line type will be at the start, not the end
    expected_end_line_dicts = first_line_dicts[1:]
    expected_end_line_dicts.reverse()
    expected_line_dicts = [line_dict_duplicate] + expected_end_line_dicts

    # Select 3 line types so that duplicate is moved
    for line_dict in first_line_dicts:
        # Open line selector
        fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
        # Emit signal as if user selected a line type
        fdc_project.line_layer_selector.line_layer_selector_confirm.emit(
            line_dict["layer"],
            line_dict["type"],
        )

    # Act
    # Select the first line type again so that it is a duplicate
    # Open line selector
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
    # Emit signal as if user selected the same line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(
        line_dict_duplicate["layer"],
        line_dict_duplicate["type"],
    )

    # Assert
    assert fdc_project.recent_quick_line_types == expected_line_dicts


def test_line_selector_add_recent_multiple(fdc_project: FieldDataCapture):
    # Arrange
    # Selecting first 4 line types will reach the limit of recents
    first_line_dicts = LINE_LAYER_TYPE[:4]
    expected_first_line_dicts = first_line_dicts.copy()
    expected_first_line_dicts.reverse()
    # Selecting 5th line type will remove 1st from end and add 5th to the start
    # Making it still 4 line types in total
    final_line_type_dict = LINE_LAYER_TYPE[4]
    expected_second_line_dicts = [final_line_type_dict] + expected_first_line_dicts[:3]

    # Act 1
    # Select the first 4 line types to reach the limited number of recent saved line types
    for line_dict in first_line_dicts:
        # Open line selector
        fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
        # Emit signal as if user selected a line type
        fdc_project.line_layer_selector.line_layer_selector_confirm.emit(
            line_dict["layer"],
            line_dict["type"],
        )

    # Assert 1
    assert fdc_project.recent_quick_line_types == expected_first_line_dicts

    # Act 2
    # Select a 5th line type to go over the 4 recents limit
    # Open line selector
    fdc_project.quick_map_tool_buttons["fdc_lines_add"].trigger()
    # Emit signal as if user selected a line type
    fdc_project.line_layer_selector.line_layer_selector_confirm.emit(
        final_line_type_dict["layer"],
        final_line_type_dict["type"],
    )

    # Assert
    assert fdc_project.recent_quick_line_types == expected_second_line_dicts
