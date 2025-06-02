"""
A script to INSERT the data from a conflicted copy of a field data capture
geopackage into another geopackage.

It is only for use if the changes to be merged are INSERTS only!
"""
import argparse
import logging
import sqlite3
from pathlib import Path
from typing import Iterator

import etlhelper as etl

from plugin.config import (
    FEATURE_TABLES,
    ATTRIBUTE_TABLES,
)
from plugin.utils import ipdb_breakpoint  # noqa

logging.basicConfig(
    level=logging.INFO,
    format="%(levelname)s: %(asctime)s %(name)s: %(message)s",
    datefmt="{%Y-%m-%d %H:%M:%S}",
)
logger = logging.getLogger("insert_conflicted_data")
logging.getLogger('etlhelper').setLevel(logging.WARNING)


def insert_conflicted_data(src_db: Path, dest_db: Path):
    """
    Copy inserted rows from src_db to dest_db, with a backup to prevent
    data loss from errors.
    """
    dest_db_backup = _backup_dest_db(dest_db)
    logger.info("Connecting to source (%s) and destination (%s) databases",
                src_db, dest_db)
    src_conn, dest_conn = _setup_connections(src_db, dest_db)

    try:
        copy_inserted_rows(src_conn, dest_conn)
    except etl.exceptions.ETLHelperError as exc:
        logger.error(exc.args[0])
        logger.error("Cancelling copy and rolling back destination database")
        _restore_dest_db(dest_db, dest_db_backup)
        raise
    finally:
        dest_db_backup.unlink()

    return


def copy_inserted_rows(src_conn: sqlite3.Connection, dest_conn: sqlite3.Connection):
    """
    Attempt to copy all rows from src_conn feature and attribute tables,
    skipping any that already have the same `uuid`.  Errors on other columns
    are still raised.
    """
    # Table order matters - attribute tables are children of locality_point
    tables_to_copy = list(FEATURE_TABLES) + list(ATTRIBUTE_TABLES)
    tables_to_copy.remove('field_project')

    for table in tables_to_copy:
        # Create new transform per table with UUIDs from local scope.
        dest_uuids = set(
            row["uuid"] for row in etl.iter_rows(f"SELECT uuid FROM {table}", dest_conn)
        )

        def transform(chunk: Iterator[dict]) -> Iterator[dict]:
            for row in chunk:
                if row["uuid"] in dest_uuids:
                    # Row exists and can be skipped
                    continue

                row.pop('fid')
                yield row

        # Copy data
        processed, failed = etl.copy_table_rows(
            table,
            src_conn,
            dest_conn,
            transform=transform,
        )
        logger.info("Table %s updated.  %s processed, %s skipped",
                    table, processed, failed)


def _backup_dest_db(dest_db: Path) -> Path:
    dest_db_backup = dest_db.parent / f"{dest_db.name}.backup"
    dest_db_backup.write_bytes(dest_db.read_bytes())
    return dest_db_backup


def _restore_dest_db(dest_db: Path, dest_db_backup: Path):
    dest_db.write_bytes(dest_db_backup.read_bytes())


def _setup_connections(src_db: Path, dest_db: Path) -> list[sqlite3.Connection, sqlite3.Connection]:
    """
    Connect to database files and load Spatialite extension.
    """
    connections: list[sqlite3.Connection, sqlite3.Connection] = []
    for db in (src_db, dest_db):
        try:
            conn = sqlite3.connect(db)
            conn.enable_load_extension(True)
            etl.execute("""SELECT load_extension("mod_spatialite")""", conn)
            etl.execute("PRAGMA foreign_keys = ON", conn)
            logger.info("Connected to %s", db)
            connections.append(conn)
        except (FileNotFoundError, sqlite3.Error):
            logger.exception("Couldn't setup connection on %s", db)
    return connections


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        "Script to copy INSERT data from conflicted 'src_db' into 'dest_db'")
    parser.add_argument("src_db", type=Path, help="Source geopackage path")
    parser.add_argument("dest_db", type=Path, help="Destination geopackage path")
    args = parser.parse_args()
    insert_conflicted_data(args.src_db, args.dest_db)
