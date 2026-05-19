# Copyright 2026 British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
"""
These are tests for the plugin which depend on a running QGIS version which is supplied by the 'fdc' fixture.
"""
import re
from pathlib import Path
from typing import Optional
from unittest.mock import Mock
from xml.dom import minidom


import pytest
from bs4 import BeautifulSoup
import etlhelper as etl
from qgis.core import (
    QgsAttributeEditorContainer,
    QgsExpression,
    QgsExpressionContext,
    QgsExpressionContextUtils,
    QgsFeature,
    QgsField,
    QgsFields,
    QgsGeometry,
    QgsLayerTreeGroup,
    QgsProject,
    QgsVectorLayerUtils,
)
from qgis.PyQt.QtCore import QMetaType
from qgis.PyQt.QtWidgets import QMessageBox

from conftest import setup_db_conn
from plugin.config import (
    ATTRIBUTE_TABLES,
    FEATURE_TABLES,
    TABLE_LIST,
    LAYER_TREE_STRUCTURE_INDEXED,
)
from plugin.field_data_capture import FieldDataCapture
from plugin.report_builder import ReportBuilder
from plugin.about_dialog import AboutDialog
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
        "open_create_field_project": None,
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
        fdc.open_create_field_project,
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
        "open_create_field_project": None,
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
        fdc.open_create_field_project,
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
    assert Path(fdc.db_file).exists()

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
        "field_project",
        "locality_data",
        "metadata",
    ]
    expected_qml_files = [
        # Make the expected path relative to the project root
        Path(qml_file.parent.name) / qml_file.name
        for qml_file in Path("plugin/styles").glob("*.qml")
    ]
    expected_slyr_style = Path("sigmaQ_2024_v2.xml")
    expected_user_dirs = [
        fdc.photos_dir,
        fdc.media_dir,
        fdc.baseline_data_dir,
        fdc.unlinked_files_dir,
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
        assert LAYER_TREE_STRUCTURE_INDEXED[group.name()] == group_layer_names

    hidden_layers = {"view_media", "view_photo", "view_sample"}
    for layer in QgsProject.instance().mapLayers().values():
        # Check that dic layers are readonly
        if layer.name().startswith("dic"):
            assert layer.readOnly()
        # Check that correct layers are hidden
        expected_visible = True
        if layer.name() in hidden_layers:
            expected_visible = False
        assert expected_visible == QgsProject.instance().layerTreeRoot().findLayer(layer).itemVisibilityChecked()

    # Check that the style files have been copied into the project directory
    actual_qml_files = [
        # Make the actual path relative to the plugin root
        Path(qml_file.parent.name) / qml_file.name
        for qml_file in fdc.styles_dir.glob("*.qml")
    ]
    assert expected_qml_files == actual_qml_files
    assert (fdc.styles_dir / expected_slyr_style).exists()

    # Check that the empty user directories have been created
    for directory in expected_user_dirs:
        assert directory.exists()
        assert list(directory.glob("*.*"))[0].name == fdc.placeholder_filename


def test_open_create_field_project_already_exists(fdc_project_quick: FieldDataCapture):
    # Arrange
    expected_args = [
        None,
        "Warning",
        "A Field Project feature already exists for this project.",
    ]

    # Act
    fdc_project_quick.open_create_field_project()

    # Assert
    QMessageBox.warning.assert_called_with(*expected_args)


def test_add_test_data_to_project(fdc: FieldDataCapture, qgs_project: Path):
    # Arrange
    fdc.add_gpkg_to_project()
    fdc.add_gpkg_layers_to_project()
    expected_row_counts = {
        "field_project": 1,
        "locality_point": 2,
        "structural_measurement": 2,
        "lithology": 4,
        "media": 9,
        "photo": 4,
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
        qml_filepath: qml_filepath.stat().st_mtime
        for qml_filepath in fdc.styles_dir.glob("*.qml")
    }
    # Get a dictionary of filepaths to expected copyright comments
    default_copyright = (
        "<!--\nCopyright 2026 British Geological Survey\n"
        "Licensed under GPLv3 licence\nSPDX-License-Identifier: GPL-3.0-or-later\n-->\n"
    )
    expected_copyright_comments = dict.fromkeys(fdc.styles_dir.glob("*.qml"), default_copyright)
    # Manually change some copyright comments to test edge cases
    # Valid comment different to default
    expected_copyright_comments[fdc.styles_dir / "lithology.qml"] = default_copyright.replace("Geological", "Duck")
    # Valid 1 line comment
    expected_copyright_comments[fdc.styles_dir / "locality_point.qml"] = "<!--Copyright Quack Licensed Honk-->"
    # Not a valid copyright comment
    expected_copyright_comments[fdc.styles_dir / "sample.qml"] = "<!--Not a licence\nIllegal Goose\n-->\n"
    # No comment
    expected_copyright_comments[fdc.styles_dir / "terrain_line.qml"] = ""
    invalid_comment_style_names = {"sample", "terrain_line"}
    # Write the new comments to the style files
    for qml_filepath, copyright_comment in expected_copyright_comments.items():
        if copyright_comment != default_copyright:
            qml_filepath.write_text(qml_filepath.read_text().replace(default_copyright, copyright_comment))

    # Act
    function_return = fdc.export_qml_styles()

    # Assert
    assert function_return
    for qml_filepath in fdc.styles_dir.glob("*.qml"):

        # Ensure the previously existing timestamp is smaller than the current file timestamp
        # this essentially means that the file has been changed
        assert existing_qml_files[qml_filepath] < qml_filepath.stat().st_mtime

        # Ensure that the correct categories have been exported in the XML data
        xml_data = minidom.parse(str(qml_filepath))
        categories_str = xml_data.getElementsByTagName("qgis")[0].attributes["styleCategories"].value
        categories_set = set(categories_str.split("|"))
        assert categories_set == expected_categories

        # Ensure that the style file contains the correct copyright comment at the top
        expected_file_start = expected_copyright_comments[qml_filepath]
        # If the comment is invalid or missing, then the file should start with the first QGIS XML tag
        if qml_filepath.stem in invalid_comment_style_names:
            expected_file_start = "<qgis"
        assert qml_filepath.read_text().startswith(expected_file_start)


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


@pytest.mark.parametrize(
    ["qgis_platform", "no_mergin", "expected_username"],
    (
        ("desktop", False, "desktop_tester"),
        ("desktop", True, "desktop_tester"),
        ("external", False, "mergin_tester"),
        ("external", True, "desktop_tester"),
    ),
)
def test_auto_increment_locality_point_name(
    fdc_project: FieldDataCapture,
    qgis_platform: str,
    no_mergin: bool,
    expected_username: str,
):
    # Arrange
    name_var_to_username = {
        "user_account_name": "desktop_tester",
        "mergin_username": "mergin_tester",
    }
    # If simulating that mergin is missing, remove the mergin_username variable from settings
    if no_mergin:
        name_var_to_username.pop("mergin_username")
    # Generate a list of expected locality point names based on the current username
    expected_locality_point_names = [
        f"{expected_username}_00{idx}"
        for idx in range(1, 4)
    ]

    layer = fdc_project.get_fdc_layer("locality_point")
    layer.startEditing()
    for expected_name in expected_locality_point_names:
        # Force the QGIS platform and username
        # We have to do this after each commit to reset the expression context
        global_scope = QgsExpressionContextUtils.globalScope()
        global_scope.setVariable("qgis_platform", qgis_platform)
        # Set all username variables so we can check which is used
        for name_var, username in name_var_to_username.items():
            global_scope.setVariable(name_var, username)
        expression_context = QgsExpressionContext([global_scope])

        # Create a new feature with automatically generated values from the layer
        feature = QgsVectorLayerUtils.createFeature(layer, context=expression_context)
        # Give the feature some geometry
        geometry_wkt = "Point (-3 55)"
        geometry = QgsGeometry.fromWkt(geometry_wkt)
        feature.setGeometry(geometry)
        feature.setAttribute("locality_type_code", "auger_borehole")
        layer.addFeature(feature)
        layer.commitChanges(stopEditing=False)

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
    fdc_project_quick: FieldDataCapture,
    child_layer_name: str,
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    point_fid = 1
    point_edit_field = "map_face_note"
    point_new_value = "dummy_value"
    child_fid = 1
    child_edit_field = "recorded_by"  # Every table has recorded_by with no on_update rules
    child_new_value = "dummy_user"
    unsaved_layers = ["locality_point", child_layer_name]

    # Manually make an edit to the locality_point layer and do not save it
    locality_point_layer = fdc_project_quick.get_fdc_layer("locality_point")
    locality_point_layer.startEditing()
    point_edit_field_index = [field.name() for field in locality_point_layer.fields()].index(point_edit_field)
    locality_point_layer.changeAttributeValue(fid=point_fid, field=point_edit_field_index, newValue=point_new_value)

    # Manually make an edit to the given child layer and do not save it
    child_layer = fdc_project_quick.get_fdc_layer(child_layer_name)
    child_layer.startEditing()
    child_edit_field_index = [field.name() for field in child_layer.fields()].index(child_edit_field)
    child_layer.changeAttributeValue(fid=child_fid, field=child_edit_field_index, newValue=child_new_value)

    # Monkeypatch the QMessageBox methods to check they are called with the correct values
    mock_message_box_set_text = Mock()
    monkeypatch.setattr(QMessageBox, "setText", mock_message_box_set_text)

    # Act
    unsaved_edits = fdc_project_quick.warn_unsaved_locality_data()

    # Assert
    assert unsaved_edits
    mock_message_box_set_text.assert_called_once()
    assert mock_message_box_set_text.call_args[0][0].endswith("\n".join(unsaved_layers))


@pytest.mark.parametrize(
    "layer_name",
    ATTRIBUTE_TABLES.union(FEATURE_TABLES),
)
def test_attribute_form_widgets(fdc_project: FieldDataCapture, layer_name: str):
    # Arrange
    hidden_widgets = {
        "fid",
        "uuid",
        "recorded_by",
        "recorded_on",
    }
    expected_expressions = {
        "uuid": "uuid()",
        "recorded_by": "coalesce(nullif(@mergin_username, ''), @user_account_name)",
        "recorded_on": "now()",
    }

    # Assert
    hidden_type_widgets = set()
    # Check the layer fields directly
    layer = fdc_project.get_fdc_layer(layer_name)
    for field_idx, field_name in enumerate(layer.fields().names()):

        # Get the widget config
        widget = layer.editorWidgetSetup(field_idx)
        # Get the default config
        default = layer.defaultValueDefinition(field_idx)

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
    layer = fdc_project.get_fdc_layer(layer_name)

    # Act
    # Create a new feature with the default values applied
    feature = QgsVectorLayerUtils.createFeature(layer)

    # Assert
    assert expected_field_project_fuid == feature.attribute("field_project_fuid")


@pytest.mark.parametrize("layer_name", ("photo", "media"))
@pytest.mark.parametrize("qgis_platform", ("desktop", "external"))
def test_default_attachment_bgs_placeholder(fdc_project: FieldDataCapture, layer_name: str, qgis_platform: str):
    # Arrange
    layer = fdc_project.get_fdc_layer(layer_name)
    attachment_col = fdc_project.layers_to_file_attributes[layer_name]
    # Force the QGIS platform
    global_scope = QgsExpressionContextUtils.globalScope()
    global_scope.setVariable('qgis_platform', qgis_platform)
    expression_context = QgsExpressionContext([global_scope])

    # Act
    # Create a new feature with the default values applied and the defined platform
    feature = QgsVectorLayerUtils.createFeature(layer, context=expression_context)

    # Assert
    if qgis_platform == 'desktop':
        assert fdc_project.default_attachment_str == feature.attribute(attachment_col)
        if layer_name == 'media':
            assert feature.attribute('media_type_code') == 'image'
    else:
        assert feature.attribute(attachment_col) is None
        if layer_name == 'media':
            assert feature.attribute('media_type_code') is None


def test_photo_map_tip(report_builder: ReportBuilder):
    # Extract expression from map tip text
    qml_file = report_builder.styles_dir / 'view_photo.qml'
    soup = BeautifulSoup(qml_file.read_text(encoding="utf-8"), 'lxml')
    map_tips = soup.find_all('maptip')
    # There should be one map tip
    assert len(map_tips) == 1
    full_expression_text = map_tips[0].text
    pattern = r"\[%if\([\s\S]*?\)%\]"
    match = re.search(pattern, full_expression_text)
    # There should be an expression in the map tip
    assert match
    # Remove new lines and strip expression delimiters off each end
    expression_text = match.group(0).replace('\r\n', '').lstrip('[%').rstrip('%]')

    # Set up a scope and context with the fields and variables needed
    PHOTO_FILENAME = 'test_point_001.jpeg'
    global_scope = QgsExpressionContextUtils.globalScope()
    expression_context = QgsExpressionContext([global_scope])
    # Add and set the photo_file field to the context
    fields = QgsFields()
    field = QgsField('photo_file', QMetaType.Type.QString)
    fields.append(field)
    feature = QgsFeature()
    feature.setFields(fields)
    feature.setAttribute('photo_file', PHOTO_FILENAME)
    expression_context.setFeature(feature)
    # Add and set the project_folder variable to the scope
    global_scope.setVariable("project_folder", str(report_builder.project_dir))
    expression = QgsExpression(expression_text)

    # No thumbnails present
    expected = f'<img src="file:///{str(report_builder.photos_dir)}/{PHOTO_FILENAME}" />'
    assert expected == expression.evaluate(expression_context)

    # Thumbnails present
    expected = f'<img src="file:///{str(report_builder.thumbnails_dir)}/{PHOTO_FILENAME}" />'
    report_builder.create_thumbnails()
    assert expected == expression.evaluate(expression_context)


def test_about_dialog(fdc: FieldDataCapture):
    # Act
    # Showing the about dialog will confirm it's layout works
    fdc.show_about()

    # Assert
    AboutDialog.exec.assert_called_once()
