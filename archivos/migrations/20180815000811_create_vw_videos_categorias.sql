-- migrate:up

CREATE VIEW vw_videos_categorias AS SELECT
    VC.id, C.id AS categoria_id, C.nombre AS categoria_nombre, V.id AS video_id, V.nombre as video_nombre FROM
    videos_categorias VC
    INNER JOIN categorias C ON C.id = VC.categoria_id
    INNER JOIN videos V ON  VC.video_id = V.id
    LIMIT 2000;

-- migrate:down

DROP VIEW IF EXISTS vw_videos_categorias;
