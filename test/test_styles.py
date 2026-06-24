"""
Tests for .qml style files.  Style files are created by setting values in QGIS
GUI, then using the "Export Styles to QML" developer tool.  This manual process
has scope for errors, so these tests confirm important aspects of the files.
"""
import itertools
import re
from pathlib import Path
import sqlite3
import xml.etree.ElementTree as ET

import etlhelper as etl
from bs4 import BeautifulSoup
from etlhelper.exceptions import ETLHelperExtractError

from qgis.core import (
    QgsExpression,
    QgsExpressionContext,
    QgsExpressionContextUtils,
    QgsFeature,
    QgsField,
    QgsFields,
)
from qgis.PyQt.QtCore import QMetaType

from conftest import setup_db_conn
from CRAG.config import FEATURE_TABLES_LINES, VIEWS, LOCALITY_DICTIONARIES
from CRAG.crag import Crag
from CRAG.report_builder import ReportBuilder
from CRAG.utils import ipdb_breakpoint  # noqa

STYLES_DIR = Path(__file__).parent.parent / "CRAG" / "styles"


def test_style_files_exist():
    # Arrange
    style_files = [
        STYLES_DIR / f"{layer}.qml"
        for layer in set(['locality_point']).union(FEATURE_TABLES_LINES, VIEWS)
    ]
    # Act and assert
    for style_file in style_files:
        assert style_file.exists()


def test_symbol_rotation_on_azimuth(data_model_gpkg: sqlite3.Connection):
    # This test checks that styles use the correct rotation data
    # When applying new styles, the rotation has to be set manually and so can be missed accidentally
    # Arrange
    codes_with_azimuth = {}
    for table in LOCALITY_DICTIONARIES:

        try:
            codes = etl.fetchall(f"SELECT code FROM {table} WHERE has_azimuth",
                                 data_model_gpkg)
        except ETLHelperExtractError as exc:
            if "no such column: has_azimuth" in exc.args[0]:
                # Everything in dic_structure has an azimuth
                if table == "dic_structure":
                    codes = etl.fetchall(f"SELECT code FROM {table}", data_model_gpkg)
                else:
                    continue

        codes_with_azimuth[table] = [row["code"] for row in codes]

    has_azimuth = set(itertools.chain.from_iterable(codes_with_azimuth.values()))

    symbols = {
        code: symbol for file_dict in _get_categorised_marker_symbol_xml().values()
        for code, symbol in file_dict.items()
    }
    rotated_symbols = set(label for label, symbol in symbols.items()
                          if _has_layers_with_angle_from_azimuth(symbol))

    symbols_missing_rotation_config = has_azimuth.difference(rotated_symbols)

    # Act and Assert
    assert symbols_missing_rotation_config == set()  # Empty set


def _get_categorised_marker_symbol_xml() -> dict[str, dict[str, ET.Element]]:
    qml_symbols = {}

    for qml in STYLES_DIR.glob("*.qml"):
        tree = ET.parse(qml)
        root = tree.getroot()

        if root.find('renderer-v2') is None:
            # Skip style files for layers not shown on map, e.g. locality_point
            # children.
            continue

        if root.find('renderer-v2/categories') is None:
            # Skip styles that don't use category based renderer.
            continue

        labels = {
            category.attrib["label"]: category.attrib["symbol"]
            for category in root.find("renderer-v2/categories")
        }

        symbols = {
            symbol.attrib["name"]: symbol
            for symbol in root.find("renderer-v2/symbols")
        }

        marker_symbols_by_label = dict()
        for label, symbol_id in labels.items():
            symbol = symbols[symbol_id]
            if symbol.get("type") == "marker":
                marker_symbols_by_label[label] = symbol

        qml_symbols[qml.stem] = marker_symbols_by_label

    return qml_symbols


def _has_layers_with_angle_from_azimuth(symbol_element: ET.Element) -> bool:
    layers_with_angle_from_azimuth = []

    for layer in symbol_element.findall(".//layer"):
        angle = layer.find(
            ".//data_defined_properties"
            "/Option[@type='Map']"
            "/Option[@name='properties']"
            "/Option[@name='angle']"
        )

        if angle is None:
            continue

        active: ET.Element = angle.find("./Option[@name='active']")
        field: ET.Element = angle.find("./Option[@name='field']")

        if active.get("value", "") == "true" and field.get("value", "") == "azimuth":
            layers_with_angle_from_azimuth.append(layer)

    return len(layers_with_angle_from_azimuth) > 0


def test_photo_map_tip(report_builder: ReportBuilder):
    # Extract expression from map tip text
    qml_file = report_builder.styles_dir / 'view_photo.qml'
    expression_text = get_qml_expression(qml_file, element="maptip", pattern=r"\[%if\([\s\S]*?\)%\]")

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


def test_last_sample_id(crag_project_quick: Crag):
    # Arrange
    qml_file = crag_project_quick.styles_dir / "sample.qml"
    expression_text = get_qml_expression(qml_file, element="attributeeditortextelement", pattern=r"\[%[\s\S]*?%\]")

    # Act 1
    global_scope = QgsExpressionContextUtils.globalScope()
    expression_context = QgsExpressionContext([global_scope])
    expression = QgsExpression(expression_text)
    last_recorded_sample_id = expression.evaluate(expression_context)

    # Assert 1
    assert last_recorded_sample_id == "sample_002"

    # Act 2
    # Delete the most recent sample, the next most recent sample should be given by the expression instead
    with setup_db_conn(crag_project_quick.db_file) as conn:
        etl.execute("DELETE FROM sample WHERE sample_id = 'sample_002'", conn=conn)
    # We have to get the latest global expression context again now it has changed
    global_scope = QgsExpressionContextUtils.globalScope()
    expression_context = QgsExpressionContext([global_scope])
    last_recorded_sample_id = expression.evaluate(expression_context)

    # Assert 2
    assert last_recorded_sample_id == "sample_001"

    # Act 3
    # Delete the final sample, the expression should evaluate to nothing
    with setup_db_conn(crag_project_quick.db_file) as conn:
        etl.execute("DELETE FROM sample WHERE sample_id = 'sample_001'", conn=conn)
    # We have to get the latest global expression context again now it has changed
    global_scope = QgsExpressionContextUtils.globalScope()
    expression_context = QgsExpressionContext([global_scope])
    last_recorded_sample_id = expression.evaluate(expression_context)

    # Assert 3
    assert last_recorded_sample_id is None


def get_qml_expression(qml_file: Path, element: str, pattern: str) -> str:
    """
    Get a QML expression from the given QML file, at the given XML element name.
    pattern is the regular expression search pattern that will be used to find the QGIS expression
    within the found XML text.
    """
    # Extract expression from QML file
    soup = BeautifulSoup(qml_file.read_text(encoding="utf-8"), 'lxml')
    xml_elements = soup.find_all(element)
    # There should be one match for the given string
    assert len(xml_elements) == 1
    full_expression_text = xml_elements[0].text
    match = re.search(pattern, full_expression_text)
    # There should be an expression found
    assert match
    # Remove expression delimiters off each end
    expression_text = match.group(0).replace("[%", "").replace("%]", "")
    return expression_text
