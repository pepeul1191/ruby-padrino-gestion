-- migrate:up

CREATE VIEW vw_libros_autores AS SELECT
    LA.id, A.id AS autor_id, A.nombre AS autor_nombre, L.id AS libro_id, L.nombre as libro_nombre FROM
    libros_autores LA
    INNER JOIN autores A ON A.id = LA.autor_id
    INNER JOIN libros L ON  LA.libro_id = L.id
    LIMIT 2000;

-- migrate:down

DROP VIEW IF EXISTS vw_libros_autores;
