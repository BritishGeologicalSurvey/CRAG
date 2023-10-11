-- Views that allow children of locality point to be plotted on the map.
-- Note that the ST_ spatial functions require the Spatialite extension to be loaded.
BEGIN TRANSACTION;

CREATE VIEW IF NOT EXISTS "view_structural_measurement" AS
  SELECT
    p.short_name as project,
    lp.name as locality_point,
    st.category AS structure_category,
    st.description AS structure_type,
    ST_X(ST_Transform(lp.geometry, 4326)) AS lon,
    ST_Y(ST_Transform(lp.geometry, 4326)) AS lat,
    sm.dip,
    sm.dip_direction,
    sm.comment,
    sm.uuid AS structure_uuid,
    lp.uuid AS locality_uuid,
    lp.geometry as geometry
  FROM structural_measurement sm
    LEFT JOIN locality_point lp on sm.locality_fuid = lp.fid
    LEFT JOIN dic_structure_code st on sm.structure_type_code = st.code
    LEFT JOIN project p on lp.project_fuid = p.uuid
;

INSERT INTO gpkg_contents
VALUES('view_structural_measurement','features','view_structural_measurement','View with structural measurements at locality positions','2023-09-15T13:21:52.679Z',NULL,NULL,NULL,NULL,NULL);

COMMIT;