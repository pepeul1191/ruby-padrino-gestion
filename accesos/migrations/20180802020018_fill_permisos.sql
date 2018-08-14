-- migrate:up

INSERT INTO permisos (nombre, llave) VALUES (
  'Listar Sistemas',
  'sistema_listar'
);
INSERT INTO permisos (nombre, llave) VALUES (
  'Listar Módulos de Sistema',
  'sistema_modulo_listar'
);

-- migrate:down
