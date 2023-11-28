-- Dictionaries used to constrain line features.
BEGIN TRANSACTION;

CREATE TABLE "dic_line_theme_cat" (
	"fid"	INTEGER NOT NULL,
	"code"  TEXT NOT NULL UNIQUE,
	"theme"	TEXT NOT NULL,
    "category" TEXT,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_theme_cat','attributes','dic_line_theme_cat','Dictionary of line themes and categories','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_mineral" (
	"fid"	INTEGER NOT NULL,
	"code" TEXT NOT NULL UNIQUE,
	"category" TEXT,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_mineral','attributes','dic_mineral','Dictionary of minerals','2023-09-15t13:21:52.679z',null,null,null,null,null);


CREATE TABLE "dic_mineral_vein" (
	"fid"	INTEGER NOT NULL,
	"code" TEXT NOT NULL UNIQUE,
	"category" TEXT,
	"description"	TEXT,
	"translation"	TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_mineral_vein','attributes','dic_mineral_vein','Dictionary of materials found in veins','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_artificial" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"category" TEXT,
	"description"	TEXT,
	"translation"	TEXT,
	"sec_attrib_list"  TEXT,
    "comments" TEXT,
    "status"	TEXT,
 	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_artificial','attributes','dic_line_type_artificial','Dictionary of artificial line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_bedrock" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"category" TEXT,
    "description"	TEXT,
	"translation"	TEXT,
	"sec_attrib_list"  TEXT,
    "comments" TEXT,
    "status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_bedrock','attributes','dic_line_type_bedrock','Dictionary of bedrock line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_superficial" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"category" TEXT,
	"description"	TEXT,
	"translation"	TEXT,
    "comments" TEXT,
	"status"	TEXT,
    "sec_attrib_list"  TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_superficial','attributes','dic_line_type_superficial','Dictionary of superficial line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_mass_move" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
	"category" TEXT,
	"description"	TEXT,
	"translation"	TEXT,
	"sec_attrib_list"  TEXT,
    "comments" TEXT,
	"status"	TEXT,
	"user_entered"	TEXT NOT NULL,
	"date_entered"	DATETIME NOT NULL,
	"user_updated"	TEXT,
	"date_updated"	DATETIME,
	PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_mass_move','attributes','dic_line_type_mass_move','Dictionary of mass movement line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'algal_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'ash_band_tonstein','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'base_of_lava_flow','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'bedrock_geology_boundary_grad','BEDROCK_BOUNDARY',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:52:25',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'bedrock_geology_boundary_inf','BEDROCK_BOUNDARY',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:52:51',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'bedrock_geology_boundary_obs','BEDROCK_BOUNDARY',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:52:51',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'bedrock_offshore_closure','BEDROCK_BOUNDARY',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 15:51:03',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (8,'bedrock_polygon_closure','BEDROCK_BOUNDARY',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:52:51',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (9,'bone_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (10,'brachiopod_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (11,'cementstone_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (12,'coal_seam_inf','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (13,'coal_seam_obs','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (14,'coral_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (15,'ductile_shear_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (16,'ductile_shear_obs','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (17,'dyke_linear_inf','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (18,'dyke_linear_obs','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (19,'euestheria_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (20,'fault_complex_movenent_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (21,'fault_complex_movenent_obs','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (22,'fault_dextral_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:52:51',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (23,'fault_dextral_obs','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (24,'fault_inf_crossmark_on_downthrow_side','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (25,'fault_inf_throw_unknown','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (26,'fault_normal_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (27,'fault_normal_obs','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (28,'fault_obs_crossmark_on_downthrow_side','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (29,'fault_obs_throw_unknown','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (30,'fault_reverse_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (31,'fault_reverse_obs','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (32,'fault_sinistral_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (33,'fault_sinistral_obs','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (34,'fault_syn-sedimentary_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (35,'fault_thrust_inf_','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (36,'fault_thrust_obs','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (37,'fault_undifferentiated_inf','FAULT_TRACE',NULL,NULL,'hanging wall direction, name','check for left hand rule and alter if necessary','C','KIGL','21/11/2023 14:55:04',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (38,'fish_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (39,'fold_anticline','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:55:44',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (40,'fold_anticline_syncline_pair','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (41,'fold_antiform','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (42,'fold_antiform_synform_pair','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (43,'fold_monocline_lower','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (44,'fold_monocline_upper','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (45,'fold_syncline','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (46,'fold_synform','FOLD_AXIAL_PLANE_TRACE',NULL,NULL,'none',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (47,'goniatite_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (48,'gypsum_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (49,'ironstone_bed_inf','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (50,'ironstone_bed_obs','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together),Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (51,'limestone_nodule_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (52,'limit_area_of_reddening','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (53,'limit_diorite_granodiorite','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (54,'limit_dolomitisation','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (55,'limit_gran_peg_vein','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (56,'limit_granite_vein','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (57,'limit_halite','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 15:01:11',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (58,'limit_hydrothermal_alteration','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (59,'limit_metamorphic_aureole','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (60,'limit_metamorphic_zone','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (61,'limit_migmatisation','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (62,'limit_pegmatite','ALTERATION_BOUNDARY',NULL,NULL,'mineral, asymmetry ticks,',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (63,'lingula_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS, (or ? LEX_RCS together),Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (64,'lithostrat_line_other_inf','BEDROCK_LINE',NULL,NULL,NULL,NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (65,'lithostrat_line_other_obs','BEDROCK_LINE',NULL,NULL,NULL,NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (66,'magnetic_layer','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (67,'manganese_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (68,'marine_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (69,'mineral_vein_inf','MINERAL_VEIN_TRACE',NULL,NULL,'mineral01, mineral02, mineral03, mineral04',NULL,'C','KIGL','21/11/2023 15:01:11',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (70,'mineral_vein_obs','MINERAL_VEIN_TRACE',NULL,NULL,'mineral01, mineral02, mineral03, mineral04',NULL,'C','KIGL','21/11/2023 14:56:26',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (71,'mussel_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (72,'oil_shale_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (73,'planolites_band','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together), Younging',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (74,'sandstone_bed','BEDROCK_LINE',NULL,NULL,'LEX, RCS (or ? LEX_RCS together)',NULL,'C','KIGL','21/11/2023 14:47:49',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (75,'zone_cataclasis_inf','ALTERATION_BOUNDARY',NULL,NULL,'?',NULL,'C','KIGL','21/11/2023 15:45:39',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (76,'zone_cataclasis_obs','ALTERATION_BOUNDARY',NULL,NULL,'?',NULL,'C','KIGL','21/11/2023 15:48:57',NULL,NULL);
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (77,'zone_sheared_rock','ALTERATION_BOUNDARY',NULL,NULL,'?',NULL,'C','KIGL','21/11/2023 14:50:19',NULL,NULL);
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'artificial_geology_boundary','ARTIFICIAL_GROUND_BOUNDARY',NULL,NULL,'none yet',NULL,'C','KIGL','26/11/2023 12:16:00',NULL,NULL);
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'artificial_polygon_closure','ARTIFICIAL_GROUND_BOUNDARY',NULL,NULL,'none yet',NULL,'C','KIGL','26/11/2023 12:17:38',NULL,NULL);
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'cliffline_quarry','ARTIFICIAL_GROUND_LINE',NULL,NULL,'none yet',NULL,'C','KIGL','26/11/2023 12:17:38',NULL,NULL);
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'limit_subsurface_mining','ARTIFICIAL_GROUND_LINE',NULL,NULL,'none yet',NULL,'C','KIGL','26/11/2023 12:17:38',NULL,NULL);
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'mine_tunnel_drift_cross_measures','ARTIFICIAL_GROUND_LINE',NULL,NULL,'none yet',NULL,'C','KIGL','26/11/2023 12:17:38',NULL,NULL);
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'mine_tunnel_road_in seam','ARTIFICIAL_GROUND_LINE',NULL,NULL,'none yet',NULL,'C','KIGL','26/11/2023 12:17:38',NULL,NULL);
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'small_quarry_or_pit','ARTIFICIAL_GROUND_LINE',NULL,NULL,'none yet',NULL,'C','KIGL','26/11/2023 12:17:38',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (1,'air_photo_lineament','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'CHECK','C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (2,'axis_of_glacial_flute','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (3,'axis_of_large_scale_glacial_gouge','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (4,'axis_of_megagroove','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (5,'axis_of_swale','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (6,'backfeature_Former_coast','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'arrowheads denote uphill side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (7,'backfeature_Lake_margin','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'arrowheads denote uphill side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (8,'backfeature_terrace','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'arrowheads denote uphill side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (9,'beach_ridge','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'check','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (10,'buried_channel_centre','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (11,'buried_channel_margin','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'beads to outside','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (12,'cliffline_buried','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'crossmarks on the eroded side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (13,'cliffline_natural','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'crossmarks on the eroded side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (14,'crag_and_tail','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (15,'doline_or_karstic_hollow','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (16,'drumlin_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (17,'drumlin_line_at_base','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (18,'dune_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (19,'dune_line_at_base','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (20,'elongate_mound_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (21,'esker_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (22,'esker_line_at_base','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (23,'form_line','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear, asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (24,'form_line_indicating_slope','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear, asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (25,'glacial_meltwater_channel_centre_undiff','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (26,'glacial_meltwater_channel_margin','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (27,'glacial_overflow_channel_centre','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (28,'hollow','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (29,'ice_contact_slope','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'CHECK hachure on upslope','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (30,'ice_marg_glacial_meltwater_channel_Left','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'barb on opposite side to ice, towards carved terrain','C','asymmetry linear, asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (31,'ice_marg_glacial_meltwater_channel_Right','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'barb on opposite side to ice, towards carved terrain','C','asymmetry linear, asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (32,'kettle_hole','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (33,'limestone_fissures','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear, asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (34,'linear_negative_feature','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (35,'linear_positive_Feature_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (36,'margin_of_erratic_train','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (37,'marked_concave_break_of_slope','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'arrowheads denote uphill side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (38,'marked_convex_break_of_slope','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'arrowheads denote downhill side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (39,'moraine_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'ticks on former ice sheet side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (40,'mound_line_at_base','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (41,'outer_edge_of_terrace','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'arrowheads denote uphill side','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (42,'palaeochannel','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (43,'roche_moutonee_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'arrow denotes flow of ice','C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (44,'rogen_line_at_base','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'form line at base','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (45,'rogen_moraine_crestline','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (46,'sea_bank','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (47,'solifluction_lobe','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (48,'stream_sink_line','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (49,'sub-glacial_meltwater_channel_centre','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'CHECK ?direction of flow','C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (50,'subsidence_hollow','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (51,'superficial_filled_hollow','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C',NULL,'KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (52,'thrust_in_superficial_Inf','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,'barbs within mass','C','asymmetry perpendicular to line','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (53,'tunnel_valley_centre','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list","user_entered","date_entered","user_updated","date_updated") VALUES (54,'tunnel_valley_margin','LINEAR_LANDFORM_OR_BEDFORM',NULL,NULL,NULL,'C','asymmetry linear','KIGL','26/11/2023 11:47:04',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (1,'gull','MASS_MOVEMENT_LINE',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (2,'landslide_back_scar_Top','MASS_MOVEMENT_LINE',NULL,NULL,'asymmetry perendicular','barbs point into landslide','C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (3,'landslide_lower_or_side_limit','MASS_MOVEMENT_LINE',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (4,'landslide_minor_scarps','MASS_MOVEMENT_LINE',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (5,'mass_move_geology_boundary','MASS_MOVEMENT_DEPOSIT_BOUNDARY',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (6,'mass_move_polygon_closure','MASS_MOVEMENT_DEPOSIT_BOUNDARY',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (7,'open_tension_crack_crossmark','MASS_MOVEMENT_LINE',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (8,'open_tension_crack_undiff','MASS_MOVEMENT_LINE',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status","user_entered","date_entered","user_updated","date_updated") VALUES (9,'valley_bulge_axis_Inf','MASS_MOVEMENT_LINE',NULL,NULL,NULL,NULL,'C','KIGL','26/11/2023 12:12:31',NULL,NULL);
COMMIT;