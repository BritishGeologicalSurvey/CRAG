-- Activity table, which is parent of localities
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "field_project" (
	"fid"	INTEGER NOT NULL,
	"objectid"	INTEGER UNIQUE,
	"uuid"	TEXT NOT NULL UNIQUE,
	"short_name" TEXT NOT NULL UNIQUE,
	"title"	TEXT,
	"description"	TEXT,
	"project_lead"	TEXT,
	"status_code"	TEXT,
	"start_date"	DATE,
	"end_date"	DATE,
	"field_project_type"	TEXT NOT NULL,
	"local_epsg"  INTEGER NOT NULL,
	"notes"	TEXT,
	"mapped_scale"	INTEGER NOT NULL,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	FOREIGN KEY("field_project_type") REFERENCES "dic_field_project_type"("code"),
	PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('field_project','attributes','field_project','Metadata for field project.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


CREATE TRIGGER "field_project_clear_updated"
  AFTER INSERT ON "field_project" WHEN (NEW."user_updated" NOT NULL AND NEW."date_updated" NOT NULL)
    BEGIN
      UPDATE "field_project" SET user_updated = NULL, date_updated = NULL
      WHERE fid = NEW."fid"; END;

COMMIT;