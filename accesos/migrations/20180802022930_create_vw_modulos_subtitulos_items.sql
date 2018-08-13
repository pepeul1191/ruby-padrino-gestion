-- migrate:up

CREATE VIEW vw_modulos_subtitulos_items AS SELECT
  I.id, S.modulo_id, M.nombre AS modulo, M.url AS url_modulo, S.id AS subtitulo_id, S.nombre AS subtitulo, I.nombre AS item, I.url AS url_item
  FROM subtitulos S
  INNER JOIN items I ON S.id = I.subtitulo_id
  INNER JOIN modulos M ON S.modulo_id = M.id
  LIMIT 2000;

-- migrate:down

DROP VIEW IF EXISTS vw_modulos_subtitulos_items;
