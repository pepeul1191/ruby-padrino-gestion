-- migrate:up

INSERT INTO subtitulos (nombre, modulo_id) VALUES (
  'Navegación',
  1
);
INSERT INTO subtitulos (nombre, modulo_id) VALUES (
  'Permisos y Roles',
  1
);
INSERT INTO subtitulos (nombre, modulo_id) VALUES (
  'Usuarios',
  1
);

-- migrate:down
