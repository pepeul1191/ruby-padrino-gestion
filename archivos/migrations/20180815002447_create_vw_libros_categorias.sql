-- migrate:up

CREATE VIEW vw_libros_categorias AS SELECT
    LC.id, C.id AS categoria_id, C.nombre AS categoria_nombre,  L.id AS libro_id, L.nombre as libro_nombre FROM
    libros_categorias LC
    INNER JOIN categorias C ON C.id = LC.categoria_id
    INNER JOIN libros L ON  LC.libro_id = L.id
    LIMIT 2000;

-- migrate:down

DROP VIEW IF EXISTS vw_libros_categorias;
