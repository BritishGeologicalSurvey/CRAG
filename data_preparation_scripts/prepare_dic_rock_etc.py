"""
Script to prepare contents of dic_rock_field and other tables from external sources.

Note that this depends on an Oracle connection.  Don't forget to run the following
commands first:

export ORACLE_PASSWORD=<BGS Oracle reader password>
source $(setup_oracle_client)
"""
import csv
import datetime as dt
import logging
from pathlib import Path
import pickle
import re
import sqlite3
from typing import Iterable

import etlhelper as etl

from plugin.utils import ipdb_breakpoint  # noqa

logger = logging.getLogger(__name__)
DB = Path('dic_rock_etc.sqlite')
OUTPUT_FILE = Path('dic_rock_etc.dump')
GEOL_UNIT_CSV = Path(__file__).parent / "GEOL_UNIT_COMP_PART_202403042239.csv"
DIC_ROCK_FIELD_CSV = Path(__file__).parent / "Dic_Rock_Field_RCS__Subset_MK240124.csv"
SIMPLE_LITHOLOGY_SQL = Path(__file__).parent.parent / "plugin" / "sql" / "V003__simple_lithology.sql"
DIC_ROCK_ALL_CACHE = Path(__file__).parent / "dic_rock_all.pickle"
CGI_BASE_URL = "http://resource.geosciml.org/classifier/cgi/lithology/"

BGSPROD = etl.DbParams(
    dbtype='ORACLE',
    host='kwxdb-prod.ad.nerc.ac.uk',
    port=1521,
    dbname='bgsprod',
    user='reader')


def main():
    if DB.exists():
        logging.info("Deleting existing database")
        DB.unlink()

    with sqlite3.connect(DB) as conn:
        logging.info("Creating tables")
        create_tables(conn)

        logging.info("Importing data from dic_rock_all")
        import_dic_rock_all(conn)
        logging.info("Importing data from geol_unit_comp_part")
        import_geol_unit_comp_part(conn)
        logging.info("Importing data from Dic_Rock_Field_RCS")
        import_dic_rock_field_rcs(conn)
        logging.info("Importing data from %s", SIMPLE_LITHOLOGY_SQL.name)
        import_simple_lithology(conn)
        logging.info("Updating CGI uris from Inspire")
        update_cgi_uris_from_inspire(conn)
        logging.info("Extending dic_rock_field with _dic_rock_all")
        extend_dic_rock_field(conn)
        logging.info("Populating simple_lithology column in dic_rock_field")
        populate_simple_lithology(conn)
        logging.info("Filling missing colours and lithologies")
        fill_missing_colours_and_lithologies(conn)
        logging.info("Populating category column in dic_rock_field")
        populate_category(conn)

        logging.info("Dumping SQL file")
        dump_sql(conn)


def create_tables(conn: sqlite3.Connection):
    dic_rock_all_sql = """
        CREATE TABLE IF NOT EXISTS "_dic_rock_all" (
            "fid"	INTEGER NOT NULL,
            "code"	TEXT NOT NULL UNIQUE,
            "description"	TEXT,
            "translation"	TEXT,
            "status"	TEXT,
            "rcs_status"  TEXT,
            "user_entered"	TEXT NOT NULL,
            "date_entered"	DATETIME NOT NULL,
            "user_updated"	TEXT,
            "date_updated"	DATETIME,
            PRIMARY KEY("fid" AUTOINCREMENT)
        );
    """

    dic_rock_field_sql = """
        CREATE TABLE IF NOT EXISTS "dic_rock_field" (
            "fid"	INTEGER NOT NULL,
            "category"	TEXT,
            "code"	TEXT NOT NULL UNIQUE,
            "is_default"	BOOLEAN NOT NULL DEFAULT 0,
            "simple_lithology"	TEXT,
            "label" TEXT,
            "description"	TEXT,
            "translation"	TEXT,
            "composite"	TEXT,
            "user_entered"	TEXT NOT NULL,
            "date_entered"	DATETIME NOT NULL,
            "user_updated"	TEXT,
            "date_updated"	DATETIME,
            FOREIGN KEY("code") REFERENCES "_dic_rock_all"("code"),
            PRIMARY KEY("fid" AUTOINCREMENT)
        );
    """

    geol_unit_comp_part_sql = """
        CREATE TABLE IF NOT EXISTS "geol_unit_comp_part" (
            "fid" INTEGER NOT NULL,
            "rcs" TEXT NOT NULL,
            "cgi_lithology_label" TEXT,
            "cgi_lithology_uri" TEXT,
            "inspire_lithology_label" TEXT,
            "inspire_lithology_uri" TEXT,
            PRIMARY KEY("fid" AUTOINCREMENT)
        );
        """

    etl.execute(dic_rock_all_sql, conn)
    etl.execute(dic_rock_field_sql, conn)
    etl.execute(geol_unit_comp_part_sql, conn)


