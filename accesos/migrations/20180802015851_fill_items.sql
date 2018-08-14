-- migrate:up

INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Menú',
  'accesos/#/modulo',
  1
);
INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Permisos',
  'accesos/#/permiso',
  2
);
INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Roles',
  'accesos/#/rol',
  2
);
INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Usuarios',
  'accesos/#/usuario',
  3
);

-- migrate:down
