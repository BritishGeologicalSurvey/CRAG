-- Activity table, which is parent of localities
BEGIN TRANSACTION;

INSERT INTO gpkg_geometry_columns
VALUES('field_project','geometry','POLYGON',4326,0,0);


INSERT INTO gpkg_extensions
VALUES('field_project','geometry','gpkg_rtree_index','http://www.geopackage.org/spec120/#extension_rtree','write-only');


INSERT INTO gpkg_contents
VALUES('field_project','features','field_project','','2024-04-17T13:25:04.729Z',NULL,NULL,NULL,NULL,4326);


CREATE TABLE IF NOT EXISTS "field_project"
  -- Field project table. All data are children of this table.
(
    "fid" INTEGER NOT NULL,
    "uuid" TEXT NOT NULL UNIQUE CHECK(LENGTH("uuid") <= 38),
    "short_name" TEXT NOT NULL UNIQUE CHECK(LENGTH("short_name") <= 50),
    "title" TEXT CHECK(LENGTH("title") <= 255),
    "description" TEXT CHECK(LENGTH("description") <= 4000),
    "project_lead" TEXT CHECK(LENGTH("project_lead") <= 50),
    "start_date" DATE,
    "end_date" DATE,
    "local_epsg" INTEGER NOT NULL, -- Used to calculate the coordinates in local projection, e.g. in views
    "notes" TEXT CHECK(LENGTH("notes") <= 4000),
    "mapped_scale" INTEGER NOT NULL, -- Default value for scale field in lines tables
    "recorded_by" TEXT NOT NULL CHECK(LENGTH("recorded_by") <= 50),
    "recorded_on" DATETIME NOT NULL,
    "qgis_plugin_version" TEXT CHECK(LENGTH("qgis_plugin_version") <= 50),
    "geometry" POLYGON NOT NULL,
    PRIMARY KEY("fid" AUTOINCREMENT)
);

PRAGMA writable_schema=ON;


INSERT INTO sqlite_schema(type, name, tbl_name, rootpage, sql)
VALUES('table','rtree_field_project_geometry','rtree_field_project_geometry',0,'CREATE VIRTUAL TABLE "rtree_field_project_geometry" USING rtree(id, minx, maxx, miny, maxy)');


CREATE TABLE IF NOT EXISTS "rtree_field_project_geometry_rowid"(rowid INTEGER PRIMARY KEY,
  nodeno);


CREATE TABLE IF NOT EXISTS "rtree_field_project_geometry_node"(nodeno INTEGER PRIMARY KEY,
  data);


INSERT INTO "rtree_field_project_geometry_node"
VALUES(1,X'00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');


CREATE TABLE IF NOT EXISTS "rtree_field_project_geometry_parent"(nodeno INTEGER PRIMARY KEY,
  parentnode);


CREATE TRIGGER "rtree_field_project_geometry_insert" AFTER
INSERT ON "field_project" WHEN (new."geometry" NOT NULL
  AND NOT ST_IsEmpty(NEW."geometry")) BEGIN
INSERT
OR
REPLACE INTO "rtree_field_project_geometry"
VALUES (NEW."fid",ST_MinX(NEW."geometry"), ST_MaxX(NEW."geometry"),ST_MinY(NEW."geometry"),
  ST_MaxY(NEW."geometry")); END;


CREATE TRIGGER "rtree_field_project_geometry_update1" AFTER
UPDATE OF "geometry" ON "field_project" WHEN OLD."fid" = NEW."fid"
AND (NEW."geometry" NOTNULL
  AND NOT ST_IsEmpty(NEW."geometry")) BEGIN
INSERT
OR
REPLACE INTO "rtree_field_project_geometry"
VALUES (NEW."fid",ST_MinX(NEW."geometry"), ST_MaxX(NEW."geometry"),ST_MinY(NEW."geometry"),
  ST_MaxY(NEW."geometry")); END;


CREATE TRIGGER "rtree_field_project_geometry_update2" AFTER
UPDATE OF "geometry" ON "field_project" WHEN OLD."fid" = NEW."fid"
AND (NEW."geometry" ISNULL
  OR ST_IsEmpty(NEW."geometry")) BEGIN
DELETE
FROM "rtree_field_project_geometry"
WHERE id = OLD."fid"; END;


CREATE TRIGGER "rtree_field_project_geometry_update3" AFTER
UPDATE ON "field_project" WHEN OLD."fid" != NEW."fid"
AND (NEW."geometry" NOTNULL
  AND NOT ST_IsEmpty(NEW."geometry")) BEGIN
DELETE
FROM "rtree_field_project_geometry"
WHERE id = OLD."fid";
  INSERT
  OR
  REPLACE INTO "rtree_field_project_geometry"
VALUES (NEW."fid",ST_MinX(NEW."geometry"), ST_MaxX(NEW."geometry"),ST_MinY(NEW."geometry"),
  ST_MaxY(NEW."geometry")); END;


CREATE TRIGGER "rtree_field_project_geometry_update4" AFTER
UPDATE ON "field_project" WHEN OLD."fid" != NEW."fid"
AND (NEW."geometry" ISNULL
  OR ST_IsEmpty(NEW."geometry")) BEGIN
DELETE
FROM "rtree_field_project_geometry"
WHERE id IN (OLD."fid", NEW."fid"); END;


CREATE TRIGGER "rtree_field_project_geometry_delete" AFTER
DELETE ON "field_project" WHEN old."geometry" NOT NULL BEGIN
DELETE
FROM "rtree_field_project_geometry"
WHERE id = OLD."fid"; END;


CREATE TRIGGER "field_project_limit_1"
    BEFORE INSERT ON "field_project" WHEN (SELECT COUNT(1) FROM "field_project") >= 1
    BEGIN
        SELECT RAISE(FAIL, "Only one Field Project is permitted per project."); END;


CREATE TABLE IF NOT EXISTS "_lnk_rock_project" (
    -- Linking table used to filter available rock types in lithology drop-down for a given project.
    "fid" INTEGER NOT NULL,
    "field_project_uuid" TEXT NOT NULL,
    "rock_code" TEXT NOT NULL,
    "category" TEXT,
    "simple_lithology" TEXT,
    FOREIGN KEY("rock_code") REFERENCES "dic_rock_field"("code"),
    FOREIGN KEY("field_project_uuid") REFERENCES "field_project"("uuid"),
    PRIMARY KEY("fid" AUTOINCREMENT)
);

-- TODO: register relationship in geopackage http://www.geopackage.org/guidance/extensions/related_tables.html
insert into gpkg_contents
values('_lnk_rock_project','attributes','_lnk_rock_project','Linking table to define project lithologies','2022-09-15t13:21:52.679z',null,null,null,null,null);


-- This trigger is used to populate the default list of lithologies for a new project
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


-- This trigger is used to populate additional columns so they can be used for filtering
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

PRAGMA writable_schema=OFF;

COMMIT;