def import_dic_rock_all(conn: sqlite3.Connection):
    """
    Import dic_rock_all from Oracle.

    A .pickle cache is used to speed up execution on repeated runs and
    facilitate offline use.  It would be better to have used JSON, but
    it doesn't handle datetimes.
    """
    select_sql = """
        SELECT
          CODE,
          DESCRIPTION,
          TRANSLATION,
          STATUS,
          RCS_STATUS,
          USER_ENTERED,
          DATE_ENTERED,
          USER_UPDATED,
          DATE_UPDATED
        FROM BGS.DIC_ROCK_ALL
    """

    def transform(chunk: list[dict]):
        for row in chunk:
            # Convert keys to lower case
            key_list = list(row.keys())

            for key in key_list:
                row[key.lower()] = row.pop(key)

            yield row

    with BGSPROD.connect("ORACLE_PASSWORD") as oracle_conn:
        if DIC_ROCK_ALL_CACHE.exists():
            logger.info("Loading from cache")
            rows = pickle.loads(DIC_ROCK_ALL_CACHE.read_bytes())
        else:
            # Use fetchall instead of iter_rows so that we can use them again
            rows = etl.fetchall(select_sql, oracle_conn,
                                row_factory=etl.row_factories.dict_row_factory,
                                transform=transform)
        etl.load('_dic_rock_all', conn, rows)

    if not DIC_ROCK_ALL_CACHE.exists():
        logger.debug("Writing to cache")
        DIC_ROCK_ALL_CACHE.write_bytes(pickle.dumps(rows))


def import_geol_unit_comp_part(conn: sqlite3.Connection):
    """
    This function was meant to pull the data from Oracle directly, but
    didn't work.  There is an issue with permissions or schema search
    paths.  It's strange, though, because the same query works in DBeaver
    when executed with the same credentials.  Instead, I just saved those
    results as the CSV that you see here.  The table isn't likely to change
    soon.

        SELECT
          RCS,
          CGI_LITHOLOGY_URI,
          CGI_LITHOLOGY_LABEL,
          INSP_LITHOLOGY_URI,
          INSP_LITHOLOGY_LABEL
        FROM OGC.GEOL_UNIT_COMP_PART
    """

    def transform(chunk: Iterable[dict]) -> Iterable[dict]:
        for row in chunk:
            # Convert keys to lower case
            key_list = list(row.keys())

            for key in key_list:
                row[key.lower()] = row.pop(key)

            # Rename rows
            row['inspire_lithology_uri'] = row.pop('insp_lithology_uri')
            row['inspire_lithology_label'] = row.pop('insp_lithology_label')

            yield row

    with open(GEOL_UNIT_CSV, 'rt', encoding='iso-8859-1') as in_file:
        reader = csv.DictReader(in_file)
        etl.load('geol_unit_comp_part', conn, transform(reader))


def import_dic_rock_field_rcs(conn: sqlite3.Connection):
    """
    This imports a CSV file created by selecting columns from the spreadsheet
    of the same name (See https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/issues/87#note_126309)
    and exporting them.  There was also a special character after Lamprophyre
    the broke the character encoding and was deleted.
    """

    def transform(chunk: Iterable[dict]) -> Iterable[dict]:
        all_codes = set()  # We will assume all records are in one chunk

        for row in chunk:
            # Remove unwanted columns and convert keys to lower case
            rows_to_keep = {"RCS_code", "CATEGORY_MERGIN", "Composite",
                            "RCS_TRANSLATION_LOWERCASE"}
            key_list = list(row.keys())

            for key in key_list:
                if key in rows_to_keep:
                    row[key.lower()] = row.pop(key)
                else:
                    row.pop(key)

            # Rename column
            row['code'] = row.pop('rcs_code')
            row['category'] = row.pop('category_mergin')
            row['label'] = row.pop('rcs_translation_lowercase')
            row['user_entered'] = 'jostev'
            row['date_entered'] = dt.datetime(2024, 3, 5, 9, 0, 0)
            # Set these rows to be the default lithologies
            row['is_default'] = 1

            # Drop duplicate rows
            if row['code'] in all_codes:
                logger.info(
                    "Dropping row with duplicate code: %s (%s)",
                    row['code'], row['label'],
                )
                continue

            all_codes.add(row['code'])

            yield row

    with open(DIC_ROCK_FIELD_CSV, 'rt') as in_file:
        reader = csv.DictReader(in_file)
        etl.load('dic_rock_field', conn, transform(reader))


def import_simple_lithology(conn: sqlite3.Connection) -> None:
    """
    Import the simple_lithology table from the plugin SQL files.
    """
    conn.executescript(SIMPLE_LITHOLOGY_SQL.read_text())


