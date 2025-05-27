from pathlib import Path
from typing import (
    Any,
    Callable,
    Optional,
)

import pytest

from qgis.core import (
    QgsGeometry,
    QgsProject,
    QgsSettings,
    QgsVectorLayer,
)
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QMessageBox,
)

from plugin.config import TABLE_LIST
from plugin.field_data_capture import FieldDataCapture
from plugin.utils import (  # noqa
    MultilineMessageBox,
    create_prepopulated_feature,
    get_table_rows,
    get_combobox_items_dict,
    set_combobox_index_by_data,
    get_msgbox_icon_pixmap,
    ipdb_breakpoint,
)

COMBOBOX_DATA = {
    "Default": None,
    "Item A": "item_a",
    "Item B": "item_b",
    "Item C": "item_c",
}


def test_validation_good(fdc_project: FieldDataCapture):
    assert fdc_project.validate_qgis_state(
        project_active=True,
        db_file_exists=True,
        fdc_layers_exist=True,
        field_project_exists=True,
    )
    assert not fdc_project.project_instance.isDirty()


def test_validation_bad(fdc: FieldDataCapture):
    assert not fdc.validate_qgis_state(project_active=True, fdc_layers_exist=True)


def test_check_field_project_exists(
    fdc: FieldDataCapture,
    qgs_project,
    empty_geometry_feature_polygon,
):
    # Assert 1, the layer does not exist
    assert not fdc.check_field_project_exists()

    # Act 1, add fdc layers
    fdc.add_gpkg_to_project()
    fdc.add_gpkg_layers_to_project()

    # Assert 2, the layer exists but has no features
    assert not fdc.check_field_project_exists()

    # Act 2, add an unsaved field_project
    layer = fdc.get_fdc_layer("field_project")
    layer.startEditing()
    # Create new feature
    feature = create_prepopulated_feature(
        layer,
        prepopulate={
            "short_name": "test_field_project",
            "local_epsg": 27700,
        },
    )
    # Add geometry
    feature.setGeometry(empty_geometry_feature_polygon.geometry())
    # Add feature to layer
    layer.addFeature(feature)

    # Assert 3, the layer exists with a feature but the feature is not saved
    assert not fdc.check_field_project_exists()

    # Act 3, save the feature so all the checks are good
    layer.commitChanges()

    # Assert 4, all the checks are good
    assert fdc.check_field_project_exists()


@pytest.fixture()
def combobox() -> QComboBox:
    """
    Create and populate QComboBox for tests.
    """
    combobox = QComboBox()
    for label, user_data in COMBOBOX_DATA.items():
        combobox.addItem(label, userData=user_data)
    return combobox


@pytest.mark.parametrize(
    ["sql", "count"],
    (
        ("SELECT * FROM field_project", 1),
        ("SELECT *, AsText(CastAutomagic(geometry)) as geom FROM locality_point", 2),
    ),
)
def test_get_rows(fdc_project: FieldDataCapture, sql: str, count: int):
    # Act
    rows = get_table_rows(fdc_project.db_file, sql)

    # Assert
    assert isinstance(rows, list)
    assert len(rows) == count
    assert isinstance(rows[0], dict)


def test_get_combobox_items_dict(combobox: QComboBox):
    # Assert
    assert get_combobox_items_dict(combobox) == COMBOBOX_DATA


@pytest.mark.parametrize(
    ["data", "data_set"],
    (
        ("item_a", True),
        ("item_b", True),
        ("item_c", True),
        ("item_d", False),
        ("item_e", False),
    ),
)
def test_set_combobox_index_by_data(
    data: Any,
    data_set: bool,
    combobox: QComboBox,
):
    # Act
    set_combobox_index_by_data(combobox, data)

    # Assert
    assert (combobox.currentData() == data) is data_set


@pytest.mark.parametrize(
    ["layer_name", "prepopulate", "wkt"],
    (
        ("locality_point", {"locality_type_code": "outcrop", "map_face_note": "Honk"}, "Point (-3 55)"),
        ("bedrock_line", {"line_label": "Quack"}, "LineString (-3 55, 55 -3)"),
    ),
)
def test_create_prepopulated_feature(
    layer_name: str,
    prepopulate: dict[str, Any],
    wkt: str,
    fdc_project: FieldDataCapture,
):
    # Arrange
    layer = fdc_project.get_fdc_layer(layer_name)
    geometry = QgsGeometry.fromWkt(wkt)

    # Act
    feature = create_prepopulated_feature(layer, prepopulate, geometry)

    # Assert
    for attribute, value in prepopulate.items():
        assert feature.attribute(attribute) == value
    assert feature.geometry().asWkt() == wkt


