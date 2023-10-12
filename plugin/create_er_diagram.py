from eralchemy import render_er
from sqlalchemy import (
    MetaData,
    create_engine,
    event
)

from plugin.config import TABLE_LIST


def main(
    gpkg_filepath: str = "field-data-capture.gpkg",
    img_filepath: str = "er-diagram.png",
):
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
    meta = MetaData()
    meta.reflect(bind=engine, views=True)

    # Only include the given tables in the diagram
    new_meta = MetaData()
    for table in meta.sorted_tables:
        if table.name in TABLE_LIST:
            table.tometadata(new_meta)

    render_er(new_meta, img_filepath,
              exclude_columns=["fid",
                               "objectid",
                               "user_entered",
                               "date_entered",
                               "user_updated",
                               "date_updated"])


if __name__ == "__main__":
    main()