def update_cgi_uris_from_inspire(conn):
    """
    Update the geol_unit_comp_part table to fill in missing CGI URIs by converting
    the Inspire URIs from camelCase to snake_case.

    Code for case conversion from Stack Overflow CC BY-SA 4.0
    https://stackoverflow.com/a/1176023/3508733
    """
    # Some RCS values are UKNOWN... ? hmm
    # The better way to remove unknown/voided values is that the inspire lithology = '/N'
    select_sql = """
        SELECT
            rcs,
            inspire_lithology_uri
        FROM
            geol_unit_comp_part
        WHERE
            cgi_lithology_uri IS ''
        AND
            inspire_lithology_uri != '/N'
    """

    update_sql = """
        UPDATE
            geol_unit_comp_part
        SET
            cgi_lithology_uri = :cgi_lithology_uri
        WHERE
            rcs = :rcs
        AND
            cgi_lithology_uri IS ''
    """

    rows = etl.iter_rows(select_sql, conn, transform=transform_inspire_to_cgi,
                         row_factory=etl.row_factories.dict_row_factory)
    etl.executemany(update_sql, conn, rows)


def transform_inspire_to_cgi(chunk: Iterable[dict]) -> Iterable[dict]:
    """
    Transform inspire lithology URIs into CGI lithology URIs.
    This mainly consists of converting snake case to camel case,
    but there are a couple of unique differences too.
    """
    pattern = re.compile(r'(?<!^)(?=[A-Z])')
    inspire_to_cgi_conversions = {
        "dolomite": "dolostone",
        "gypsumOrAnhydrite": "rock_gypsum_or_anhydrite",
        # Typo
        "phonolilte": "phonolite",
        # There are other examples such as 'clastic_sediment' in cgi, but 'sediment' is not included in inspire
        "conglomerate": "clastic_conglomerate",
        "mudstone": "clastic_mudstone",
        "sandstone": "clastic_sandstone",
    }

    for row in chunk:
        inspire_name = row.pop('inspire_lithology_uri').split('/')[-1]

        if inspire_name in inspire_to_cgi_conversions:
            cgi_name = inspire_to_cgi_conversions[inspire_name]
        else:
            cgi_name = re.sub(pattern, '_', inspire_name).lower()

        row['cgi_lithology_uri'] = CGI_BASE_URL + cgi_name
        yield row


def extend_dic_rock_field(conn: sqlite3.Connection) -> None:
    """
    Copy rows from _dic_rock_all into dic_rock_field by matching the 'code' attribute.
    Uses UPSERT so that codes which already exist are updated instead of replaced:
    https://www.sqlite.org/lang_upsert.html
    """
    # Get _dic_rock_all rows
    dic_rock_all_select_sql = """
        SELECT
            code,
            description,
            translation
        FROM
            _dic_rock_all
        WHERE
            status = 'C'
    """

    dic_rock_all_rows = etl.fetchall(dic_rock_all_select_sql,
                                     conn,
                                     row_factory=etl.row_factories.dict_row_factory)

    dic_rock_field_upsert_sql = """
        INSERT INTO dic_rock_field
            (code, label, description, user_entered, date_entered)
        VALUES
            (:code, :translation, :description, :user_entered, :date_entered)
        ON CONFLICT
            (code)
        DO
            UPDATE SET
                label = :translation,
                description = :description
            WHERE
                code = :code
        """

    for dic_rock_all_row in dic_rock_all_rows:
        # Add user and date entered
        # Dictionaries are updated in place
        dic_rock_all_row["user_entered"] = "leorud"
        dic_rock_all_row["date_entered"] = dt.datetime(2024, 3, 5, 16, 0, 0)

    etl.executemany(dic_rock_field_upsert_sql, conn, dic_rock_all_rows)


def populate_simple_lithology(conn: sqlite3.Connection) -> None:
    """
    Populate the simple_lithology column in the dic_rock_field table.
    This process uses the geol_unit_comp_part table to match the simple_lithology URIs
    to RCS codes.
    """
    gucp_dra_update_drf = """
        UPDATE
            dic_rock_field AS drf
        SET
            simple_lithology = gucp_dra.simple_lithology
        FROM (
            SELECT
                gucp.rcs,
                gucp.cgi_lithology_label,
                gucp.cgi_lithology_uri,
                sl.name as simple_lithology
            FROM
                geol_unit_comp_part AS gucp
            -- Inner join on _dic_rock_all so that the RCS codes are valid
            -- It is also safer to join on _dic_rock_all rather than
            -- dic_rock_field because _dic_rock_all has not been modified
            INNER JOIN
                _dic_rock_all AS dra ON gucp.rcs = dra.code
            -- Use _simple_lithology to get user-friendly names
            LEFT JOIN
                _simple_lithology AS sl ON gucp.cgi_lithology_uri = sl.simple_lithology_uri
            -- Group by _dic_rock_all RCS codes to prevent duplication
            GROUP BY
                dra.code
        ) AS gucp_dra
        WHERE
            drf.code = gucp_dra.rcs
    """
    etl.execute(gucp_dra_update_drf, conn)