@pytest.mark.parametrize("layer_name", TABLE_LIST)
def test_get_fdc_layer_good(layer_name: str, fdc_project: FieldDataCapture):
    # Arrange
    # Create a temporary layer with the same name as the target layer
    # The test should still pass because the get_fdc_layer method checks the data source path
    temp_layer = QgsVectorLayer("Point?crs=epsg:4326", layer_name, "memory")
    QgsProject.instance().addMapLayer(temp_layer)

    # Act
    layer = fdc_project.get_fdc_layer(layer_name)

    # Assert
    assert isinstance(layer, QgsVectorLayer)
    assert Path(layer.dataProvider().dataSourceUri().split("|")[0]) == fdc_project.db_file.absolute()


@pytest.mark.parametrize("layer_name", TABLE_LIST)
def test_get_fdc_layer_bad(layer_name: str, fdc: FieldDataCapture):
    # Act
    layer = fdc.get_fdc_layer(layer_name)

    # Assert
    assert layer is None


def test_get_layer_label_rule(fdc_project: FieldDataCapture):
    # Arrange
    expected_expression = "map_face_note"

    # Act
    rule = fdc_project.get_layer_label_rule("locality_point", "map face note")

    # Assert
    assert rule.settings().fieldName == expected_expression


@pytest.mark.parametrize(
    ["name", "value", "expected_value", "set_value"],
    (
        # Set the value to True, we expect True back
        ("quack", True, True, True),
        # Set the value to 100, we expect 100 back
        ("honk", 100, 100, True),
        # Don't set the value, we expect None back
        ("duck", "not set", None, False),
        # Set the value to "false", we expect False back as it gets converted
        ("goose", "false", False, True)
    ),
)
def test_get_plugin_setting(
    name: str,
    value: Any,
    expected_value: Any,
    set_value: bool,
    fdc_project: FieldDataCapture,
):
    # Arrange
    # Set the value if specified
    # We test some values that are not set
    if set_value:
        fdc_project.set_plugin_setting(name, value)

    # Act
    actual_value = fdc_project.get_plugin_setting(name)

    # Assert
    assert actual_value == expected_value


@pytest.mark.parametrize(
    ["name", "value"],
    (
        ("quack", True),
        ("honk", 100),
        ("duck", "goose"),
    ),
)
def test_set_plugin_setting(
    name: str,
    value: Any,
    fdc_project: FieldDataCapture,
):
    # Act
    fdc_project.set_plugin_setting(name, value)

    # Assert
    # Get the value from QgsSettings
    assert QgsSettings().value(f"{fdc_project.plugin_settings_prefix}/{name}") == value


@pytest.mark.parametrize(
    ["msgbox_method", "title", "message", "text"],
    (
        (MultilineMessageBox.information, "This is a duck", "Duck goes quack", "Multiline\nDuck\nQuacking"),
        (MultilineMessageBox.warning, "This is a goose", "Goose goes honk", "Multiline\nGoose\nHonking"),
        (MultilineMessageBox.critical, "This is not a duck", "Duck does not go quack", None),
    ),
)
def test_multiline_messagebox(
    msgbox_method: Callable[[str, str, Optional[str]], MultilineMessageBox],
    title: str,
    message: str,
    text: str,
    fdc: FieldDataCapture,
):
    # Arrange
    methods_to_icons = {
        MultilineMessageBox.information: QMessageBox.Information,
        MultilineMessageBox.warning: QMessageBox.Warning,
        MultilineMessageBox.critical: QMessageBox.Critical,
    }
    expected_image = get_msgbox_icon_pixmap(methods_to_icons[msgbox_method]).toImage()
    expected_minimum_width = 500

    # Act
    msgbox = msgbox_method(title, message, text)

    # Assert
    assert msgbox.windowTitle() == title
    assert msgbox.message_icon.pixmap().toImage() == expected_image
    assert msgbox.message_label.text() == message
    if text is None:
        assert msgbox.text_edit.toPlainText() == ""
        assert msgbox.text_edit.isHidden()
    else:
        assert msgbox.text_edit.toPlainText() == text
        assert not msgbox.text_edit.isHidden()
        assert msgbox.minimumWidth() == expected_minimum_width
