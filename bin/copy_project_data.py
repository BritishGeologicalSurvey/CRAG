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
        # This is a dictionary which will contain table names as keys
        # and lists of uuid values as values, so that we can track which rows have been copied
        self.copied_table_rows: dict[str, list[str]] = {}
        self.current_table: str


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
            copy_success = self.copy_rows()

            if not copy_success:
                return

            self.copy_src_field_project_metadata()
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


    def copy_rows(self) -> bool:
        """
        Copy the feature rows from the source project into the destination project.
        This ignores the 'field_project' table, all dictionaries and views.
        Returns a boolean indicating the success of the process.
        """
        # Don't copy field_project
        feature_tables = FEATURE_TABLES - {"field_project"}
        for table_set in [feature_tables, LOCALITY_POINT_CHILDREN]:
            for table in table_set:

                # If there are rows to copy
                row_count = etl.fetchone(
                    f"SELECT COUNT() AS count FROM {table}",
                    self.src_conn,
                    row_factory=etl.row_factories.tuple_row_factory,
                )[0]
                if row_count > 0:
                    logger.info("Copying %s rows from table: %s", row_count, table)
                    self.current_table = table
                    _, errors = etl.copy_table_rows(
                        table=table,
                        source_conn=self.src_conn,
                        dest_conn=self.dest_conn,
                        row_factory=etl.row_factories.dict_row_factory,
                        transform=self.transform_fdc_rows,
                        on_error=lambda failed_rows: None,
                    )

                if errors > 0:
                    logger.error("%s rows failed when copying table: %s", errors, table)
                    logger.error("Cancelling copy and rolling back copied tables")
                    self.rollback_copied_table_rows()
                    return False

        return True


    def rollback_copied_table_rows(self) -> None:
        """
        Delete the rows which have been copied so far.
        These are selected using their uuid values.
        """
        # Delete the rows which have been copied so far by using their uuid values
        for rollback_table, rollback_uuids in self.copied_table_rows.items():
            logger.error("Rolling back %s rows in table: %s", len(rollback_uuids), rollback_table)
            etl.execute(
                f"DELETE FROM {rollback_table} WHERE uuid IN {tuple(rollback_uuids)}",
                self.dest_conn,
            )


    def copy_src_field_project_metadata(self) -> None:
        """
        Copy the metadata of the source Field Project into the notes of the destination Field Project.
        """
        logger.info("Copying field_project source metadata into field_project destination notes")
        # Get required data from src and dest field_project records
        dest_notes = etl.fetchone(
            "SELECT notes FROM field_project",
            self.dest_conn,
            row_factory=etl.row_factories.dict_row_factory,
        )["notes"]
        src_metadata = etl.fetchone(
            """
                SELECT
                    short_name,
                    title,
                    description,
                    project_lead,
                    status_code,
                    start_date,
                    end_date,
                    field_project_type,
                    local_epsg,
                    notes,
                    mapped_scale,
                    user_entered,
                    date_entered,
                    user_updated,
                    date_updated,
                    qgis_plugin_version
                FROM
                field_project
            """,
            self.src_conn,
            row_factory=etl.row_factories.dict_row_factory,
        )

        # Generate the extra string to append to the notes
        src_metadata_strings = [
            f"{name}: {value}"
            for name, value in src_metadata.items()
        ]
        src_metadata_strings.insert(0, "--- Copied Project Metadata ---")
        src_metadata_string = "\n".join(src_metadata_strings)
        # Add dest notes and extra newlines to the start to separate it from the dest notes
        new_dest_notes = dest_notes + "\n\n" + src_metadata_string

        etl.execute(
            "UPDATE field_project SET notes=? WHERE uuid=?",
            self.dest_conn,
            parameters=(new_dest_notes, self.field_project_fuid_dest),
        )


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

            if self.current_table not in self.copied_table_rows:
                self.copied_table_rows[self.current_table] = []
            self.copied_table_rows[self.current_table].append(row["uuid"])

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
