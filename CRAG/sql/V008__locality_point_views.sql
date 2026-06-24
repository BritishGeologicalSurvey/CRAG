/*
Copyright 2026 UKRI / British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
*/
-- Views that allow children of locality point to be plotted on the map.
-- Note that the ST_ spatial functions require the Spatialite extension to be loaded.
BEGIN TRANSACTION;

CREATE VIEW IF NOT EXISTS "view_structural_measurement" AS
  SELECT
    fp.short_name as field_project,
    fp.uuid as field_project_fuid,
    lp.name as locality_point,
    ST_X(ST_Transform(lp.geometry, fp.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, fp.local_epsg)) AS y,
    fp.local_epsg,
    st.category AS structure_category,
    st.code AS structure_code,
    st.description AS structure_type,
    sm.dip,
    sm.azimuth,
    sm.secondary_attribute,
    sm.third_attribute,
    sm.notes,
    sm.uuid AS structure_uuid,
    lp.uuid AS locality_uuid,
    sm.recorded_by,
    sm.recorded_on,
    lp.geometry as geometry
  FROM structural_measurement sm
    LEFT JOIN locality_point lp on sm.locality_fuid = lp.uuid
    LEFT JOIN dic_structure st on sm.structure_type_code = st.code
    LEFT JOIN field_project fp on lp.field_project_fuid = fp.uuid
;

