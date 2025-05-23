import logging

from eralchemy import render_er
from sqlalchemy import (
    MetaData,
    create_engine,
    event
)

from plugin.config import TABLE_LIST

logger = logging.getLogger("create_er_diagram")


def main(
    gpkg_filepath: str = "field-data-capture.gpkg",
    img_filepath: str = "er-diagram.png",
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

    logger.info("Rendering ER diagram")
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
