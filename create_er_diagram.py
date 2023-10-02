from eralchemy import render_er
from sqlalchemy import (
    MetaData,
    create_engine,
)


def main(
    gpkg_filepath: str = "field-data-capture.gpkg",
    img_filepath: str = "er-diagram.png",
):
    engine = create_engine(f"sqlite:///{gpkg_filepath}")
    meta = MetaData()
    meta.reflect(bind=engine)

    tables = [
        "activity",
        "dic_activity",
        "dic_manmade_code",
        "dic_media",
        "dic_sample",
        "dic_structure_category",
        "dic_structure_code",
        "dic_superficial_category",
        "dic_superficial_code",
        "locality_manmade_landform",
        "locality_media",
        "locality_point",
        "locality_sample",
        "locality_structural_measurement",
        "locality_superficial_landform",
    ]

    # Only include the given tables in the diagram
    new_meta = MetaData()
    for table in meta.sorted_tables:
        if table.name in tables:
            table.tometadata(new_meta)

    render_er(new_meta, img_filepath)


if __name__ == "__main__":
    main()
