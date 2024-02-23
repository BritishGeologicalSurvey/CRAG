"""
Script to prepare contents of dic_rock_field and other tables from external sources.

Note that this depends on an Oracle connection.  Don't forget to run the following
commands first:

export ORACLE_PASSWORD=<BGS Oracle reader password>
source $(setup_oracle_client)
"""
from pathlib import Path
import sqlite3

import etlhelper as etl
import pandas as pd

DB = Path('dic_rock_etc.sqlite')
OUTPUT_FILE = Path('dic_rock_etc.dump')


def main():
    if DB.exists():
        DB.unlink()

    with sqlite3.connect(DB) as conn:
        create_tables(conn)
        dump_sql(conn)


def create_tables(conn: sqlite3.Connection):
    dic_rock_all_sql = """
        CREATE TABLE test (
            id INT PRIMARY KEY
        )
    """
    etl.execute(dic_rock_all_sql, conn)


def dump_sql(conn: sqlite3.Connection, output=OUTPUT_FILE):
    with open(output, 'wt') as outfile:
        for line in conn.iterdump():
            outfile.write(line + '\n')
            print(line)


if __name__ == "__main__":
    main()
