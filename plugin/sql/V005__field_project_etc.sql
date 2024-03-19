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

CREATE TRIGGER "field_project_limit_1"
	BEFORE INSERT ON "field_project" WHEN (SELECT COUNT(1) FROM "field_project") >= 1
	BEGIN
		SELECT RAISE(FAIL, "Only one Field Project is permitted per project."); END;


CREATE TABLE IF NOT EXISTS "_lnk_rock_project" (
	"fid"	INTEGER NOT NULL,
	"field_project_uuid" TEXT NOT NULL,
	"rock_code"	TEXT NOT NULL,
	"category" TEXT,
	"simple_lithology" TEXT,
	FOREIGN KEY("rock_code") REFERENCES "dic_rock_field"("code"),
	FOREIGN KEY("field_project_uuid") REFERENCES "field_project"("uuid"),
	PRIMARY KEY("fid" AUTOINCREMENT)
);

-- TODO: register relationship in geopackage http://www.geopackage.org/guidance/extensions/related_tables.html
insert into gpkg_contents
values('_lnk_rock_project','attributes','_lnk_rock_project','Linking table to define project lithologies','2022-09-15t13:21:52.679z',null,null,null,null,null);


CREATE TRIGGER add_new_project_lithologies
AFTER INSERT ON field_project
BEGIN
  INSERT INTO _lnk_rock_project (field_project_uuid, rock_code)
  SELECT
     NEW.uuid as field_project_uuid,  -- new project ID
     code as rock_code
     FROM dic_rock_field
     WHERE is_default IS True;
END;


CREATE TRIGGER populate_label_and_category
AFTER INSERT ON _lnk_rock_project
BEGIN
    UPDATE _lnk_rock_project
	SET category = (
		    SELECT category
		    FROM dic_rock_field
		    WHERE dic_rock_field.code = NEW.rock_code
	    ),
	    simple_lithology = (
			SELECT simple_lithology
			FROM dic_rock_field
			WHERE dic_rock_field.code = NEW.rock_code
		)
	WHERE field_project_uuid = NEW.field_project_uuid
	  AND rock_code = NEW.rock_code;
END;

COMMIT;