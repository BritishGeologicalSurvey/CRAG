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
	"code"	TEXT NOT NULL UNIQUE,
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

CREATE TABLE IF NOT EXISTS "dic_structure_category" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE UNIQUE,
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
