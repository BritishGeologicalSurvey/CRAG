from pathlib import Path
import sqlite3

WORKDIR = Path.cwd()
DB_FILE = WORKDIR / 'field-data-capture.gpkg'


def main():
    sql_scripts = Path(WORKDIR / 'sql').glob('*.sql')

    for sql_script in sql_scripts:
        apply_script(DB_FILE, sql_script)


def apply_script(geopackage_file, sql_script):
    with sqlite3.connect(geopackage_file) as conn:
        cursor = conn.cursor()

        # Recreate the database from the dump file
        cursor.executescript(sql_script.read_text())


if __name__ == "__main__":
    main()