INSERT INTO gpkg_contents
VALUES('view_structural_measurement','features','view_structural_measurement','View with structural measurements at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_structural_measurement','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "view_lithology" AS
 SELECT
    fp.short_name AS field_project,
    fp.uuid as field_project_fuid,
    lp.name AS locality_point,
    ST_X(ST_Transform(lp.geometry, fp.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, fp.local_epsg)) AS y,
    fp.local_epsg,
    loc_type.code AS locality_type,
    lith.lithology_code,
    rock.label AS lithology,
    rock.simple_lithology,
    lith.notes,
    lith.uuid AS lithology_uuid,
    lp.uuid AS locality_uuid,
    lith.recorded_by,
    lith.recorded_on,
    lp.geometry AS geometry
  FROM lithology lith
    LEFT JOIN locality_point lp ON lith.locality_fuid = lp.uuid
    LEFT JOIN dic_locality_type loc_type ON lp.locality_type_code = loc_type.code
      LEFT JOIN dic_rock_field rock ON lith.lithology_code = rock.code
    LEFT JOIN field_project fp ON lp.field_project_fuid = fp.uuid
;

INSERT INTO gpkg_contents
VALUES('view_lithology','features','view_lithology','View with lithology results at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_lithology','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "view_superficial_landform" AS
  SELECT
    fp.short_name AS field_project,
    fp.uuid as field_project_fuid,
    lp.name AS locality_point,
    ST_X(ST_Transform(lp.geometry, fp.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, fp.local_epsg)) AS y,
    fp.local_epsg,
    sc.category AS superficial_category,
    sc.code AS superficial_landform_code,
    sc.description AS superficial_type,
    sl.azimuth,
    sl.dip,
    sl.length,
    sl.width,
    sl.height_depth,
    sl.notes,
    sl.uuid AS superficial_uuid,
    lp.uuid AS locality_uuid,
    sl.recorded_by,
    sl.recorded_on,
    lp.geometry as geometry
  FROM superficial_landform sl
    LEFT JOIN locality_point lp on sl.locality_fuid = lp.uuid
    LEFT JOIN dic_superficial_landform sc on sl.superficial_type_code = sc.code
    LEFT JOIN field_project fp on lp.field_project_fuid = fp.uuid
;

INSERT INTO gpkg_contents
VALUES('view_superficial_landform','features','view_superficial_landform','View with superficial landforms at locality positions','2024-01-25T16:55:45.000Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_superficial_landform','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "view_manmade_landform" AS
  SELECT
    fp.short_name AS field_project,
    fp.uuid as field_project_fuid,
    lp.name AS locality_point,
    ST_X(ST_Transform(lp.geometry, fp.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, fp.local_epsg)) AS y,
    fp.local_epsg,
    mc.category,
    mc.code AS manmade_landform_code,
    mc.description AS manmade_type,
    ml.dip,
    ml.azimuth,
    ml.length,
    ml.width,
    ml.notes,
    ml.uuid AS manmade_uuid,
    lp.uuid AS locality_uuid,
    ml.recorded_by,
    ml.recorded_on,
    lp.geometry as geometry
  FROM manmade_landform ml
    LEFT JOIN locality_point lp on ml.locality_fuid = lp.uuid
    LEFT JOIN dic_manmade_landform mc on ml.manmade_type_code = mc.code
    LEFT JOIN field_project fp on lp.field_project_fuid = fp.uuid
;

INSERT INTO gpkg_contents
VALUES('view_manmade_landform','features','view_manmade_landform','View with manmade landforms at locality positions','2024-01-25T16:55:45.000Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_manmade_landform','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "view_photo" AS
 SELECT
    fp.short_name AS field_project,
    fp.uuid as field_project_fuid,
    lp.name AS locality_point,
    ST_X(ST_Transform(lp.geometry, fp.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, fp.local_epsg)) AS y,
    fp.local_epsg,
    lp.locality_type_code AS locality_type,
    ph.photo_file,
    ph.caption,
    ph.uuid AS photo_uuid,
    lp.uuid AS locality_uuid,
    ph.recorded_by,
    ph.recorded_on,
    lp.geometry AS geometry
  FROM photo ph
    LEFT JOIN locality_point lp ON ph.locality_fuid = lp.uuid
    LEFT JOIN field_project fp ON lp.field_project_fuid = fp.uuid
;

INSERT INTO gpkg_contents
VALUES('view_photo','features','view_photo','View with photo records at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_photo','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "view_media" AS
 SELECT
    fp.short_name AS field_project,
    fp.uuid as field_project_fuid,
    lp.name AS locality_point,
    ST_X(ST_Transform(lp.geometry, fp.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, fp.local_epsg)) AS y,
    fp.local_epsg,
    lp.locality_type_code AS locality_type,
    me.media_type_code AS media_type,
    me.media_link,
    me.media_description,
    me.uuid AS media_uuid,
    lp.uuid AS locality_uuid,
    me.recorded_by,
    me.recorded_on,
    lp.geometry AS geometry
  FROM media me
    LEFT JOIN locality_point lp ON me.locality_fuid = lp.uuid
    LEFT JOIN field_project fp ON lp.field_project_fuid = fp.uuid
;

INSERT INTO gpkg_contents
VALUES('view_media','features','view_media','View with media records at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_media','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "view_sample" AS
 SELECT
    fp.short_name AS field_project,
    fp.uuid as field_project_fuid,
    lp.name AS locality_point,
    ST_X(ST_Transform(lp.geometry, fp.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, fp.local_epsg)) AS y,
    fp.local_epsg,
    lp.locality_type_code AS locality_type,
    sa.sample_id,
    sa.sample_type_code AS sample_type,
    sa.sample_description,
    sa.uuid AS sample_uuid,
    lp.uuid AS locality_uuid,
    sa.recorded_by,
    sa.recorded_on,
    lp.geometry AS geometry
  FROM sample sa
    LEFT JOIN locality_point lp ON sa.locality_fuid = lp.uuid
    LEFT JOIN field_project fp ON lp.field_project_fuid = fp.uuid
;

INSERT INTO gpkg_contents
VALUES('view_sample','features','view_sample','View with sample results at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_sample','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "_view_next_locality_id" AS
  -- Using nested SELECT statements as it allows us to build reusable variables
  SELECT
    username,
    -- Concatenating the individual elements together to form the next id value as a string
    -- The methods within the printf statement are adding the required padding for the next_int_id value
    locality_prefix || printf("%03d", next_int_id) AS next_locality_id
  FROM
    (
      SELECT
        -- Keep the locality_prefix for building the final string
        locality_prefix,
        -- Get the username without the split suffix for easy querying later
        SUBSTR(locality_prefix, 0, LENGTH(locality_prefix)) AS username,
        -- Calculate the next integer id, by getting the current max for each name + 1
        -- The replace transforms "user_a_001" into "001", by replacing "user_a_" with ""
        MAX(REPLACE(locality_name, locality_prefix, "")) + 1 AS next_int_id
      FROM
        (
          SELECT
            -- Keep the original locality_name for further calculations
            -- Get the name with the split character ONLY, ignoring the dynamic integer id
            -- by chopping off the 3 digit integer suffix
            name AS locality_name,
            SUBSTR(name, 0, LENGTH(name) - 2) AS locality_prefix
          FROM
            locality_point
        )
      -- Grouping so that we only get 1 next_int_id for each username based on the current MAX
      GROUP BY
        locality_prefix
    )
;

INSERT INTO gpkg_contents
VALUES('_view_next_locality_id','attributes','_view_next_locality_id','List of next locality_point ID values based on existing locality_point data.','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);


COMMIT;