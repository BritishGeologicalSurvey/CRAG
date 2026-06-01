"""
Parse a style database in QGIS XML format and list styles within.
Compare with the codes in the CRAG dictionaries.
"""
from collections import defaultdict
from pathlib import Path
from pprint import pprint
import sqlite3
from typing import List, Tuple
import xml.etree.ElementTree as ET

import etlhelper as etl

DICTIONARIES = [
    "dic_line_type_artificial",
    "dic_line_type_bedrock",
    "dic_line_type_mass_move",
    "dic_line_type_superficial",
    "dic_line_type_terrain",
    "dic_manmade_landform",
    "dic_structure",
    "dic_superficial_landform"
]

GPKG = Path(__file__).parent.parent / 'field-data-capture.gpkg'
assert GPKG.exists(), f"{GPKG.absolute()} doesn't exist."
CGDM_XML = Path(__file__).parent.parent / 'plugin' / 'styles' / 'BGS_CGDM_styles_2025_v4.xml'
assert CGDM_XML.exists(), f"{CGDM_XML.absolute()} doesn't exist."


def compare_symbols():
    symbols = extract_qgis_symbols(CGDM_XML)
    keys = extract_gpkg_dictionary_keys()

    cgdm_symbols = set().union(*symbols.values())
    crag_keys = set().union(*keys.values())

    print("\nOnly in CGDM style file:")
    pprint(cgdm_symbols.difference(crag_keys))
    print("\nOnly in CRAG dictionary keys:")
    pprint(crag_keys.difference(cgdm_symbols))

    # Uncomment for interactive exploration of style lists
    # breakpoint()


def extract_qgis_symbols(xml_path: Path) -> List[Tuple[str, str]]:
    """
    Parse a QGIS qgis_style (version 2) XML file and extract symbol names and types.

    Args:
        xml_path: Path to the XML file

    Returns:
        A list of tuples (name, type).
    """
    tree = ET.parse(xml_path)
    root = tree.getroot()

    symbols = defaultdict(set)

    # Find all symbol elements (they may be nested in different places)
    for symbol in root.findall("./symbols/symbol"):
        symbol_type = symbol.get("type", "unknown")
        name = symbol.get("name")

        symbols[symbol_type].add(name)

    return symbols


def extract_gpkg_dictionary_keys() -> dict[str, set]:
    keys = {}
    for style_dict in DICTIONARIES:
        with sqlite3.connect(GPKG) as conn:
            dict_keys = [
                row["code"]
                for row in etl.fetchall(f"SELECT code FROM {style_dict}", conn)
            ]
        keys[style_dict] = set(dict_keys)

    return keys


def search(term: str, keys: set[str]) -> set[str]:
    """
    Function for use in interactive sessions to return matching
    keys.  Uses basic case-insensitive string matching.
    """
    return set(filter(lambda key: term.casefold() in key.casefold(), keys))


if __name__ == "__main__":
    compare_symbols()
