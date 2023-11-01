from pathlib import Path
import logging
import sqlite3

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


def apply_script(conn: sqlite3.Connection, sql_script: Path):
    # Recreate the database from the dump file
    conn.executescript(sql_script.read_text())


def add_test_data(conn: sqlite3.Connection):
    apply_script(conn, Path(WORKDIR / 'sql' / 'test_data.sql'))


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    main()
