-- Activity table, which is parent of localities
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "activity" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"objectid"	INTEGER,
	"uuid"	TEXT NOT NULL DEFAULT 'uuid()' UNIQUE,
	"title"	TEXT,
	"description"	BLOB,
	"responsible_person_id"	TEXT,
	"status_code"	TEXT,
	"start_date"	DATE,
	"end_date"	DATE,
	"activity_code"	TEXT NOT NULL,
	"comment"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	FOREIGN KEY("activity_code") REFERENCES "dic_activity"("code"),
	PRIMARY KEY("fid","uuid")
);

COMMIT;