def fill_missing_colours_and_lithologies(conn):
    # Dictionary stores hex code for lithologies where there isn't one defined
    # based on other rocks in the same category.
    missing_colours = {
        "anthracite": "#6E4900",  # coal
        "ash breccia bomb or block tephra": "#C84100",  # tephra
        "ash tuff lapillistone and lapilli tuff": "#FFEDBF",  # pyroclastic rock
        "tuff breccia agglomerate or pyroclastic breccia": "#FFEDBF",  # pyroclastic rock
        "breccia gouge series": "#F4FFD5",  # cataclasite series
        "fault related material": "#F4FFD5",  # cataclasite series
        "kalsilitic and melilitic rocks": "#FF6F91",  # exotic composition igneous rock
        "non clastic siliceous sediment": "#9696B9",  # siliceous ooze
        "non clastic siliceous sedimentary material": "#9696B9",  # siliceous ooze
        "non clastic siliceous sedimentary rock": "#F7F3A1",  # biogenic silica sedimentary rock
    }
    missing_colours = [
        dict(name=key, hex_colour=value)
        for key, value in missing_colours.items()
    ]

    update_sql = """
        UPDATE
            _simple_lithology
        SET
            hex_colour = :hex_colour
        WHERE
            name = :name
    """

    etl.executemany(update_sql, conn, missing_colours)

    # For now we only do the lithologies from Maarten's list
    missing_lithologies = {
        "Fault-breccia": "breccia gouge series",
        "Lapillistone": "ash tuff lapillistone and lapilli tuff",
        "Tephra": "tephra",
        "Basalt tuff": "ash tuff lapillistone and lapilli tuff",
        "Meta-igneous rock": "metamorphic rock",  # there is nothing more precise
        "Metarhyolite": "metamorphic rock",
        "Coal and mudstone": "coal",
        "Duricrust": "duricrust",
        "Ferricrete": "duricrust",
        "Gypsum": "gypsum or anhydrite",
        "Halite-stone": "rock salt",
        "Seat-earth": "duricrust",
        "Silcrete": "duricrust",
        "Sandy siltstone": "siltstone",
        "Cobbles [UDCS]": "clastic sedimentary material",  # broader category, specific sizes only go to gravel
        # All the vein rocks are classified as chemical sedimentary material as
        # there is no way to subdivide them further based on composition.
        "Baryte (vein)": "chemical sedimentary material",
        "Copper (vein)": "chemical sedimentary material",
        "Hematite (vein)": "chemical sedimentary material",
        "Iron (vein)": "chemical sedimentary material",
        "Lead (vein)": "chemical sedimentary material",
        "Lead-zinc (vein)": "chemical sedimentary material",
        "Pyrite (vein)": "chemical sedimentary material",
        "Uranium (vein)": "chemical sedimentary material",
        "Vein rock": "chemical sedimentary material",
        "Zinc (vein)": "chemical sedimentary material",
    }
    missing_lithologies = [
        dict(label=key, lithology=value)
        for key, value in missing_lithologies.items()
    ]

    update_sql = """
        UPDATE
            dic_rock_field
        SET
            simple_lithology = :lithology
        WHERE
            label = :label
    """

    etl.executemany(update_sql, conn, missing_lithologies)


def populate_category(conn: sqlite3.Connection) -> None:
    """
    Populate the category column in the dic_rock_field table where it is currently empty.
    This process uses the simple_lithology table, specifically the parents list to retrieve
    the category for each rock type.
    """
    sl_update_drf = """
        UPDATE
            dic_rock_field AS drf
        SET
            -- Match the new category value to the type found in the parents list
            category = CASE
                WHEN sl.parents LIKE('%pyroclastic%') THEN 'IGNEOUS-VOLCANIC ROCK'
                WHEN sl.parents LIKE('%igneous%') THEN 'IGNEOUS ROCK'
                WHEN sl.parents LIKE('%sedimentary%') THEN 'SEDIMENTARY ROCK'
                WHEN sl.parents LIKE('%metamorphic%') THEN 'METAMORPHIC ROCK'
                ELSE NULL
            END
        FROM
            _simple_lithology AS sl
        WHERE
            drf.simple_lithology = sl.name
        -- Only update the category where it is empty
        AND
            drf.category IS NULL
    """
    etl.execute(sl_update_drf, conn)


def dump_sql(conn: sqlite3.Connection, output=OUTPUT_FILE):
    with open(output, 'wt') as outfile:
        for line in conn.iterdump():
            outfile.write(line + '\n')
            logging.debug(line)


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s %(levelname)s: %(message)s"
    )
    main()
