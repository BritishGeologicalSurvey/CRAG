-- Dictionaries used to constrain line features.

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


CREATE TABLE "dic_min_vein" (
	"fid"	INTEGER NOT NULL,
	"code" TEXT NOT NULL UNIQUE,
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
values('dic_min_vein','attributes','dic_min_vein','Dictionary of materials found in veins','2023-09-15t13:21:52.679z',null,null,null,null,null);

CREATE TABLE "dic_line_type_artificial" (
	"fid"	INTEGER NOT NULL,
	"code"	TEXT NOT NULL UNIQUE,
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