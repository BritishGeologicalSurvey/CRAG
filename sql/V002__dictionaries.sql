-- Dictionary tables and their contents

BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "dic_sample" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"code"	TEXT NOT NULL,
	"description"	TEXT NOT NULL,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	INTEGER,
	"date_updated"	DATE,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('dic_sample','attributes','dic_sample','Sample type dictionary.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

CREATE TABLE IF NOT EXISTS "dic_media" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"code"	TEXT NOT NULL,
	"description"	TEXT NOT NULL,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	INTEGER,
	"date_updated"	DATE,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('dic_media','attributes','dic_media','Media type dictionary.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

CREATE TABLE IF NOT EXISTS "dic_activity" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"code"	TEXT NOT NULL,
	"description"	TEXT NOT NULL,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('dic_activity','attributes','dic_activity','Activity type dictionary.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

CREATE TABLE IF NOT EXISTS "dic_users" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"code"	TEXT NOT NULL,
	"description"	TEXT NOT NULL,
	"translation"	TEXT,
	"site"	TEXT NOT NULL,
	"status"	TEXT,
	"user_entered"	TEXT,
	"date_entered"	DATE,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

INSERT INTO gpkg_contents
VALUES('dic_users','attributes','dic_users','Dictionary of users','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

CREATE TABLE IF NOT EXISTS "dic_structure_category" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	PRIMARY KEY("code")
);

INSERT INTO gpkg_contents
VALUES('dic_structure_category','attributes','dic_structure_category','Dictionary of structure categories.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

CREATE TABLE IF NOT EXISTS "dic_superficial_category" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	PRIMARY KEY("code")
);

insert into gpkg_contents
values('dic_superficial_category','attributes','dic_superficial_category','Dictionary of superficial categories.','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE IF NOT EXISTS "dic_manmade_code" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"code"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"archived_code"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	PRIMARY KEY("code")
);

insert into gpkg_contents
values('dic_manmade_code','attributes','dic_manmade_code','Dictionary of man-made features.','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE IF NOT EXISTS "dic_structure_secondary" (
	"fid"	INTEGER,
	"category"	TEXT,
	"code"	TEXT,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT,
	"date_entered"	TEXT,
	"user_updated"	TEXT,
	"date_updated"	TEXT,
	FOREIGN KEY("category") REFERENCES "dic_structure_code"("secondary_attribute")
);

insert into gpkg_contents
values('dic_structure_secondary','attributes','dic_structure_secondary','Dictionary of structure secondary attributes.','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE IF NOT EXISTS "dic_structure_third" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"category"	TEXT NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"description"	TEXT NOT NULL,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	PRIMARY KEY("code"),
	FOREIGN KEY("code") REFERENCES "dic_structure_code"("third_attribute")
);

insert into gpkg_contents
values('dic_structure_third','attributes','dic_structure_third','Dictionary of structure tertiary attributes.','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE IF NOT EXISTS "dic_structure_code" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"category"	TEXT NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"secondary_attribute"	TEXT,
	"third_attribute"	TEXT,
	"fourth_attribute"	TEXT,
	"status"	TEXT,
	"translation"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATE NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATE,
	PRIMARY KEY("code"),
	FOREIGN KEY("category") REFERENCES "dic_structure_category"("code")
);

insert into gpkg_contents
values('dic_structure_code','attributes','dic_structure_code','Dictionary of structure codes.','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE IF NOT EXISTS "dic_superficial_code" (
	"fid"	INTEGER NOT NULL UNIQUE,
	"category"	TEXT,
	"code"	TEXT NOT NULL UNIQUE,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"archived_code"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	TEXT NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	TEXT,
	PRIMARY KEY("fid" AUTOINCREMENT),
	FOREIGN KEY("category") REFERENCES "dic_superficial_category"("code")
);

insert into gpkg_contents
values('dic_superficial_code','attributes','dic_superficial_code','Dictionary of superficial codes.','2023-09-15t13:21:52.679z',null,null,null,null,null);

INSERT INTO "dic_sample" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'FOSS','Fossil sample','fossil_sample','C','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_sample" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'HAND','Hand specimen','hand_specimen','C','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_sample" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'ROCK','Bedrock sample','bedrock_sample','C','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_sample" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'SOIL','Soil sample','soil_sample','C','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_sample" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'STREAM','Stream sediment sample','stream_sediment_sample','C','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_sample" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'SUPER','Superficial deposit sample','superficial_deposit_sample','C','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_media" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'IMAGE','Image or Photograph','image','C','jbow','13/09/2023',NULL,NULL);
INSERT INTO "dic_media" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'VIDEO','Video','video','C','jbow','13/09/2023',NULL,NULL);
INSERT INTO "dic_media" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'VOICE','Voice note','voice','C','jbow','13/09/2023',NULL,NULL);
INSERT INTO "dic_activity" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'FIELD','Field work','field_work','C','jbow','04/09/2023',NULL,NULL);
INSERT INTO "dic_activity" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'RAPID','Rapid field work','rapid_field_work','C','jbow','04/09/2023',NULL,NULL);
INSERT INTO "dic_activity" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'REMOTE','Derived using remote sensing resources','remote_sensing','C','jbow','13/09/2023',NULL,NULL);
INSERT INTO "dic_activity" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'DESK','Desk compilation','desk_compilation','C','jbow','04/09/2023',NULL,NULL);
INSERT INTO "dic_activity" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'ARCHIVE','Archive upload','archive_upload','C','jbow','04/09/2023',NULL,NULL);
INSERT INTO "dic_activity" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'LAB','Lab study','lab_study','C','jbow','04/09/2023',NULL,NULL);
INSERT INTO "dic_activity" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'PAPER','Derived from a paper map or fieldslip','derived_from_paper','C','jbow','04/09/2023',NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'AGH','HULBERT, ANDREW',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'AJPI','BAPTIE, AMELIA',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'APBE','BEVAN, ANDY',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'APMA','MARCHANT, ANDREW',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'ARF','FARRANT, ANDREW',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'CGH','HORABIN, CARL',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'CLRL','SHELLEY, CLAIRE',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (8,'COLB','BLACKBURN, COLIN',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (9,'DANWAR','WARREN, DANIEL',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (10,'DBURGESS','BURGESS, DANIEL',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (11,'DJRM','MORGAN, DAVE',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (12,'ECAL','CALLAGHAN, EILEEN',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (13,'EIMEAR','DEADY, EIMEAR',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (14,'ERP','PHILLIPS, EMRYS',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (15,'GAYLEP','PLENDERLEITH, GAYLE',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (16,'HBU','BURKE, HELEN',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (17,'JBOW','BOW, JENNIFER',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (18,'JENN','RICHARDSON, JENNIFER',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (19,'JFORD','FORD, JONATHAN',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (20,'JNA','NADEN, JONATHAN',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (21,'JOSTEV','STEVENSON, JOHN',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (22,'JRLEE','LEE, JONATHAN',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (23,'JYOU','YOUSAF, JAVID',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (24,'KBO','LEE, KATHRYN',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (25,'KIGL','LAWRIE, KEN',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (26,'KMGO','GOODENOUGH, KATHRYN M',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (27,'KWHI','WHITBREAD, KATIE',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (28,'LAUBG','BURREL, LAURA',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (29,'LAURA1','AUSTIN SYDES, LAURA',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (30,'LEAN1','HUGHES, LEANNE',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (31,'LEORUD','RUDCZENKO, LEO',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (32,'LIAMS','SPENCER, LIAM',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (33,'MKRAB','KRABBENDAM, MAARTEN',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (34,'MLN','NAYEMBIL, MARTIN L',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (35,'NASM','SMITH, NIKKI',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (36,'PAUTVA','TVARANAVICIUS, PAULIUS',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (37,'RHND1','KENDALL, RHIAN',NULL,'CD',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (38,'RICHAS','HASLAM, RICHARD',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (39,'ROMESH','PALAMAKUMBURA, ROMESH',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (40,'ROWVER','VERNON, ROWAN',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (41,'RROTH','ROTH, ROMAN',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (42,'RSHAW','SHAW, ROB',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (43,'SMPI','PIPER, SIMON',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (44,'STAY','TAYLOR, SOPHIE',NULL,'KW',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (45,'SVEA','RAUTENBERG, SVEA',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (46,'TAR','RANDLES, TOM',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (47,'TARAS','STEPHENS, TARA',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_users" ("fid","code","description","translation","site","status","user_entered","date_entered","user_updated","date_updated") VALUES (48,'TIMKI','KEARSEY, TIMOTHY',NULL,'ED',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'Bedding','Bedding','bedding','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'Fault','Fault','fault','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'Younging','Younging','younging','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'Vergence','Vergence','vergence','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'Mineral_Vein','Mineral vein','mineral_vein','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'Axial_Plane','Axial plane','axial_plane','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'Fold_Axis','Fold axis','fold_axis','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (8,'Foliation','Foliation','foliation','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (9,'Lineation','Lineation','lineation','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (10,'Igneous','Igneous','igneous','C','jbow','23/08/2023',NULL,NULL);
INSERT INTO "dic_structure_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (11,'Facing','Facing','facing','C','jbow','05/09/2023',NULL,NULL);
INSERT INTO "dic_superficial_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'ERRATIC','Erratic','erratic','C','jbow','04/09/2023','','');
INSERT INTO "dic_superficial_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'GLACIAL','Glacial','glacial','C','jbow','04/09/2023','','');
INSERT INTO "dic_superficial_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'GLACIOTECTONIC','Glaciotectonic','glaciotectonic','C','jbow','04/09/2023','','');
INSERT INTO "dic_superficial_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'PERIGLACIAL','Periglacial','periglacial','C','jbow','04/09/2023','','');
INSERT INTO "dic_superficial_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'TOPOGRAPHIC_FEATURE','Topographic feature','topographic_feature','C','jbow','04/09/2023','','');
INSERT INTO "dic_superficial_category" ("fid","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'KARST','Karst','karst','C','jbow','04/09/2023',NULL,NULL);
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (12,'MM_WASTE','Waste disposal site','waste_disposal_site','C',NULL,'kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (1,'MM_ADIT','Adit','adit','C','AD','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (2,'MM_ADIT_A','Adit abandoned','adit_abandoned','C','ADA','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (3,'MM_ADIT_U','Adit unknown orientation','adit_unknown_orientation','C','ADU','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (11,'MM_TRE','Trench','trench','C','TREN','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (6,'MM_PIT_F','Pit fall','pit_fall_crownhole','C','PITF','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (9,'MM_PIT_AC','Pit or mine abandoned and capped','shaft_abandoned_capped','C','PITAC','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (4,'MM_S_FM','Site of former mine','former_mine_site','C','SIFM','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (10,'MM_PIT_U','Pit or mine shaft abandoned uncertain','shaft_abandoned_uncertain','C','PITU','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (8,'MM_PIT_AA','Pit or mine shaft abandoned','shaft_abandoned','C','PITAA','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (7,'MM_PIT','Pit or mine shaft','shaft','C','PIT','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_manmade_code" ("fid","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (5,'MM_PIT_UD','Pit or shaft underground','pit_underground','C','PITUD','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'Younging_Evidence','Young-Geopetal','Geopetal Structures',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'Younging_Evidence','Young-Pillows','Pillows',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'Younging_Evidence','Young-XStrat','Cross-Stratification',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'Younging_Evidence','Young-Dessic','Dessication Cracks',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'Younging_Evidence','Young-Dewater','Dewatering Structures',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'Younging_Evidence','Young-Fossils','Fossils',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'Younging_Evidence','Young-Graded','Graded Bedding',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (8,'Younging_Evidence','Young-Load','Load Structures',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (9,'Younging_Evidence','Young-Ripple','Ripple Marks',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (10,'Younging_Evidence','Young-Scours','Scours and Channels',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (11,'Younging_Evidence','Young-Sole','Sole Markings',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (12,'Younging_Evidence','Young-TraceFoss','Trace Fossils',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (13,'Younging_Evidence','Young-Vesicles','Vesicles',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (14,'Younging_Evidence','Young-Weathering','Weathering Structures',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (15,'Younging_Evidence','Young-FluteCasts','Flute Casts',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (16,'Fold_Shape','Shape-Closed','Closed',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (17,'Fold_Shape','Shape-Gentle','Gentle',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (18,'Fold_Shape','Shape-Isoclinal','Isoclinal',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (19,'Fold_Shape','Shape-Open','Open',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (20,'Fold_Shape','Shape-Tight','Tight',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (21,'Foliation_Penetrative','Fabric-GrainFlat','Grain Flattening',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (22,'Foliation_Penetrative','Fabric-Schistosity','Schistosity',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (23,'Foliation_Penetrative','Fabric-SlatyCleavage','Slaty Cleavage',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (24,'Foliation_Shear','Fabric-MylonPhylon','Mylonitic Phyllonitic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (25,'Foliation_Shear','Fabric-S-C','S-C Fabric',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (26,'Foliation_Shear','Fabric-ShearZoneGen','Shear Zone General',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (27,'Foliation_Spaced','Fabric-Crenulation','Crenulation Cleavage',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (28,'Foliation_Spaced','Fabric-Fracture','Fracture Cleavage',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (29,'Foliation_Spaced','Fabric-Stylolitic','Stylolitic Cleavage',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (30,'Foliation_Spaced','Fabric-Pressure','Pressure Cleavage',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (31,'Foliation_Compositional','Fabric-Gneissic','Gneissic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (32,'Foliation_Compositional','Fabric-Stromatic','Stromatic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (33,'Foliation_Compositional','Fabric-Transposed','Transposed Bedding',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (34,'Igneous_Contact','Contact-Unspecified','Intrusive Contact Unspecified',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (35,'Igneous_Contact','Contact-Intra-Igneous','Intra-Igneous Contact',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (36,'Lineation','Intersection-Lin','Intersection',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (37,'Lineation','Crenulation-Lin','Crenulation',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (38,'Lineation','Elongation-Lin','Elongation',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (39,'Lineation','Mineral-Lin','Mineral',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (40,'Lineation','Boudin-Lin','Boudin',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (41,'Lineation','Mullion-Lin','Mullion',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (42,'Lineation','Rodding-Lin','Rodding',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (43,'Lineation','Pencil-Lin','Pencil',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (44,'Lineation','Slickenside-Lin','Slickenside',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (45,'Igneous_Extrusive','Extrus-Flow Banding','Flow Banding',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (46,'Igneous_Extrusive','Extrus-Flow Foliation','Flow Foliation',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (47,'Igneous_Extrusive','Extrus-Flow Jointing','Flow Jointing',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (48,'Igneous_Extrusive','Extrus-Welding Foliation','Welding Foliation',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (49,'Igneous_Extrusive','Extrus-WeldFol-Parataxitic','Welding Foliation Parataxitic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (50,'Igneous_Extrusive','Extrus-WeldFol-Eutaxitic','Welding Foliation Eutaxitic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (51,'Igneous_Planar','Planar-Flow Banding','Flow Banding',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (52,'Igneous_Planar','Planar-Flow Foliation','Flow Foliation',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (53,'Igneous_Planar','Planar-Flow Jointing','Flow Jointing',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (54,'Igneous_Planar','Welding Foliation','Welding Foliation',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (55,'Igneous_Planar','Weld-Foliation-Parataxitic','Welding Foliation Parataxitic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (56,'Igneous_Planar','Weld-Foliation-Eutaxitic','Welding Foliation Eutaxitic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (57,'Igneous_Planar','Relict Planar fabric','Relict Planar fabric',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (58,'Igneous_Planar','Comp-Layer-Unspec','Compositional Layering Unspec',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (59,'Igneous_Planar','Comp-Layer-Cumulate','Compositional Layering Cumulate',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (60,'Mineral_Dictionary','AGGR','Aggregate',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (61,'Mineral_Dictionary','ALUM','Alum',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (62,'Mineral_Dictionary','ANDA','Andalusite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (63,'Mineral_Dictionary','ANTH','Anthracite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (64,'Mineral_Dictionary','ANTI','Antimony',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (65,'Mineral_Dictionary','ARSC','Arsenic',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (66,'Mineral_Dictionary','ASBE','Asbestos',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (67,'Mineral_Dictionary','BARY','Baryte',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (68,'Mineral_Dictionary','BAUC','Bauxitic Clay',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (69,'Mineral_Dictionary','BAUX','Bauxite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (70,'Mineral_Dictionary','BBI','Blackband Ironstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (71,'Mineral_Dictionary','BCLA','Brick Clay',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (72,'Mineral_Dictionary','BITE','Biotite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (73,'Mineral_Dictionary','BLAE','Blaes',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (74,'Mineral_Dictionary','BUST','Building Stone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (75,'Mineral_Dictionary','CALT','Calcite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (76,'Mineral_Dictionary','CARN','Carnallite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (77,'Mineral_Dictionary','CBI','Clayband Ironstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (78,'Mineral_Dictionary','CEME','Cementstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (79,'Mineral_Dictionary','CHLR','Chlorite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (80,'Mineral_Dictionary','CHRO','Chromite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (81,'Mineral_Dictionary','CLAY','Clay',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (82,'Mineral_Dictionary','CNEL','Cannel Coal',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (83,'Mineral_Dictionary','COAL','Coal',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (84,'Mineral_Dictionary','COPP','Copper',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (85,'Mineral_Dictionary','CORN','Cornstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (86,'Mineral_Dictionary','CORU','Corundum',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (87,'Mineral_Dictionary','DIAT','Diatomite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (88,'Mineral_Dictionary','DOLM','Dolomite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (89,'Mineral_Dictionary','DOLR','Dolerite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (90,'Mineral_Dictionary','FELD','Feldspar',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (91,'Mineral_Dictionary','FICL','Fireclay',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (92,'Mineral_Dictionary','FLAG','Flagstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (93,'Mineral_Dictionary','FLUO','Fluorspar',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (94,'Mineral_Dictionary','GLAU','Glauconite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (95,'Mineral_Dictionary','GNST','Ganister',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (96,'Mineral_Dictionary','GOLD','Gold',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (97,'Mineral_Dictionary','GRAN','Granite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (98,'Mineral_Dictionary','GRAP','Graphite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (99,'Mineral_Dictionary','GRNT','Garnet',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (100,'Mineral_Dictionary','GYPS','Gypsum',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (101,'Mineral_Dictionary','HAEM','Hematite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (102,'Mineral_Dictionary','HALI','Halite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (103,'Mineral_Dictionary','HYDC','Hydrocarbon',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (104,'Mineral_Dictionary','ILME','Ilmenite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (105,'Mineral_Dictionary','IRON','Iron Ore Or Ironstone (Undifferentiated)',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (106,'Mineral_Dictionary','IROR','Iron Ore',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (107,'Mineral_Dictionary','IRST','Ironstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (108,'Mineral_Dictionary','KAIN','Kainite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (109,'Mineral_Dictionary','KAOL','Kaolinite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (110,'Mineral_Dictionary','KIES','Kieserite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (111,'Mineral_Dictionary','KYAN','Kyanite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (112,'Mineral_Dictionary','LANG','Langbeinite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (113,'Mineral_Dictionary','LEAD','Lead',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (114,'Mineral_Dictionary','LIMO','Limonite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (115,'Mineral_Dictionary','LMST','Limestone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (116,'Mineral_Dictionary','MAGN','Magnetite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (117,'Mineral_Dictionary','MANG','Manganese',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (118,'Mineral_Dictionary','MARB','Marble',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (119,'Mineral_Dictionary','MARL','Marl',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (120,'Mineral_Dictionary','MERC','Mercury',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (121,'Mineral_Dictionary','MICA','Mica',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (122,'Mineral_Dictionary','MNER','Mineral Resources, General',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (123,'Mineral_Dictionary','MOLY','Molybdenite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (124,'Mineral_Dictionary','MSAL','Magnesium Salt',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (125,'Mineral_Dictionary','MUSC','Muscovite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (126,'Mineral_Dictionary','NICK','Nickel',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (127,'Mineral_Dictionary','OCHR','Ochre',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (128,'Mineral_Dictionary','OILS','Oil Shale',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (129,'Mineral_Dictionary','OLIV','Olivine Rock',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (130,'Mineral_Dictionary','PEAT','Peat',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (131,'Mineral_Dictionary','PHOS','Phosphate',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (132,'Mineral_Dictionary','POLY','Polyhalite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (133,'Mineral_Dictionary','POTA','Potassium',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (134,'Mineral_Dictionary','PSAL','Potassium Salt',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (135,'Mineral_Dictionary','PYRT','Pyrite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (136,'Mineral_Dictionary','QUTZ','Quartz',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (137,'Mineral_Dictionary','ROCW','Rock Wool',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (138,'Mineral_Dictionary','ROST','Roadstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (139,'Mineral_Dictionary','SAGR','Sand And Gravel',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (140,'Mineral_Dictionary','SBI','Slateyband Ironstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (141,'Mineral_Dictionary','SDST','Sandstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (142,'Mineral_Dictionary','SEAC','Seatclay',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (143,'Mineral_Dictionary','SEAT','Seatearth',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (144,'Mineral_Dictionary','SHAL','Shale',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (145,'Mineral_Dictionary','SIDR','Siderite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (146,'Mineral_Dictionary','SILI','Silica Sand',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (147,'Mineral_Dictionary','SILR','Silica Rock',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (148,'Mineral_Dictionary','SILV','Silver',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (149,'Mineral_Dictionary','SLAT','Slate',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (150,'Mineral_Dictionary','SOAP','Soapstone',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (151,'Mineral_Dictionary','SPRO','Sphaerosiderite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (152,'Mineral_Dictionary','SYLV','Sylvine',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (153,'Mineral_Dictionary','TALC','Talc',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (154,'Mineral_Dictionary','TIN','Tin',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (155,'Mineral_Dictionary','TITA','Titanium',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (156,'Mineral_Dictionary','URAN','Uranium',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (157,'Mineral_Dictionary','VERM','Vermiculite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (158,'Mineral_Dictionary','WATR','Water',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (159,'Mineral_Dictionary','WITH','Witherite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (160,'Mineral_Dictionary','WOLF','Wolfram',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (161,'Mineral_Dictionary','WOLL','Wollastonite',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (162,'Mineral_Dictionary','ZINC','Zinc',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_secondary" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (163,'Mineral_Dictionary','ZIRC','Zircon',NULL,'C','kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_third" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'Deformation_Phase','Phase-D0','0 - Primary Syndepositional/Syn Sedimentary',NULL,NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_third" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'Deformation_Phase','Phase-D1','1',NULL,NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_third" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'Deformation_Phase','Phase-D2','2',NULL,NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_third" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'Deformation_Phase','Phase-D3','3',NULL,NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_third" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'Deformation_Phase','Phase-D4','4',NULL,NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_third" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'Deformation_Phase','Phase-D5','5',NULL,NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_third" ("fid","category","code","description","translation","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'Deformation_Phase','Phase-D6','6',NULL,NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (1,'Bedding','Strata_Inclined_1','Inclined 1','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (2,'Bedding','Strata_Inclined_2','Inclined 2','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (3,'Bedding','Strata_Horizontal','Horizontal','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (4,'Bedding','Strata_Vertical','Vertical','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (5,'Bedding','Strata_General_Dip','General Dip','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (6,'Bedding','Strata_Overturned_Inclined','Overturned Inclined','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (7,'Bedding','Strata_Overturned_Horizontal','Overturned Horizontal','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (8,'Bedding','Strata_Way_Up_Unknown_Inclined','Way Up Unknown Inclined','',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (9,'Bedding','Strata_Way_Up_Unknown_Horizontal','Way Up Unknown Horizontal','',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (10,'Bedding','Strata_Inclined_Underground','UG Inclined','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (11,'Bedding','Strata_General_Dip_Underground','UG General','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (12,'Bedding','Strata_Cross_Bedding_Foresets','Cross Bedding','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (13,'Bedding','Strata_Geopetal_Infill_Surface','Geopetal','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (14,'Fault','Fault_Plane_Dip','Fault Dip',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (15,'Fault','Fault_Scissor_Point','Scissor Point',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (16,'Fault','Joint_Inclined','Joint Inclined',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (17,'Fault','Joint_Horizontal','Joint Horizontal',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (18,'Fault','Joint_Vertical','Joint Vertical',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (19,'Younging','Younging_Direction','Younging Direction','Younging_Evidence',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (20,'Facing','Facing_Direction','Facing Direction','Younging_Evidence','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (21,'Vergence','Vergence_Direction','Vergence Direction',NULL,'',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (22,'Vergence','Vergence_Dextral','Vergence Dextral',NULL,'',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (23,'Vergence','Vergence_Sinistral','Vergence Sinistral',NULL,'',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (24,'Vergence','Vergence_Neutral','Vergence Neutral',NULL,'',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (25,'Mineral_Vein','Mineral_Vein_dip','Mineral Vein Dip','Mineral_Dictionary',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (26,'Axial _Plane','Axial_Plane_Inclined','Axial Plane Inclined','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (27,'Axial _Plane','Axial_Plane_Horizontal','Axial Plane Horizontal','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (28,'Axial _Plane','Axial_Plane_Vertical','Axial Plane Vertical','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (29,'Fold_Axis','Fold_Axis','Fold Axis Horizontal','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (30,'Fold_Axis','Fold_Axis_Horizontal','Fold Axis Inclined','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (31,'Fold_Axis','Fold_Axis_Vertical','Fold Axis Vertical','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (32,'Fold_Axis','Syncline_Axis','Syncline Axis','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (33,'Fold_Axis','Syncline_Axis_Horizontal','Syncline Axis Horizontal','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (34,'Fold_Axis','Anticline_Axis','Anticline Axis','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (35,'Fold_Axis','Anticline_Axis_Horizontal','Anticline Axis Horizontal','Fold_Shape','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (36,'Foliation','Foliation_Penetrative_Inclined','Foliation Penetrative Inclined','Foliation_Penetrative','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (37,'Foliation','Foliation_Penetrative_Horizontal','Foliation Penetrative Horizontal','Foliation_Penetrative','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (38,'Foliation','Foliation_Penetrative_Vertical','Foliation Penetrative Vertical','Foliation_Penetrative','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (39,'Foliation','Foliation_Spaced_Inclined','Foliation Spaced Inclined','Foliation_Spaced','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (40,'Foliation','Foliation_Spaced_Horizontal','Foliation Spaced Horizontal','Foliation_Spaced','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (41,'Foliation','Foliation_Spaced_Vertical','Foliation Spaced Vertical','Foliation_Spaced','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (42,'Foliation','Foliation_Compositional_Inclined','Foliation Compositional Inclined','Foliation_Compositional','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (43,'Foliation','Foliation_Compositional_Horizontal','Foliation Compositional Horizontal','Foliation_Compositional','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (44,'Foliation','Foliation_Compositional_Vertical','Foliation Compositional Vertical','Foliation_Compositional','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (45,'Foliation','Foliation_Shear_Inclined','Foliation Shear Inclined','Foliation_Shear','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (46,'Foliation','Foliation_Shear_Horizontal','Foliation Shear Horizontal','Foliation_Shear','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (47,'Foliation','Foliation_Shear_Vertical','Foliation Shear Vertical','Foliation_Shear','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (48,'Lineation','Lineation_Plunging','Lineation Plunging','Lineation','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (49,'Lineation','Lineation_Horizontal','Lineation Horizontal','Lineation','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (50,'Lineation','Lineation_Vertical','Lineation Vertical','Lineation','Deformation_Phase',NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (51,'Igneous','Igneous_Contact_Dip','Igneous Contact Dip','Igneous_Contact',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (52,'Igneous','Igneous_Trough_Axis','Igneous Trough Axis',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (53,'Igneous','Igneous_Extrusive_Planar_Fabric_Inclined','Ign Extrusive Planar Fabric Inclined','Igneous_Extrusive',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (54,'Igneous','Igneous_Extrusive_Planar_Fabric_Horizontal','Ign Extrusive Planar Fabric Horizontal','Igneous_Extrusive',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (55,'Igneous','Igneous_Extrusive_Planar_Fabric_Vertical','Ign Extrusive Planar Fabric Vertical','Igneous_Extrusive',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (56,'Igneous','Igneous_Planar_Fabric_Inclined','Ign Planar Fabric Inclined','Igneous_Planar',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (57,'Igneous','Igneous_Planar_Fabric_Horizontal','Ign Planar Fabric Horizontal','Igneous_Planar',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (58,'Igneous','Igneous_Planar_Fabric_Vertical','Ign Planar Fabric Vertical','Igneous_Planar',NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (59,'Igneous','Igneous_Crystal_Alignment_Inclined','Crystal Allignment Inclined',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (60,'Igneous','Igneous_Crystal_Alignment_Horizontal','Crystal Allignment Horizontal',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_structure_code" ("fid","category","code","description","secondary_attribute","third_attribute","fourth_attribute","status","translation","user_entered","date_entered","user_updated","date_updated") VALUES (61,'Igneous','Igneous_Crystal_Alignment_Vertical','Crystal Allignment Vertical',NULL,NULL,NULL,'C',NULL,'kigl','01/01/2012','jbow','05/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (1,'ERRATIC','SL_E_ERRAT','Erratic','erratic','C','ERR','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (2,'GLACIAL','SL_GL_CGT','Crag and tail','crag_and_tail','C','CRAGTAIL','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (3,'GLACIAL','SL_GL_DRUM','Drumlin','drumlin','C','DRUM','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (4,'GLACIAL','SL_GL_GLST','Glacial striae','glacial_striae','C','GLSTR','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (5,'GLACIAL','SL_GL_GLSTD','Glacial striae directional','glacial_striae_directional','C','GLSTD','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (6,'GLACIAL','SL_GL_IMB','Ice moulded bedrock','ice_moulded_bedrock','C','ICEMOBED','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (7,'GLACIAL','SL_GL_KH','Kettle hollow','kettle_hollow','C','KETHOL','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (8,'GLACIAL','SL_GL_MM','Moraine mound','moriane_mound','C','MORMOUN','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (9,'GLACIAL','SL_GL_NH','Nivation hollow','nivation_hollow','C','NIVHOL','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (10,'GLACIAL','SL_GL_PF','P-form','p_form','C','PF','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (11,'GLACIAL','SL_GL_RM','Roche moutonnee','roche_moutonnee','C','ROMOU','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (12,'GLACIAL','SL_GL_RMS','Roche moutonnee striae','roche_moutonnee_striae','C','ROMOUST','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (13,'GLACIAL','SL_GL_SF','S-form','s_form','C','SF','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (14,'GLACIAL','SL_GL_WB','Whaleback','whaleback','C','WHALE','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (15,'GLACIAL','SL_GL_WBD','Whaleback directional','whaleback_directional','C','WHALDIR','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (16,'GLACIOTECTONIC','SL_GT_GTIF','Glaciotectonic ice flow','glaciotectonic_ice_flow','C','GLTECICE','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (17,'GLACIOTECTONIC','SL_GT_GTIFD','Glaciotectonic ice flow directional','glaciotectonic_ice_flow_directional','C','GLTECICED','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (18,'GLACIOTECTONIC','SL_GT_GTIFU','Glaciotectonic no orientation','glaciotectonic_unoriented','C','GLTECNO','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (19,'KARST','SL_K_CAV','Cavity entrance natural','cavity_entrance_natural','C','CAV','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (20,'KARST','SL_K_SWH','Doline or sinkhole','doline_sinkhole','C','DO','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (21,'KARST','SL_K_SPR','Spring','spring','C','SPR','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (22,'KARST','SL_K_SS','Stream sink','stream_sink','C','STRSIN','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (23,'PERIGLACIAL','SL_P_IWC','Ice wedge cast','ice_wedge_cast','C','ICEWC','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (24,'PERIGLACIAL','SL_P_PG','Patterned ground','patterned_ground','C','PATG','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (25,'PERIGLACIAL','SL_P_PIN','Pingo','pingo','C','PIN','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (26,'PERIGLACIAL','SL_P_TOR','Tor','tor','C','TO','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (27,'TOPOGRAPHIC_FEATURE','SL_TF_COL','Col','col','C','COL','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (28,'TOPOGRAPHIC_FEATURE','SL_TF_DUNE','Dune','dune','C','DU','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (29,'TOPOGRAPHIC_FEATURE','SL_TF_HPM','High point mound','high_point_mound','C','HPM','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (30,'TOPOGRAPHIC_FEATURE','SL_TF_LPH','Low point hollow','low_point_hollow','C','LPH','kigl','01/01/2012','jbow','13/09/2023');
INSERT INTO "dic_superficial_code" ("fid","category","code","description","translation","status","archived_code","user_entered","date_entered","user_updated","date_updated") VALUES (31,'TOPOGRAPHIC_FEATURE','SL_TF_SH','Subsidence hollow','subsidence_hollow','C','SUBHOL','kigl','01/01/2012','jbow','13/09/2023');
COMMIT;
