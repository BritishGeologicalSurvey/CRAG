BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "locality_structural_measurement" (
  "fid" INTEGER NOT NULL UNIQUE,
  "objectid" INTEGER,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "structure_type_category" TEXT NOT NULL,
  "structure_type_code" TEXT NOT NULL,
  "dip" INTEGER CHECK("dip" >= 0 AND "dip" <= 90),
  "dip_direction" INTEGER CHECK("dip_direction" >= 0 AND "dip_direction" < 360),
  "secondary_attrib" TEXT,
  "third_attrib" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT,
  "date_updated" DATETIME,
  FOREIGN KEY("structure_type_code") REFERENCES "dic_structure_code"("code"),
  FOREIGN KEY("secondary_attrib") REFERENCES "dic_structure_secondary"("code"),
  FOREIGN KEY("structure_type_category") REFERENCES "dic_structure_code"("category"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('locality_structural_measurement','attributes','locality_structural_measurement','Structural measurement data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "user_details" (
  "fid" INTEGER NOT NULL UNIQUE,
  "objectid" INTEGER NOT NULL UNIQUE,
  "user_type_code" TEXT NOT NULL,
  "user_description" TEXT NOT NULL,
  "last_location_no" INTEGER,
  "last_media_no" INTEGER,
  "last_sample_no" INTEGER,
  "last_strucuture_no" INTEGER,
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('user_details','attributes','user_details','Localised user information and user numbers.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "locality_manmade_landform" (
  "fid" INTEGER NOT NULL UNIQUE,
  "objectid" INTEGER,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "manmade_type_code" TEXT NOT NULL,
  "dip" INTEGER CHECK("dip" >= 0 AND "dip" <= 90),
  "dip_dir" INTEGER CHECK("dip" >= 0 AND "dip" <= 360),
  "length" INTEGER,
  "width" INTEGER,
  "comment" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT,
  "date_updated" DATETIME,
  FOREIGN KEY("manmade_type_code") REFERENCES "dic_manmade_code"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('locality_manmade_landform','attributes','locality_manmade_landform','Man-made landforms data, e.g. quarries.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "locality_media" (
  "fid" INTEGER NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "objectid" INTEGER,
  "uuid" TEXT NOT NULL UNIQUE,
  "media_type_code" TEXT NOT NULL,
  "media_link" TEXT NOT NULL,
  "comment" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT, "date_updated" DATETIME,
  FOREIGN KEY("media_type_code") REFERENCES "dic_media"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('locality_media','attributes','locality_media','Media files associated with locality.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "locality_sample" (
  "fid" INTEGER NOT NULL UNIQUE,
  "objectid" INTEGER,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "sample_type_code" TEXT NOT NULL,
  "sample_description" TEXT,
  "comment" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT,
  "date_updated" DATETIME,
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  FOREIGN KEY("sample_type_code") REFERENCES "dic_sample"("code"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('locality_sample','attributes','locality_sample','Sample data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "locality_superficial_landform" (
  "fid" INTEGER NOT NULL UNIQUE,
  "objectid" INTEGER,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "superficial_type_category" TEXT NOT NULL,
  "superficial_type_code" TEXT NOT NULL,
  "dip" INTEGER CHECK("dip" >= 0 AND "dip" <= 90),
  "length" INTEGER,
  "width" INTEGER,
  "height_depth" INTEGER,
  "comment" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT, "date_updated" DATETIME,
  FOREIGN KEY("superficial_type_code") REFERENCES "dic_superficial_code"("code"),
  FOREIGN KEY("superficial_type_category") REFERENCES "dic_superficial_category"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('locality_superficial_landform','attributes','locality_superficial_landform','Superficial landform data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

COMMIT;