# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
import logging

from eralchemy import render_er
from sqlalchemy import (
    MetaData,
    create_engine,
    event
)

from CRAG.config import (
    ATTRIBUTE_TABLES,
    FEATURE_TABLES_LINES,
    LINE_DICTIONARIES,
    LOCALITY_DICTIONARIES,
    VIEWS,
)

logger = logging.getLogger("create_er_diagram")


def main(gpkg_filepath: str = "field-data-capture.gpkg") -> None:
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

    sub_tables = {
        "er-diagram-locality.png": ATTRIBUTE_TABLES | LOCALITY_DICTIONARIES | {"field_project", "locality_point"},
        "er-diagram-lines.png": FEATURE_TABLES_LINES | LINE_DICTIONARIES | {"field_project"},
        "er-diagram-views.png": VIEWS,
    }
    for img_filepath, tables in sub_tables.items():
        render_tables_diagram(meta, tables, img_filepath)


def render_tables_diagram(meta: MetaData, tables: set[str], img_filepath: str) -> None:
    """
    Render an ER diagram for just the given list of tables in the given metadata object.
    """
    new_meta = MetaData()
    for table in meta.sorted_tables:
        if table.name in tables:
            table.to_metadata(new_meta)

    logger.info("Rendering ER diagram for %s tables: %s", len(tables), img_filepath)
    render_er(
        new_meta,
        img_filepath,
        exclude_columns=[
            "fid",
            "recorded_by",
            "recorded_on",
        ],
    )


if __name__ == "__main__":
    logger.setLevel(logging.INFO)
    main()
