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
        self._validate_project_directories()
        self.src_conn: sqlite3.Connection
        self.dest_conn: sqlite3.Connection
        self.field_project_fuid_col = "field_project_fuid"
        self.field_project_fuid_dest: str
        self.src_db_file = next(self.src_dir.glob('*.gpkg'))
        self.dest_db_file = next(self.dest_dir.glob('*.gpkg'))


    def copy_project_data(self) -> bool:
        """
        Copy the project data from the source Field Data Capture project into
        the destination Field Data Capture project.
        Returns a boolean indicating the success of the process.
        """
        # Run initial checks before copying
        if not self.validate_project_databases():
            return False

        src_db = self.src_dir / self.src_db_file
        dest_db = self.dest_dir / self.dest_db_file
        # Create copy of dest database before making changes
        with tempfile.TemporaryDirectory() as tmp_dir:
            tmp_dir = Path(tmp_dir)
            dest_db_file_backup = tmp_dir / self.dest_db_file
            dest_db_file_backup.write_bytes(dest_db.read_bytes())

            # Setup database transactions
            with sqlite3.connect(src_db) as self.src_conn, sqlite3.connect(dest_db) as self.dest_conn:  # noqa
                for conn in self.src_conn, self.dest_conn:
                    conn.enable_load_extension(True)
                    etl.execute("""SELECT load_extension("mod_spatialite")""", conn)
                    etl.execute("PRAGMA foreign_keys = ON", conn)
                logger.info("Connected to both databases successfully")

                self.field_project_fuid_dest = self.get_field_project_fuid_dest()

                try:
                    self.copy_rows()
                    self.copy_src_field_project_metadata()
                except Exception:
                    # Restore backup destination database
                    logger.error("Cancelling copy and rolling back destination database")
                    dest_db.write_bytes(dest_db_file_backup.read_bytes())
                    return False

            for conn in self.src_conn, self.dest_conn:
                conn.close()

        self.copy_feature_files()

        return True


    def _validate_project_directories(self) -> bool:
        """
        Checks if the source and destination project directories are valid and distinct.
        """
        raise_value_error = False

        if self.src_dir == self.dest_dir:
            logger.error("Source and destination are the same, they must be different projects")
            raise_value_error = True

        for target, project_dir in [('src', self.src_dir), ('dest', self.dest_dir)]:
            # Ensure project_dir is a directory
            if not project_dir.is_dir():
                logger.error("%s project %s is not a directory", target, project_dir)
                raise_value_error = True

        if raise_value_error:
            raise ValueError()


    def validate_project_databases(self) -> bool:
        """
        Checks if the source and destination project are both ready for importing data.
        This includes checking that a database exists, and that it is not open.
        """
        # Ensure database files exist
        if not (self.src_dir / self.src_db_file).exists():
            logger.error("Database file is missing from the src project")
            return False
        if not (self.dest_dir / self.dest_db_file).exists():
            logger.error("Database file is missing from the dest project")
            return False

        for target, project_dir in [('src', self.src_dir), ('dest', self.dest_dir)]:
            # Ensure the database file is not open in QGIS
            open_db_files = [
                file
                for file in project_dir.glob("*")
                if file.suffix in {".gpkg-shm", ".gpkg-wal"}
            ]
            if len(open_db_files) > 0:
                logger.error(("The database file in the %s project may be open, "
                              "please ensure they are closed before importing data"), target)
                logger.error("If the database is closed then stale temporary database "
                             "files can be removed using the following command:")
                logger.error("    sqlite3 %s vacuum", target)
                return False

        return True


    def get_field_project_fuid_dest(self) -> str:
        """
        Get the field_project uuid value from the destination project.
        """
        return etl.fetchone(
            "SELECT uuid FROM field_project",
            self.dest_conn,
        )["uuid"]


    def copy_rows(self) -> bool:
        """
        Copy the feature rows from the source project into the destination project.
        This ignores the 'field_project' table, all dictionaries and views.
        Returns a boolean indicating the success of the process.
        """
        # Don't copy field_project
        feature_tables = FEATURE_TABLES - {"field_project"}  # locality_point plus line layers
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
                            transform=self.transform_fdc_rows,
                        )

                except Exception as error:
                    logger.error("Failed to copy table '%s' due to error:\n%s", table, error)
                    raise


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
        )["notes"]
        src_metadata = etl.fetchone(
            """
                SELECT
                    short_name,
                    title,
                    description,
                    project_lead,
                    start_date,
                    end_date,
                    local_epsg,
                    notes,
                    mapped_scale,
                    recorded_by,
                    recorded_on,
                    qgis_plugin_version
                FROM
                    field_project
            """,
            self.src_conn,
        )

        # Generate the extra string to append to the notes
        src_metadata_strings = [
            f"{name}: {value}"
            for name, value in src_metadata.items()
        ]
        src_metadata_strings.insert(0, "--- Imported Project Metadata ---")
        src_metadata_string = "\n".join(src_metadata_strings)

        # Add dest notes and extra newlines to the start to separate it from the dest notes
        if dest_notes:
            new_dest_notes = dest_notes + "\n\n" + src_metadata_string
        else:
            new_dest_notes = src_metadata_string

        try:
            etl.execute(
                "UPDATE field_project SET notes=? WHERE uuid=?",
                self.dest_conn,
                parameters=(new_dest_notes, self.field_project_fuid_dest),
            )
        except Exception as error:
            logger.error("Failed to update field_project notes due to error:\n%s",
                         error)
            raise


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
    parser.add_argument("dest", type=Path, help="Destination project directory path")
    project_data_importer = ProjectDataImporter(src=parser.parse_args().src, dest=parser.parse_args().dest)
    project_data_importer.copy_project_data()
