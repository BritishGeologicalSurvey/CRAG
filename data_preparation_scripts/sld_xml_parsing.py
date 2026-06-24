# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
import logging
from pathlib import Path
from typing import Optional

import requests
from bs4 import BeautifulSoup
from bs4.element import Tag

logging.basicConfig(
    level=logging.INFO,
    format="%(levelname)s: %(asctime)s %(name)s: %(message)s",
    datefmt="{%Y-%m-%d %H:%M:%S}",
)
logger = logging.getLogger("".join([word.capitalize() for word in Path(__file__).stem.split("_")]))


def main(
    xml_url: str = "https://ogc.bgs.ac.uk/sld/CGI-inspire-lithologyTextURI.sld",
) -> dict[str, str]:
    """
    Parse the given XML file to retrieve the lithology names and hex colour codes.
    Returns a dictionary object of this data.
    """
    # Get XML data
    xml_data = requests.get(xml_url).text

    soup = BeautifulSoup(xml_data, "xml")

    rules = soup.find_all("sld:Rule")

    # Build a dictionary of the lithology names and hex colours
    lithology_hexes = {}
    for rule in rules:
        lithology_name = get_tag_content(rule.find("sld:Name"))
        hex_colour = get_tag_content(rule.find("sld:CssParameter"))
        lithology_hexes[lithology_name] = hex_colour

    total = len([hex_colour for hex_colour in lithology_hexes.values() if hex_colour is not None])
    logger.info("Found %s hex colours", total)
    return lithology_hexes


def get_tag_content(tag: Tag) -> Optional[str]:
    """
    Get the content from the given tag if there is any.
    """
    if tag.contents in [None, []]:
        return None
    else:
        return tag.contents[0]


if __name__ == "__main__":
    main()
