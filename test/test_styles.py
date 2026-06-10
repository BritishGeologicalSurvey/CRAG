"""
Tests for .qml style files.  Style files are created by setting values in QGIS
GUI, then using the "Export Styles to QML" developer tool.  This manual process
has scope for errors, so these tests confirm important aspects of the files.
"""
import itertools
from pathlib import Path
import sqlite3
import xml.etree.ElementTree as ET

import etlhelper as etl
from etlhelper.exceptions import ETLHelperExtractError

from CRAG.config import FEATURE_TABLES_LINES, VIEWS, LOCALITY_DICTIONARIES

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
