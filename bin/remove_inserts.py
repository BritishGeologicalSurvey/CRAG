"""
Script to print the non-insert statements from a SQL script.  This can be used
as part of manual merging workflow with `sqldiff` as follows:

sqldiff base.gpkg user.gpkg --table locality_point >> /tmp/changes.sql
sqldiff base.gpkg user.gpkg --table bedrock_line >> /tmp/changes.sql
sqldiff base.gpkg user.gpkg --table terrain_line >> /tmp/changes.sql
python remove_inserts.py /tmp/changes.sql > updates_and_deletes.sql

The updates_and_deletes file can be applied to the main copy.
We use spatialite to handle the spatial data.

spatialite main.gpkg < updates_and_deletes.sql
"""


import argparse
from pathlib import Path
from typing import Iterable


def skip_inserts(lines: Iterable[str]) -> Iterable[str]:
    """
    Yield lines from script except those that belong to INSERT statements.
    INSERT statements can be multiline.
    """
    is_insert = False

    for line in lines:
        line = line.strip()

        # Identify start of insert statement
        if line.startswith('INSERT INTO'):
            is_insert = True

        # Identify end of insert statement. We also skip this line.
        if is_insert and line.endswith(');'):
            is_insert = False
            continue

        if not is_insert:
            yield line


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Print SQL script with INSERT statements removed")
    parser.add_argument("input_sql", help="Location of input SQL script",
                        type=Path)
    args = parser.parse_args()

    with open(args.input_sql) as f:
        for line in skip_inserts(f):
            print(line)
