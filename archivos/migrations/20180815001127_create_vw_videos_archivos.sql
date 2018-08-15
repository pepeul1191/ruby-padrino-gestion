-- migrate:up

CREATE VIEW vw_videos_archivos AS SELECT
    V.id, V.nombre, V.anio, V.duracion, V.archivo_id, A.nombre as video_nombre, A.ruta || A.nombre || '.' || E.nombre AS video_ruta FROM
    videos V
    INNER JOIN archivos A ON A.id = V.archivo_id
    INNER JOIN extensiones E ON A.extension_id = E.id
    LIMIT 2000;

-- migrate:down

DROP VIEW IF EXISTS vw_videos_archivos;
