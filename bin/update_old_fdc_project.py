import argparse
import logging
import sqlite3
import datetime as dt
from pathlib import Path
from typing import Callable

import etlhelper as etl

from plugin.config import (
    FEATURE_TABLES,
    LOCALITY_POINT_CHILDREN,
)
from plugin.create_gpkg_from_sql import main as gpkg_from_sql

logging.basicConfig(
    format="%(levelname)s: %(asctime)s %(name)s: %(message)s",
    datefmt="{%Y-%m-%d %H:%M:%S}",
)
logger = logging.getLogger("".join([word.capitalize() for word in Path(__file__).stem.split("_")]))
logger.setLevel(logging.INFO)

CODE_TRANSLATIONS: dict[str, str | dict[str, str]] = {
    "manmade_landform": {
        "code_column": "manmade_type_code",
        "translations": {},
    },
    "sample": {
        "code_column": "sample_type_code",
        "translations": {
            "bedrock_sample": "rock",
        },
    },
    "structural_measurement": {
        "code_column": "structure_type_code",
        "translations": {
            "fault_plane_dip": "fault_plane_inclined",
        },
    },
    "superficial_landform": {
        "code_column": "superficial_type_code",
        "translations": {},
    },
}
COLUMN_NAME_CHANGES: dict[str, dict[str, str | None]] = {
    # If the value is None, it means it is removed
    "field_project": {
        "field_project_type": None,
        "status_code": None,
    },
    "locality_point": {
        "exposure_type_code": "locality_type_code",
        "notes": "geology_description",
    },
    "media": {
        "notes": "media_description",
    },
    "photo": {
        "notes": "caption",
    },
    "sample": {
        "notes": "sample_description",
    },
}



class ProjectDataUpdater:
    def __init__(self, src_gpkg: Path, dest_gpkg: Path):
        logger.info("Source: %s", src_gpkg)
        logger.info("Destination: %s", dest_gpkg)
        self.src_gpkg = src_gpkg
        self.dest_gpkg = dest_gpkg
        self.src_conn: sqlite3.Connection
        self.dest_conn: sqlite3.Connection


    def create_updated_gpkg(self) -> None:
        """
        Create an updated version of the src_gpkg at the dest_gpkg filepath.
        """
        # Create fresh destination gpkg and then copy the data across
        gpkg_from_sql(db_file=self.dest_gpkg)
        self.setup_database_connections()
        self.copy_gpkg_data()
        for conn in self.src_conn, self.dest_conn:
            conn.close()


    def setup_database_connections(self) -> None:
        """
        Setup database connection parameters,
        this includes loading the 'mod_spatialite' extension,
        and enabling 'foreign_keys'.
        """
        self.src_conn = sqlite3.connect(self.src_gpkg)
        self.dest_conn = sqlite3.connect(self.dest_gpkg)
        for conn in self.src_conn, self.dest_conn:
            conn.enable_load_extension(True)
            etl.execute("""SELECT load_extension("mod_spatialite")""", conn)
            etl.execute("PRAGMA foreign_keys = ON", conn)
        logger.info("Connected to both databases successfully")


    def copy_gpkg_data(self) -> None:
        """
        Copy the gpkg data from the src_conn to the dest_conn.
        This will perform a number of translations to update the data formatting.
        """
        # We have to copy field_project first due to foreign key constraints
        # then the feature tables
        # then the locality_point children
        # To do this, we also have to convert sets to lists to ensure their order is retained
        feature_tables = list(FEATURE_TABLES)
        field_project = feature_tables.pop(feature_tables.index("field_project"))
        for table in [field_project] + feature_tables + list(LOCALITY_POINT_CHILDREN):
            logger.info("Copying table '%s' to: %s", table, self.dest_gpkg)
            etl.copy_table_rows(
                table=table,
                source_conn=self.src_conn,
                dest_conn=self.dest_conn,
                transform=self.create_transform_function(table),
            )


    def create_transform_function(self, table: str) -> Callable:
        """
        Create the required transform function for the given table.
        The resulting transform function will:
        - Remove the 'objectid' column
        - Rename/drop columns as specified in the 'COLUMN_NAME_CHANGES' dictionary
        - Translate old '..._type_code' values as specified in the 'CODE_TRANSLATIONS' dictionary
        """
        def current_table_transform(rows: list[dict]) -> list[dict]:
            # etlhelper returns a generator, so convert it to a list first
            rows = list(rows)
            for row in rows:
                # Remove objectid column
                row.pop("objectid")

                # Rename columns
                if table in COLUMN_NAME_CHANGES:
                    for old_col, new_col in COLUMN_NAME_CHANGES[table].items():
                        # If no new name is given, then it should be removed
                        if new_col is None:
                            row.pop(old_col)
                        else:
                            row[new_col] = row.pop(old_col)

                # Translate code column values
                if table in CODE_TRANSLATIONS:
                    code_column = CODE_TRANSLATIONS[table]["code_column"]
                    translations = CODE_TRANSLATIONS[table]["translations"]
                    if row[code_column] in translations:
                        row[code_column] = translations[row[code_column]]
            return rows

        return current_table_transform


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path, help="Directory of the target project")
    project_dir: Path = parser.parse_args().project
    if project_dir.name != "Strathmore_2024_05C":
        raise NotImplementedError((
            "This script was completed as required to update the Strathmore_2024_05C project. "
            "If you want to use this script to update a different project, you should ensure that "
            "the column renaming is correct for your version requirements, "
            "and you should ensure that all of the required 'type_code' translations "
            "you require are populated."
        ))

    dt_str = dt.date.today().strftime("%b%Y")

    project_data_updater = ProjectDataUpdater(
        src_gpkg=project_dir / "field-data-capture.gpkg",
        dest_gpkg=project_dir / f"field-data-capture-{dt_str}-model.gpkg",
    )
    project_data_updater.create_updated_gpkg()
