/*
Copyright 2026 UKRI / British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
*/
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "structural_measurement" (
  "fid" INTEGER NOT NULL,
  "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
  "locality_fuid" TEXT NOT NULL CHECK(LENGTH("locality_fuid") <= 38),
  "structure_type_code" TEXT NOT NULL CHECK(LENGTH("structure_type_code") <= 50),
  "dip" REAL CHECK("dip" >= 0 AND "dip" <= 90),
  "azimuth" REAL CHECK("azimuth" >= 0 AND "azimuth" < 360),
  "secondary_attribute" TEXT CHECK(LENGTH("secondary_attribute") <= 255),
  "third_attribute" TEXT CHECK(LENGTH("third_attribute") <= 255),
  "notes" TEXT CHECK(LENGTH("notes") <= 4000),
  "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
  "recorded_on" DATETIME NOT NULL,
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  FOREIGN KEY("structure_type_code") REFERENCES "dic_structure"("code"),
  FOREIGN KEY("secondary_attribute") REFERENCES "dic_structure_secondary"("code"),
  FOREIGN KEY("third_attribute") REFERENCES "dic_structure_third"("code"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('structural_measurement','attributes','structural_measurement','Structural measurement data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "manmade_landform" (
  "fid" INTEGER NOT NULL,
  "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
  "locality_fuid" TEXT NOT NULL CHECK(LENGTH("locality_fuid") <= 38),
  "manmade_type_code" TEXT NOT NULL CHECK(LENGTH("manmade_type_code") <= 50),
  "dip" REAL CHECK("dip" >= 0 AND "dip" <= 90),
  "azimuth" REAL CHECK("azimuth" >= 0 AND "azimuth" < 360),
  "length" REAL,
  "width" REAL,
  "notes" TEXT CHECK(LENGTH("notes") <= 4000),
  "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
  "recorded_on" DATETIME NOT NULL,
  FOREIGN KEY("manmade_type_code") REFERENCES "dic_manmade_landform"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('manmade_landform','attributes','manmade_landform','Man-made landforms data, e.g. quarries.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "lithology"(
  "fid" INTEGER NOT NULL,
  "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
  "locality_fuid" TEXT NOT NULL CHECK(LENGTH("locality_fuid") <= 38),
  "lithology_code" TEXT NOT NULL CHECK(LENGTH("lithology_code") <= 50),
  "notes" TEXT CHECK(LENGTH("notes") <= 4000),
  "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
  "recorded_on" DATETIME NOT NULL,
  FOREIGN KEY("lithology_code") REFERENCES "dic_rock_field"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
)
;

INSERT INTO gpkg_contents
VALUES('lithology','attributes','lithology','Rock type at the surface','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "media" (
  "fid" INTEGER NOT NULL,
  "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
  "locality_fuid" TEXT NOT NULL CHECK(LENGTH("locality_fuid") <= 38),
  "media_type_code" TEXT NOT NULL CHECK(LENGTH("media_type_code") <= 50),
  "media_link" TEXT CHECK(LENGTH("media_link") <= 4000),
  "media_description" TEXT CHECK(LENGTH("media_description") <= 4000),
  "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
  "recorded_on" DATETIME NOT NULL,
  FOREIGN KEY("media_type_code") REFERENCES "dic_media"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('media','attributes','media','Media files associated with locality.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "photo" (
  "fid" INTEGER NOT NULL,
  "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
  "locality_fuid" TEXT NOT NULL CHECK(LENGTH("locality_fuid") <= 38),
  "photo_file" TEXT CHECK(LENGTH("photo_file") <= 4000),
  "caption" TEXT CHECK(LENGTH("caption") <= 250),  -- 250 characters is limit for ImageBase system
  "description" TEXT CHECK(LENGTH("caption") <= 4000),
  "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
  "recorded_on" DATETIME NOT NULL,
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('photo','attributes','photo','Photo files associated with locality.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "sample" (
  "fid" INTEGER NOT NULL,
  "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
  "locality_fuid" TEXT NOT NULL CHECK(LENGTH("locality_fuid") <= 38),
  "sample_id" TEXT NOT NULL CHECK(LENGTH("sample_id") <= 255),
  "sample_type_code" TEXT NOT NULL CHECK(LENGTH("sample_type_code") <= 50),
  "sample_description" TEXT CHECK(LENGTH("sample_description") <= 4000),
  "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
  "recorded_on" DATETIME NOT NULL,
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  FOREIGN KEY("sample_type_code") REFERENCES "dic_sample_material"("code"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('sample','attributes','sample','Sample data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "superficial_landform" (
  "fid" INTEGER NOT NULL,
  "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
  "locality_fuid" TEXT NOT NULL CHECK(LENGTH("locality_fuid") <= 38),
  "superficial_type_code" TEXT NOT NULL CHECK(LENGTH("superficial_type_code") <= 50),
  "dip" REAL CHECK("dip" >= 0 AND "dip" <= 90),
  "azimuth" REAL CHECK("azimuth" >= 0 AND "azimuth" < 360),
  "length" REAL,
  "width" REAL,
  "height_depth" REAL,
  "notes" TEXT CHECK(LENGTH("notes") <= 4000),
  "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
  "recorded_on" DATETIME NOT NULL,
  FOREIGN KEY("superficial_type_code") REFERENCES "dic_superficial_landform"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('superficial_landform','attributes','superficial_landform','Superficial landform data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


COMMIT;
