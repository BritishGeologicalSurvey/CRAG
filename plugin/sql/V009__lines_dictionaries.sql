-- Dictionaries used to constrain line features.
BEGIN TRANSACTION;

CREATE TABLE "dic_line_type_artificial" (
    "fid" INTEGER NOT NULL,
    "code" TEXT NOT NULL UNIQUE CHECK(LENGTH("code") <= 50),
    "category" TEXT CHECK(LENGTH("category") <= 50),
    "description" TEXT CHECK(LENGTH("description") <= 255),
    "translation" TEXT CHECK(LENGTH("translation") <= 255),
    "sec_attrib_list" TEXT CHECK(LENGTH("sec_attrib_list") <= 255),
    "comments" TEXT CHECK(LENGTH("comments") <= 255),
    "status" TEXT CHECK(LENGTH("status") <= 50),
    PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_artificial','attributes','dic_line_type_artificial','Dictionary of artificial line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_bedrock" (
    "fid" INTEGER NOT NULL,
    "code" TEXT NOT NULL UNIQUE CHECK(LENGTH("code") <= 50),
    "category" TEXT CHECK(LENGTH("category") <= 50),
    "description" TEXT CHECK(LENGTH("description") <= 255),
    "translation" TEXT CHECK(LENGTH("translation") <= 255),
    "sec_attrib_list" TEXT CHECK(LENGTH("sec_attrib_list") <= 255),
    "comments" TEXT CHECK(LENGTH("comments") <= 255),
    "status" TEXT CHECK(LENGTH("status") <= 50),
    PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_bedrock','attributes','dic_line_type_bedrock','Dictionary of bedrock line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_superficial" (
    "fid" INTEGER NOT NULL,
    "code" TEXT NOT NULL UNIQUE CHECK(LENGTH("code") <= 50),
    "category" TEXT CHECK(LENGTH("category") <= 50),
    "description" TEXT CHECK(LENGTH("description") <= 255),
    "translation" TEXT CHECK(LENGTH("translation") <= 255),
    "comments" TEXT CHECK(LENGTH("comments") <= 255),
    "status" TEXT CHECK(LENGTH("status") <= 50),
    "sec_attrib_list" TEXT CHECK(LENGTH("sec_attrib_list") <= 255),
    PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_superficial','attributes','dic_line_type_superficial','Dictionary of superficial line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_mass_move" (
    "fid" INTEGER NOT NULL,
    "code" TEXT NOT NULL UNIQUE CHECK(LENGTH("code") <= 50),
    "category" TEXT CHECK(LENGTH("category") <= 50),
    "description" TEXT CHECK(LENGTH("description") <= 255),
    "translation" TEXT CHECK(LENGTH("translation") <= 255),
    "sec_attrib_list" TEXT CHECK(LENGTH("sec_attrib_list") <= 255),
    "comments" TEXT CHECK(LENGTH("comments") <= 255),
    "status" TEXT CHECK(LENGTH("status") <= 50),
    PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_mass_move','attributes','dic_line_type_mass_move','Dictionary of mass movement line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_terrain" (
    "fid" INTEGER NOT NULL,
    "code" TEXT NOT NULL UNIQUE CHECK(LENGTH("code") <= 50),
    "category" TEXT CHECK(LENGTH("category") <= 50),
    "description" TEXT CHECK(LENGTH("description") <= 255),
    "translation" TEXT CHECK(LENGTH("translation") <= 255),
    "sec_attrib_list" TEXT CHECK(LENGTH("sec_attrib_list") <= 255),
    "comments" TEXT CHECK(LENGTH("comments") <= 255),
    "status" TEXT CHECK(LENGTH("status") <= 50),
    PRIMARY KEY("fid" AUTOINCREMENT)
);

insert into gpkg_contents
values('dic_line_type_terrain','attributes','dic_line_type_terrain','Dictionary of terrain line types','2023-09-15t13:21:52.679z',null,null,null,null,null);

INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (1,'artificial_geology_boundary','ARTIFICIAL_GROUND_BOUNDARY','artificial_geology_boundary',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (2,'artificial_polygon_closure','ARTIFICIAL_GROUND_BOUNDARY','artificial_polygon_closure',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (3,'cliffline_quarry','ARTIFICIAL_GROUND_LINE','cliffline_quarry',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (4,'limit_subsurface_mining','ARTIFICIAL_GROUND_LINE_UNDERGROUND','limit_subsurface_mining',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (5,'mine_tunnel_drift_cross_measures','ARTIFICIAL_GROUND_LINE_UNDERGROUND','mine_tunnel_drift_cross_measures',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (6,'mine_tunnel_road_in_seam','ARTIFICIAL_GROUND_LINE_UNDERGROUND','mine_tunnel_road_in_seam',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_artificial" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (7,'small_quarry_or_pit','ARTIFICIAL_GROUND_LINE','small_quarry_or_pit',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (1,'algal_band','BEDROCK_HORIZON','algal_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (2,'ash_band_tonstein','BEDROCK_HORIZON','ash_band_tonstein',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (3,'base_of_lava_flow','BEDROCK_HORIZON','base_of_lava_flow',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (4,'bedrock_geology_boundary_grad','BEDROCK_BOUNDARY','bedrock_geology_boundary_grad',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (5,'bedrock_geology_boundary_inf','BEDROCK_BOUNDARY','bedrock_geology_boundary_inf',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (6,'bedrock_geology_boundary_obs','BEDROCK_BOUNDARY','bedrock_geology_boundary_obs',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (7,'bedrock_offshore_closure','BEDROCK_BOUNDARY','bedrock_offshore_closure',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (8,'bedrock_polygon_closure','BEDROCK_BOUNDARY','bedrock_polygon_closure',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (9,'bone_bed','BEDROCK_HORIZON','bone_bed',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (10,'brachiopod_band','BEDROCK_HORIZON','brachiopod_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (11,'cementstone_bed','BEDROCK_HORIZON','cementstone_bed',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (12,'coal_seam_inf','BEDROCK_HORIZON','coal_seam_inf',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (13,'coal_seam_obs','BEDROCK_HORIZON','coal_seam_obs',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (14,'coral_band','BEDROCK_HORIZON','coral_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (15,'ductile_shear_inf','FAULT_TRACE','ductile_shear_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (16,'ductile_shear_obs','FAULT_TRACE','ductile_shear_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (17,'dyke_inf','DYKE','dyke_inf',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (18,'dyke_obs','DYKE','dyke_obs',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (19,'euestheria_band','BEDROCK_HORIZON','euestheria_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (20,'fault_complex_movement_inf','FAULT_TRACE','fault_complex_movement_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (21,'fault_complex_movement_obs','FAULT_TRACE','fault_complex_movement_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (22,'fault_dextral_inf','FAULT_TRACE','fault_dextral_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (23,'fault_dextral_obs','FAULT_TRACE','fault_dextral_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (24,'fault_crossmark_downthrow_side_inf','FAULT_TRACE','fault_crossmark_downthrow_side_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (25,'fault_throw_unknown_inf','FAULT_TRACE','fault_throw_unknown_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (26,'fault_normal_inf','FAULT_TRACE','fault_normal_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (27,'fault_normal_obs','FAULT_TRACE','fault_normal_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (28,'fault_crossmark_downthrow_side_obs','FAULT_TRACE','fault_crossmark_downthrow_side_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (29,'fault_throw_unknown_obs','FAULT_TRACE','fault_throw_unknown_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (30,'fault_reverse_inf','FAULT_TRACE','fault_reverse_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (31,'fault_reverse_obs','FAULT_TRACE','fault_reverse_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (32,'fault_sinistral_inf','FAULT_TRACE','fault_sinistral_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (33,'fault_sinistral_obs','FAULT_TRACE','fault_sinistral_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (34,'fault_syn-sedimentary_inf','FAULT_TRACE','fault_syn-sedimentary_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (35,'fault_thrust_inf','FAULT_TRACE','fault_thrust_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (36,'fault_thrust_obs','FAULT_TRACE','fault_thrust_obs',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (37,'fault_undifferentiated_inf','FAULT_TRACE','fault_undifferentiated_inf',NULL,'Hanging wall direction; Name','Check for left hand rule and alter if necessary.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (38,'fish_bed','BEDROCK_HORIZON','fish_bed',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (39,'anticline','FOLD_TRACE','fold_anticline',NULL,'Deformation phase; Name',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (40,'anticline_syncline_pair','FOLD_TRACE','fold_anticline_syncline_pair',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (41,'antiform','FOLD_TRACE','fold_antiform',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (42,'antiform_synform_pair','FOLD_TRACE','fold_antiform_synform_pair',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (43,'monocline_lower','FOLD_TRACE','fold_monocline_lower',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (44,'monocline_upper','FOLD_TRACE','fold_monocline_upper',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (45,'syncline','FOLD_TRACE','fold_syncline',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (46,'synform','FOLD_TRACE','fold_synform',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (47,'goniatite_band','BEDROCK_HORIZON','goniatite_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (48,'gypsum_bed','BEDROCK_HORIZON','gypsum_bed',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (49,'ironstone_bed_inf','BEDROCK_HORIZON','ironstone_bed_inf',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (50,'ironstone_bed_obs','BEDROCK_HORIZON','ironstone_bed_obs',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (51,'limestone_nodule_bed','BEDROCK_HORIZON','limestone_nodule_bed',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (52,'limit_area_of_reddening','ALTERATION_BOUNDARY','limit_area_of_reddening',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (53,'limit_diorite_granodiorite','ALTERATION_BOUNDARY','limit_diorite_granodiorite',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (54,'limit_dolomitisation','ALTERATION_BOUNDARY','limit_dolomitisation',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (55,'limit_gran_pegmatite_vein','ALTERATION_BOUNDARY','limit_gran_pegmatite_vein',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (56,'limit_granite_vein','ALTERATION_BOUNDARY','limit_granite_vein',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (57,'limit_halite','ALTERATION_BOUNDARY','limit_halite',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (58,'limit_hydrothermal_alteration','ALTERATION_BOUNDARY','limit_hydrothermal_alteration',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (59,'limit_metamorphic_aureole','ALTERATION_BOUNDARY','limit_metamorphic_aureole',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (60,'limit_metamorphic_zone','ALTERATION_BOUNDARY','limit_metamorphic_zone',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (61,'limit_migmatisation','ALTERATION_BOUNDARY','limit_migmatisation',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (62,'limit_pegmatite','ALTERATION_BOUNDARY','limit_pegmatite',NULL,'Mineral; Asymmetry ticks',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (63,'lingula_band','BEDROCK_HORIZON','lingula_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (64,'lithostrat_line_other_inf','BEDROCK_HORIZON','lithostrat_line_other_inf',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (65,'lithostrat_line_other_obs','BEDROCK_HORIZON','lithostrat_line_other_obs',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (66,'magnetic_layer','BEDROCK_HORIZON','magnetic_layer',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (67,'manganese_bed','BEDROCK_HORIZON','manganese_bed',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (68,'marine_band','BEDROCK_HORIZON','marine_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (69,'mineral_vein_inf','MINERAL_VEIN_TRACE','mineral_vein_inf',NULL,'Mineral01; Mineral02; Mineral03; Mineral04',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (70,'mineral_vein_obs','MINERAL_VEIN_TRACE','mineral_vein_obs',NULL,'Mineral01; Mineral02; Mineral03; Mineral04',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (71,'mussel_band','BEDROCK_HORIZON','mussel_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (72,'oil_shale_bed','BEDROCK_HORIZON','oil_shale_bed',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (73,'planolites_band','BEDROCK_HORIZON','planolites_band',NULL,'Rock unit (LEX); Rock type (RCS); Younging direction',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (74,'sandstone_bed','BEDROCK_HORIZON','sandstone_bed',NULL,'Rock unit (LEX); Rock type (RCS)',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (75,'limit_zone_cataclasis','ALTERATION_BOUNDARY','limit_zone_cataclasis',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (77,'limit_zone_sheared_rock','ALTERATION_BOUNDARY','limit_zone_sheared_rock',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (78,'bedrock_geology_boundary_conj','BEDROCK_BOUNDARY','bedrock_geology_boundary_conj',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (79,'bedrock_boundary_underground','BEDROCK_HORIZON_UNDERGROUND','bedrock_boundary_underground',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (80,'incrop_coal','BEDROCK_HORIZON_UNDERGROUND','incrop_coal',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (81,'incrop_marine_band','BEDROCK_HORIZON_UNDERGROUND','incrop_marine_band',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (82,'bedrock_boundary_subpermian','BEDROCK_HORIZON_UNDERGROUND','bedrock_boundary_subpermian',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (83,'coal_boundary_subpermian','BEDROCK_HORIZON_UNDERGROUND','coal_boundary_subpermian',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (84,'coal_subtriassic','BEDROCK_HORIZON_UNDERGROUND','coal_subtriassic',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (85,'washout_in_coalseam','BEDROCK_HORIZON_UNDERGROUND','washout_in_coalseam',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (86,'dyke_inf_underground','DYKE_UNDERGROUND','dyke_inf_underground',NULL,'Rock unit (LEX); Rock type (RCS)','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (87,'fault_conjectural','FAULT_TRACE','fault_conjectural',NULL,'Name',NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (88,'incrop_fault','FAULT_TRACE_UNDERGROUND','incrop_fault',NULL,'Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (89,'subpermian_fault_inf','FAULT_TRACE_UNDERGROUND','subpermian_fault_inf',NULL,'Hanging wall direction; Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (90,'subtriassic_fault_inf','FAULT_TRACE_UNDERGROUND','subtriassic_fault_inf',NULL,'Hanging wall direction; Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (91,'fault_inf_underground','FAULT_TRACE_UNDERGROUND','fault_inf_underground',NULL,'Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (92,'fault_crossmark_downthrow_side_inf_underground','FAULT_TRACE_UNDERGROUND','fault_crossmark_downthrow_side_inf_underground',NULL,'Hanging wall direction; Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (93,'fault_throw_unknown_inf_underground','FAULT_TRACE_UNDERGROUND','fault_throw_unknown_inf_underground',NULL,'Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (94,'fault_obs_underground','FAULT_TRACE_UNDERGROUND','fault_obs_underground',NULL,'Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (95,'fault_crossmark_downthrow_side_obs_underground','FAULT_TRACE_UNDERGROUND','fault_crossmark_downthrow_side_obs_underground',NULL,'Hanging wall direction; Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (96,'fault_obs_downthrow_unspecified_obs_underground','FAULT_TRACE_UNDERGROUND','fault_obs_downthrow_unspecified_obs_underground',NULL,'Hanging wall direction; Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (97,'fracture_inf','FRACTURE_TRACE','fracture_inf',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (98,'fracture_obs','FRACTURE_TRACE','fracture_obs',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (99,'anticline_underground','FOLD_TRACE_UNDERGROUND','anticline_underground',NULL,'Deformation phase; Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (100,'syncline_underground','FOLD_TRACE_UNDERGROUND','syncline_underground',NULL,'Deformation phase; Name','Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (101,'mineral_vein_obs_underground','MINERAL_VEIN_TRACE_UNDERGROUND','mineral_vein_obs_underground',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (102,'mineral_vein_inf_underground','MINERAL_VEIN_TRACE_UNDERGROUND','mineral_vein_inf_underground',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (103,'unconformity_major','UNCONFORMITY','unconformity_major',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_bedrock" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (104,'unconformity_minor','UNCONFORMITY','unconformity_minor',NULL,NULL,'Not used in field.','C');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (1,'axis_of_glacial_flute','GLACIAL_LANDFORM','axis_of_glacial_flute',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (2,'axis_of_large_scale_glacial_gouge','GLACIAL_LANDFORM','axis_of_large_scale_glacial_gouge',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (3,'axis_of_megagroove','GLACIAL_LANDFORM','axis_of_megagroove',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (4,'axis_of_swale','GLACIAL_LANDFORM','axis_of_swale',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (5,'backfeature_former_coast','LANDFORM_GENERAL','backfeature_former_coast',NULL,'Arrowheads denote uphill side.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (6,'backfeature_lake_margin','LANDFORM_GENERAL','backfeature_lake_margin',NULL,'Arrowheads denote uphill side.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (7,'backfeature_terrace','LANDFORM_GENERAL','backfeature_terrace',NULL,'Arrowheads denote uphill side.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (8,'beach_ridge','LANDFORM_GENERAL','beach_ridge',NULL,NULL,'C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (9,'buried_channel_centre','LANDFORM_GENERAL','buried_channel_centre',NULL,NULL,'C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (10,'buried_channel_margin','LANDFORM_GENERAL','buried_channel_margin',NULL,'Beads to outside.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (11,'cliffline_buried','LANDFORM_GENERAL','cliffline_buried',NULL,'Crossmarks on the eroded side.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (12,'cliffline_natural','LANDFORM_GENERAL','cliffline_natural',NULL,'Crossmarks on the eroded side.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (13,'crag_and_tail','GLACIAL_LANDFORM','crag_and_tail',NULL,NULL,'C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (14,'doline_or_karstic_hollow','KARSTIC_LANDFORM','doline_or_karstic_hollow',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (15,'drumlin_crestline','GLACIAL_LANDFORM','drumlin_crestline',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (16,'drumlin_line_at_base','GLACIAL_LANDFORM','drumlin_line_at_base',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (17,'dune_crestline','LANDFORM_GENERAL','dune_crestline',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (18,'dune_line_at_base','LANDFORM_GENERAL','dune_line_at_base',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (19,'elongate_mound_crestline','GLACIAL_LANDFORM','elongate_mound_crestline',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (20,'esker_crestline','GLACIAL_LANDFORM','esker_crestline',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (21,'esker_line_at_base','GLACIAL_LANDFORM','esker_line_at_base',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (22,'glacial_meltwater_channel_centre_undiff','GLACIAL_LANDFORM','glacial_meltwater_channel_centre_undiff',NULL,NULL,'C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (23,'glacial_meltwater_channel_margin','GLACIAL_LANDFORM','glacial_meltwater_channel_margin',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (24,'glacial_overflow_channel_centre','GLACIAL_LANDFORM','glacial_overflow_channel_centre',NULL,NULL,'C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (25,'ice_contact_slope','GLACIAL_LANDFORM','ice_contact_slope',NULL,'Check hachure on upslope.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (26,'ice_marg_glacial_meltwater_channel_left','GLACIAL_LANDFORM','ice_marg_glacial_meltwater_channel_left',NULL,'Barb on opposite side to ice, towards carved terrain.','C','Asymmetry linear; Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (27,'ice_marg_glacial_meltwater_channel_right','GLACIAL_LANDFORM','ice_marg_glacial_meltwater_channel_right',NULL,'Barb on opposite side to ice, towards carved terrain.','C','Asymmetry linear; Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (28,'kettle_hole','GLACIAL_LANDFORM','kettle_hole',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (29,'limestone_fissures','KARSTIC_LANDFORM','limestone_fissures',NULL,NULL,'C','Asymmetry linear; Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (30,'margin_of_erratic_train','GLACIAL_LANDFORM','margin_of_erratic_train',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (31,'moraine_crestline','GLACIAL_LANDFORM','moraine_crestline',NULL,'Ticks on former ice sheet side.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (32,'mound_line_at_base','GLACIAL_LANDFORM','mound_line_at_base',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (33,'outer_edge_of_terrace','LANDFORM_GENERAL','outer_edge_of_terrace',NULL,'Arrowheads denote uphill side.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (34,'palaeochannel','LANDFORM_GENERAL','palaeochannel',NULL,NULL,'C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (35,'roche_moutonee_crestline','GLACIAL_LANDFORM','roche_moutonee_crestline',NULL,'Arrow denotes flow of ice.','C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (36,'rogen_line_at_base','GLACIAL_LANDFORM','rogen_line_at_base',NULL,'Form line at base.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (37,'rogen_moraine_crestline','GLACIAL_LANDFORM','rogen_moraine_crestline',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (38,'sea_bank','LANDFORM_GENERAL','sea_bank',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (40,'stream_sink_line','KARSTIC_LANDFORM','stream_sink_line',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (41,'sub-glacial_meltwater_channel_centre','GLACIAL_LANDFORM','sub-glacial_meltwater_channel_centre',NULL,'Check direction of flow.','C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (42,'subsidence_hollow','LANDFORM_GENERAL','subsidence_hollow',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (43,'superficial_filled_hollow','LANDFORM_GENERAL','superficial_filled_hollow',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (44,'thrust_in_superficial_inf','GLACIAL_LANDFORM','thrust_in_superficial_inf',NULL,'Barbs within mass.','C','Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (45,'tunnel_valley_centre','GLACIAL_LANDFORM','tunnel_valley_centre',NULL,NULL,'C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (46,'tunnel_valley_margin','GLACIAL_LANDFORM','tunnel_valley_margin',NULL,NULL,'C','Asymmetry linear');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (47,'superficial_geology_boundary','SUPERFICIAL_DEPOSIT_BOUNDARY','superficial_geology_boundary',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (48,'superficial_polygon_closure','SUPERFICIAL_DEPOSIT_BOUNDARY','superficial_polygon_closure',NULL,NULL,'C',NULL);
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (49,'glacial_limit_inf','QUATERNARY_LIMITS','glacial_limit_inf',NULL,'Not used in field.','C','Name; Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (50,'glacial_limit_uncertain','QUATERNARY_LIMITS','glacial_limit_uncertain',NULL,'Not used in field.','C','Name; Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (51,'limit_glacial_lake_inf','QUATERNARY_LIMITS','limit_glacial_lake_inf',NULL,'Not used in field.','C','Name; Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_superficial" ("fid","code","category","description","translation","comments","status","sec_attrib_list") VALUES (52,'limit_marine_incursion_inf','QUATERNARY_LIMITS','limit_marine_incursion_inf',NULL,'Not used in field.','C','Name; Asymmetry perpendicular to line');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (1,'gull_undiff','MASS_MOVEMENT_LINE','gull_undiff',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (2,'landslide_main_scarp','MASS_MOVEMENT_LINE','landslide_main_scarp',NULL,'Asymmetry perendicular','Barbs point into landslide.','C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (3,'landslide_head_zone_limit','MASS_MOVEMENT_LINE','landslide_head_zone_limit',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (4,'landslide_minor_scarp','MASS_MOVEMENT_LINE','landslide_minor_scarp',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (5,'mass_move_geology_boundary','MASS_MOVEMENT_DEPOSIT_BOUNDARY','mass_move_geology_boundary',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (6,'mass_move_polygon_closure','MASS_MOVEMENT_DEPOSIT_BOUNDARY','mass_move_polygon_closure',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (7,'tension_crack','MASS_MOVEMENT_LINE','tension_crack',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (9,'valley_bulge_axis_inf','MASS_MOVEMENT_LINE','valley_bulge_axis_inf',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (10,'solifluction_lobe','MASS_MOVEMENT_LINE','solifluction_lobe',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_mass_move" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (11,'gully','MASS_MOVEMENT_LINE','gully',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (1,'air_photo_lineament','TERRAIN_LINE','air_photo_lineament',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (2,'concave_break_of_slope','TERRAIN_LINE','concave_break_of_slope',NULL,'Asymmetry perpendicular to line','Arrowheads denote uphill side.','C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (3,'convex_break_of_slope','TERRAIN_LINE','convex_break_of_slope',NULL,'Asymmetry perpendicular to line','Arrowheads denote downhill side.','C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (4,'dtm_lineament','TERRAIN_LINE','dtm_lineament',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (5,'form_line','TERRAIN_LINE','form_line',NULL,'Asymmetry perpendicular to line',NULL,'C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (6,'form_line_indicating_slope','TERRAIN_LINE','form_line_indicating_slope',NULL,'Asymmetry perpendicular to line',NULL,'C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (7,'hollow_margin','TERRAIN_LINE','hollow_margin',NULL,'Asymmetry perpendicular to line','Hachures point into hollow.','C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (8,'linear_negative_feature','TERRAIN_LINE','linear_negative_feature',NULL,NULL,NULL,'C');
INSERT INTO "dic_line_type_terrain" ("fid","code","category","description","translation","sec_attrib_list","comments","status") VALUES (9,'linear_positive_feature_crestline','TERRAIN_LINE','linear_positive_feature_crestline',NULL,NULL,NULL,'C');
COMMIT;
