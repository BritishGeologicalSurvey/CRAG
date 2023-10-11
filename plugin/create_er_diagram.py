from eralchemy import render_er
from sqlalchemy import (
    MetaData,
    create_engine,
)

from plugin.config import TABLE_LIST


def main(
    gpkg_filepath: str = "field-data-capture.gpkg",
    img_filepath: str = "er-diagram.png",
):
    engine = create_engine(f"sqlite:///{gpkg_filepath}")
    meta = MetaData()
    meta.reflect(bind=engine)

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
