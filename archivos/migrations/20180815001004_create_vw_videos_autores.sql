-- migrate:up

CREATE VIEW vw_videos_autores AS SELECT
    VA.id AS id, A.id AS autor_id, A.nombre AS autor_nombre, V.id AS video_id, V.nombre as video_nombre FROM
    videos_autores VA
    INNER JOIN autores A ON A.id = VA.autor_id
    INNER JOIN videos V ON  VA.video_id = V.id
    LIMIT 2000;
    
-- migrate:down

DROP VIEW IF EXISTS vw_videos_autores;
