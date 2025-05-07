import os
import logging
import requests

from eralchemy2 import render_er
from sqlalchemy import (
    MetaData,
    create_engine,
    event
)

from plugin.config import TABLE_LIST

logger = logging.getLogger("create_er_diagram")


def main(
    gpkg_filepath: str = "field-data-capture.gpkg",
    md_filepath: str = "er-diagram.md",
    png_filepath: str = "er-diagram.png",
) -> None:
    engine = create_engine(f"sqlite:///{gpkg_filepath}")

    # Define a hook to run as soon as engine connects.
    # This one loads the Spatialite extension to all spatial functions to be used.
    # https://docs.sqlalchemy.org/en/14/core/engines.html#modifying-the-dbapi-connection-after-connect-or-running-commands-after-connect
    # See also https://stackoverflow.com/a/73451804/3508733
    @event.listens_for(engine, "connect")
    def connect(conn, _):
        conn.enable_load_extension(True)
        conn.execute("SELECT load_extension('mod_spatialite');")
        conn.enable_load_extension(False)

    # Connect and read metadata
    logger.info("Reading database table structure")
    meta = MetaData()
    meta.reflect(bind=engine, views=True)

    # Only include the given tables in the diagram
    new_meta = MetaData()
    for table in meta.sorted_tables:
        if table.name in TABLE_LIST:
            table.to_metadata(new_meta)

    # Render mermaid markdown file, which contains URL for web generation.
    logger.info("Rendering ER diagram")
    render_er(
        new_meta,
        md_filepath,
        exclude_columns=[
            "fid",
            "user_entered",
            "date_entered",
            "user_updated",
            "date_updated"
        ],
    )

    # Extract url in md file
    with open(md_filepath, "r") as md_file:
        lines = md_file.readlines()
        url_line = lines[len(lines) - 1]
    # Remove markdown formatting around url
    url = url_line[4:-2]
    os.remove(md_filepath)

    # Set background colour for png file
    url += '?bgColor=!LemonChiffon'

    # Download png using URL
    response = requests.get(url)
    if response.status_code == 200:
        logger.info("Downloading png")
        with open(png_filepath, "wb") as png_file:
            png_file.write(response.content)
    else:
        logger.error("Failed to render ER diagram")


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    main()
