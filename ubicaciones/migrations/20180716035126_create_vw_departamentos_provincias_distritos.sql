-- migrate:up
--sqlite3
CREATE VIEW vw_distrito_provincia_departamento AS
  SELECT DI.id AS id, DI.nombre || ', '  || PR.nombre || ', '  || DE.nombre AS nombre
  FROM distritos DI
  JOIN provincias PR ON DI.provincia_id = PR.id
  JOIN departamentos DE ON PR.departamento_id = DE.id
  LIMIT 2000

-- migrate:down
