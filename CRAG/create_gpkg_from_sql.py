# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
import logging
import sqlite3
from pathlib import Path
from typing import Optional

logger = logging.getLogger('create_gpkg')
# Using __file__ rather than cwd() so that the import location does not affect the path
WORKDIR = Path(__file__).parent
DB_FILE = Path.cwd() / 'field-data-capture.gpkg'


def main(
    workdir: Path = WORKDIR,
    db_file: Path = DB_FILE,
):
    logger.info('Creating database at: %s', str(db_file))
    if db_file.exists():
        logger.info('Deleting existing database')
        db_file.unlink()

    sql_scripts = Path(workdir / 'sql').glob('V*.sql')

    for sql_script in sorted(sql_scripts):
        with sqlite3.connect(db_file) as conn:
            logger.info('Applying %s', sql_script.name)
            apply_script(conn, sql_script)
    conn.close()


def apply_script(conn: sqlite3.Connection, sql_script: Path):
    """
    Apply the given SQL script to the given database connection.
    """
    conn.executescript(sql_script.read_text())


def add_test_data(conn: sqlite3.Connection, short_name: Optional[str] = None):
    """
    Add the test data set to the given database connection.
    The connection must have already enabled extensions using:
    conn.enable_load_extension(True)
    """
    apply_script(conn, Path(WORKDIR / 'sql' / 'test_data.sql'))
    if short_name is not None:
        # Now update the short_name to reflect the file names if necessary
        conn.executescript(f'UPDATE field_project SET short_name = "{short_name}" WHERE fid = 1')


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    main()
