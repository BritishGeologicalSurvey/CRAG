from pathlib import Path
import sqlite3

WORKDIR = Path.cwd()

sql_file = WORKDIR / 'field-data-capture.gpkg.sql'
db_file = WORKDIR / 'field-data-capture.gpkg'

if db_file.exists():
    db_file.unlink()

print(db_file)

with sqlite3.connect(db_file) as conn:
    cursor = conn.cursor()

    # Recreate the database from the dump file
    cursor.executescript(sql_file.read_text())

    # Confirm some data
    cursor.execute("SELECT fid, uuid, description FROM locality_point")

    print(list(cursor.fetchall()))
