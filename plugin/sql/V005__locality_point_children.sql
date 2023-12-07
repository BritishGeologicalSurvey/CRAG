BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "structural_measurement" (
  "fid" INTEGER NOT NULL,
  "objectid" INTEGER UNIQUE,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "structure_type_category" TEXT NOT NULL,
  "structure_type_code" TEXT NOT NULL,
  "dip" INTEGER CHECK("dip" >= 0 AND "dip" <= 90),
  "dip_direction" INTEGER CHECK("dip_direction" >= 0 AND "dip_direction" < 360),
  "comment" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT,
  "date_updated" DATETIME,
  FOREIGN KEY("structure_type_code") REFERENCES "dic_structure_code"("code"),
  FOREIGN KEY("structure_type_category") REFERENCES "dic_structure_category"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('structural_measurement','attributes','structural_measurement','Structural measurement data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "manmade_landform" (
  "fid" INTEGER NOT NULL,
  "objectid" INTEGER UNIQUE,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "manmade_type_code" TEXT NOT NULL,
  "dip" INTEGER CHECK("dip" >= 0 AND "dip" <= 90),
  "dip_direction" INTEGER CHECK("dip_direction" >= 0 AND "dip_direction" < 360),
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
VALUES('manmade_landform','attributes','manmade_landform','Man-made landforms data, e.g. quarries.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "lithology"(
  "fid" INTEGER NOT NULL,
  "objectid" INTEGER UNIQUE,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "lithology_code" TEXT,
  "description" TEXT,
  "comment" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT,
  "date_updated" DATETIME,
  FOREIGN KEY("lithology_code") REFERENCES "dic_rock_all"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
)
;

INSERT INTO gpkg_contents
VALUES('lithology','attributes','lithology','Rock type at the surface','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "media" (
  "fid" INTEGER NOT NULL,
  "objectid" INTEGER UNIQUE,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
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
VALUES('media','attributes','media','Media files associated with locality.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "photo" (
  "fid" INTEGER NOT NULL,
  "objectid" INTEGER UNIQUE,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "photo_file" TEXT NOT NULL,
  "comment" TEXT,
  "user_entered" TEXT NOT NULL,
  "date_entered" DATETIME NOT NULL,
  "user_updated" TEXT, "date_updated" DATETIME,
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('photo','attributes','photo','Photo files associated with locality.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "sample" (
  "fid" INTEGER NOT NULL,
  "objectid" INTEGER UNIQUE,
  "uuid" TEXT NOT NULL UNIQUE,
  "locality_fuid" TEXT NOT NULL,
  "sample_id" TEXT NOT NULL,
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
VALUES('sample','attributes','sample','Sample data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TABLE IF NOT EXISTS "superficial_landform" (
  "fid" INTEGER NOT NULL,
  "objectid" INTEGER UNIQUE,
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
  "user_updated" TEXT,
  "date_updated" DATETIME,
  FOREIGN KEY("superficial_type_code") REFERENCES "dic_superficial_code"("code"),
  FOREIGN KEY("superficial_type_category") REFERENCES "dic_superficial_category"("code"),
  FOREIGN KEY("locality_fuid") REFERENCES "locality_point"("uuid"),
  PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('superficial_landform','attributes','superficial_landform','Superficial landform data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TRIGGER "structural_measurement_clear_updated"
  AFTER INSERT ON "structural_measurement" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "structural_measurement" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;


CREATE TRIGGER "manmade_landform_clear_updated"
  AFTER INSERT ON "manmade_landform" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "manmade_landform" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;


CREATE TRIGGER "lithology_clear_updated"
  AFTER INSERT ON "lithology" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "lithology" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;


CREATE TRIGGER "media_clear_updated"
  AFTER INSERT ON "media" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "media" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;


CREATE TRIGGER "photo_clear_updated"
  AFTER INSERT ON "photo" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "photo" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;


CREATE TRIGGER "sample_clear_updated"
  AFTER INSERT ON "sample" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "sample" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;


CREATE TRIGGER "superficial_landform_clear_updated"
  AFTER INSERT ON "superficial_landform" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "superficial_landform" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;

COMMIT;