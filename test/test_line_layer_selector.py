import pytest

from plugin.field_data_capture import FieldDataCapture
from plugin.line_layer_selector import LineLayerSelector
from plugin.utils import (  # noqa
    get_combobox_items_dict,
    set_combobox_index_by_data,
    ipdb_breakpoint,
)


@pytest.fixture()
def default_data() -> dict[str, str]:
    return {
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
    layers_to_cats_to_types = LineLayerSelector.get_layers_to_categories_to_types()
    default_data["layer"].extend(list(layers_to_cats_to_types.keys()))

    # Assert
    for line_attribute, combobox in line_selector.comboboxes.items():
        # All comboboxes should start with no selection
        assert combobox.currentData() is None
        assert list(get_combobox_items_dict(combobox).keys()) == default_data[line_attribute]


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
def test_selection_all_comboboxes(
    layer: str,
    category: str,
    line_selector: LineLayerSelector,
):
    # Arrange
    layers_to_cats_to_types = LineLayerSelector.get_layers_to_categories_to_types()
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
    ["layer", "category", "line_type"],
    (
        ("artificial_line", "ARTIFICIAL_GROUND_LINE", "small_quarry_or_pit"),
        ("artificial_line", "ARTIFICIAL_GROUND_LINE", "cliffline_quarry"),
        ("bedrock_line", "BEDROCK_HORIZON", "base_of_lava_flow"),
        ("terrain_line", "TERRAIN_LINE", "concave_break_of_slope"),
    ),
)
def test_preselect(
    layer: str,
    category: str,
    line_type: str,
    fdc_project: FieldDataCapture,
):
    # Arrange
    expected_selection = {
        "layer": layer,
        "category": category,
        "type": line_type,
    }

    # Act
    # Preselect some data, the category should not be needed here
    preselection = expected_selection.copy()
    preselection.pop("category")
    line_selector = LineLayerSelector(preselect_line_type=preselection)

    # Assert
    for line_attribute, combobox in line_selector.comboboxes.items():
        assert combobox.currentData() == expected_selection[line_attribute]


@pytest.mark.parametrize(
    ["line_attribute_modify", "new_value", "comboboxes_reset"],
    (
        # Selecting a new layer should reset the category and type
        ("layer", "bedrock_line", ["category", "type"]),
        ("layer", "terrain_line", ["category", "type"]),
        # Selecting just a new category should reset the type
        ("category", "ARTIFICIAL_GROUND_BOUNDARY", ["type"]),
        ("category", "ARTIFICIAL_GROUND_LINE_UNDERGROUND", ["type"]),
    ),
)
def test_default_reset(
    line_attribute_modify: str,
    new_value: str,
    comboboxes_reset: list[str],
    fdc_project: FieldDataCapture,
):
    # Arrange
    # Preselect some data so that it can be reset
    line_selector = LineLayerSelector(preselect_line_type={"layer": "artificial_line", "type": "small_quarry_or_pit"})

    # Act
    # Select a different value which should reset some comboboxes
    set_combobox_index_by_data(line_selector.comboboxes[line_attribute_modify], new_value)

    # Assert
    for line_attribute in comboboxes_reset:
        assert line_selector.comboboxes[line_attribute].currentData() is None
