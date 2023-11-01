-- Views that allow children of locality point to be plotted on the map.
-- Note that the ST_ spatial functions require the Spatialite extension to be loaded.
BEGIN TRANSACTION;

CREATE VIEW IF NOT EXISTS "view_structural_measurement" AS
  SELECT
    p.short_name as project,
    lp.name as locality_point,
    ST_X(ST_Transform(lp.geometry, p.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, p.local_epsg)) AS y,
    p.local_epsg,
    st.category AS structure_category,
    st.description AS structure_type,
    sm.dip,
    sm.dip_direction,
    sm.comment,
    sm.uuid AS structure_uuid,
    lp.uuid AS locality_uuid,
    lp.geometry as geometry
  FROM structural_measurement sm
    LEFT JOIN locality_point lp on sm.locality_fuid = lp.uuid
    LEFT JOIN dic_structure_code st on sm.structure_type_code = st.code
    LEFT JOIN project p on lp.project_fuid = p.uuid
;

INSERT INTO gpkg_contents
VALUES('view_structural_measurement','features','view_structural_measurement','View with structural measurements at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_structural_measurement','geometry','POINT',4326,1,0);


CREATE VIEW IF NOT EXISTS "view_exposure" AS
 SELECT
    p.short_name as project,
    lp.name as locality_point,
    ST_X(ST_Transform(lp.geometry, p.local_epsg)) AS x,
    ST_Y(ST_Transform(lp.geometry, p.local_epsg)) AS y,
    p.local_epsg,
    type.translation as exposure_type,
	exp.lithology_code,
	rock.translation as lithology,
    exp.description,
    exp.comment,
    exp.uuid AS exposure_uuid,
    lp.uuid AS locality_uuid,
    lp.geometry as geometry
  FROM exposure exp
    LEFT JOIN locality_point lp on exp.locality_fuid = lp.uuid
    LEFT JOIN dic_exposure_type type on exp.exposure_type_code = type.code
	LEFT JOIN dic_rock_all rock on exp.lithology_code = rock.code
    LEFT JOIN project p on lp.project_fuid = p.uuid
;

INSERT INTO gpkg_contents
VALUES('view_exposure','features','view_exposure','View with exposure results at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,4326);

INSERT INTO gpkg_geometry_columns
VALUES('view_exposure','geometry','POINT',4326,1,0);

COMMIT;