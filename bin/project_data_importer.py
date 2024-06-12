import argparse
import logging
import sqlite3
import tempfile
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


class ProjectDataImporter:
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
        # Ensure database files exist
        db_file = "field-data-capture.gpkg"
        if not (self.src_dir / db_file).exists() or not (self.dest_dir / db_file).exists():
            logger.error("Database file is missing from at least one of the projects")
            return

        # Create copy of dest database before making changes
        with tempfile.TemporaryDirectory() as tmp_dir:
            tmp_dir = Path(tmp_dir)
            dest_db_file_backup = tmp_dir / db_file
            dest_db_file_backup.write_bytes((self.dest_dir / db_file).read_bytes())

            # Setup database connections
            with sqlite3.connect(self.src_dir / db_file) as self.src_conn, sqlite3.connect(self.dest_dir / db_file) as self.dest_conn:  # noqa
                for conn in self.src_conn, self.dest_conn:
                    conn.enable_load_extension(True)
                    etl.execute("""SELECT load_extension("mod_spatialite")""", conn)
                    etl.execute("PRAGMA foreign_keys = ON", conn)
                logger.info("Connected to both databases successfully")

                self.field_project_fuid_dest = self.get_field_project_fuid_dest()
                copy_success = self.copy_rows()

                if not copy_success:
                    # Restore backup destination database
                    (self.dest_dir / db_file).write_bytes(dest_db_file_backup.read_bytes())
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

                try:
                    # If there are rows to copy
                    row_count = etl.fetchone(
                        f"SELECT COUNT() AS count FROM {table}",
                        self.src_conn,
                        row_factory=etl.row_factories.tuple_row_factory,
                    )[0]

                    if row_count > 0:
                        logger.info("Copying %s rows from table: %s", row_count, table)
                        etl.copy_table_rows(
                            table=table,
                            source_conn=self.src_conn,
                            dest_conn=self.dest_conn,
                            row_factory=etl.row_factories.dict_row_factory,
                            transform=self.transform_fdc_rows,
                        )

                except Exception as error:
                    logger.error("Failed to copy table '%s' due to error:\n%s", table, error)
                    logger.error("Cancelling copy and rolling back destination database")
                    return False

        return True


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
        src_metadata_strings.insert(0, "--- Imported Project Metadata ---")
        src_metadata_string = "\n".join(src_metadata_strings)
        # Add dest notes and extra newlines to the start to separate it from the dest notes
        new_dest_notes = dest_notes + "\n\n" + src_metadata_string

        etl.execute(
            "UPDATE field_project SET notes=? WHERE uuid=?",
            self.dest_conn,
            parameters=(new_dest_notes, self.field_project_fuid_dest),
        )


    def copy_feature_files(self) -> None:
        """
        Copy the files referenced in feature layers from the source to the destination project.
        This includes the 'photos' and 'media' directories.
        """
        for feature_dir in ["photos", "media"]:
            logger.info("Copying feature files from directory: %s", feature_dir)
            # For each feature file in the source project directory (excluding placeholders)
            for src_file in (self.src_dir / feature_dir).rglob("*[!.placeholder]"):
                # Ignore directories
                if src_file.is_file():
                    relative_src_file = src_file.relative_to(self.src_dir / feature_dir)
                    # Create the new file in the destintation project with the same relative path
                    dest_file = self.dest_dir / feature_dir / relative_src_file
                    # Copy the file
                    dest_file.parent.mkdir(parents=True, exist_ok=True)
                    dest_file.write_bytes(src_file.read_bytes())


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("src", type=Path, help="Source project directory path")
    parser.add_argument("dest", type=Path, help="Destintation project directory path")
    copy_project_data = ProjectDataImporter(src=parser.parse_args().src, dest=parser.parse_args().dest)
    copy_project_data.copy_project_data()
