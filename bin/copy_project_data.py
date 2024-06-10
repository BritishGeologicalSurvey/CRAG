import argparse
import logging
import sqlite3
from pathlib import Path
from typing import (
    Any,
    Generator,
)

import etlhelper as etl

from plugin.config import (
    FEATURE_TABLES,
    LOCALITY_POINT_CHILDREN,
)
from plugin.utils import ipdb_breakpoint  # noqa

logging.basicConfig(
    level=logging.INFO,
    format="%(levelname)s: %(asctime)s %(name)s: %(message)s",
    datefmt="{%Y-%m-%d %H:%M:%S}",
)
logger = logging.getLogger("".join([word.capitalize() for word in Path(__file__).stem.split("_")]))


class CopyProjectData:
    def __init__(self, src: Path, dest: Path):
        logger.info("Source: %s", src)
        logger.info("Destination: %s", dest)
        self.src_dir = src
        self.dest_dir = dest
        self.src_conn: sqlite3.Connection
        self.dest_conn: sqlite3.Connection
        self.field_project_fuid_col = "field_project_fuid"
        self.field_project_fuid_dest: str


    def copy_project_data(self) -> None:
        """
        Copy the project data from the source Field Data Capture project into
        the destination Field Data Capture project.
        """
        # Setup connections
        db_file = "field-data-capture.gpkg"
        with sqlite3.connect(self.src_dir / db_file) as self.src_conn, sqlite3.connect(self.dest_dir / db_file) as self.dest_conn:  # noqa
            for conn in self.src_conn, self.dest_conn:
                conn.enable_load_extension(True)
                etl.execute("""SELECT load_extension("mod_spatialite")""", conn=conn)
            logger.info("Connected to both databases successfully")

            self.field_project_fuid_dest = self.get_field_project_fuid_dest()
            copy_results = self.copy_rows()
            errors = sum([table_result["errors"] for table_result in copy_results.values()])
            if errors > 0:
                ipdb_breakpoint()
        self.copy_feature_files()


    def get_field_project_fuid_dest(self) -> str:
        """
        Get the field_project uuid value from the destination project.
        """
        return etl.fetchone(
            "SELECT uuid FROM field_project",
            self.dest_conn,
            row_factory=etl.row_factories.dict_row_factory,
        )["uuid"]


    def copy_rows(self) -> dict[str, dict[str, int]]:
        """
        Copy the feature rows from the source project into the destination project.
        This ignores the 'field_project' table, all dictionaries and views.
        Returns a dictionary containing the processed and error counts for each tables copy_table_rows process.
        """
        copy_results: dict[str, dict[str, int]] = {}
        # Don't copy field_project
        feature_tables = FEATURE_TABLES - {"field_project"}
        for table_set in [feature_tables, LOCALITY_POINT_CHILDREN]:
            for table in table_set:
                logger.info("Copying data from table: %s", table)
                processed, errors = etl.copy_table_rows(
                    table=table,
                    source_conn=self.src_conn,
                    dest_conn=self.dest_conn,
                    row_factory=etl.row_factories.dict_row_factory,
                    transform=self.transform_fdc_rows,
                )
                copy_results[table] = {
                    "processed": processed,
                    "errors": errors,
                }
        return copy_results


    def transform_fdc_rows(self, chunk: list[dict[str, Any]]) -> Generator[dict[str, Any], None, None]:
        """
        Transform function for ETLHelper.
        It will remove fid values from rows and replace project_fuid values with the dest project_fuid.
        """
        for row in chunk:
            # Remove the fid value as it will be autoincremented
            row.pop("fid")
            # If there is a field_project fuid in the row, replace it with the dest one
            if self.field_project_fuid_col in row:
                row[self.field_project_fuid_col] = self.field_project_fuid_dest
            yield row


    def copy_feature_files(self) -> None:
        """
        Copy the files referenced in feature layers from the source to the destination project.
        This includes the 'photos' and 'media' directories.
        """
        for feature_dir in ["photos", "media"]:
            logger.info("Copying feature files from directory: %s", feature_dir)
            # For each feature file in the source project directory (excluding placeholders)
            for src_file in (self.src_dir / feature_dir).glob("*[!.placeholder]"):
                # Ignore directories
                if src_file.is_file():
                    # Create the new file in the destintation project with the same file name
                    dest_file = self.dest_dir / feature_dir / src_file.name
                    # Copy the file
                    dest_file.write_bytes(src_file.read_bytes())


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("src", type=Path, help="Source project directory path")
    parser.add_argument("dest", type=Path, help="Destintation project directory path")
    copy_project_data = CopyProjectData(src=parser.parse_args().src, dest=parser.parse_args().dest)
    copy_project_data.copy_project_data()
