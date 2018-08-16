-- migrate:up

CREATE VIEW vw_libros_archivos AS SELECT
    L.id, L.nombre, L.anio, L.paginas, L.archivo_id, A.nombre as libro_nombre, A.ruta || A.nombre_generado AS libro_ruta FROM
    libros L
    INNER JOIN archivos A ON A.id = L.archivo_id
    INNER JOIN extensiones E ON A.extension_id = E.id
    LIMIT 2000;

-- migrate:down

DROP VIEW IF EXISTS vw_libros_archivos;
