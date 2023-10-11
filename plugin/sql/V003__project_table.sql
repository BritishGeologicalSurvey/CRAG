-- Activity table, which is parent of localities
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "project" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"objectid"	INTEGER UNIQUE,
	"uuid"	TEXT NOT NULL UNIQUE,
	"short_name" TEXT NOT NULL UNIQUE,
	"title"	TEXT,
	"description"	TEXT,
	"responsible_person_id"	TEXT,
	"status_code"	TEXT,
	"start_date"	DATE,
	"end_date"	DATE,
	"project_type"	TEXT NOT NULL,
	"local_epsg"  INTEGER NOT NULL,
	"comment"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	FOREIGN KEY("project_type") REFERENCES "dic_project_type"("code"),
	PRIMARY KEY("fid")
);

INSERT INTO gpkg_contents
VALUES('project','attributes','project','Metadata for project.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

COMMIT;