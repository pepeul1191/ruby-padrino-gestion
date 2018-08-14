-- migrate:up

INSERT INTO modulos (nombre, url, icono) VALUES (
  'Archivos',
  'archivos/',
  ''
); --id generado -> 2

INSERT INTO subtitulos (nombre, modulo_id) VALUES (
  'Opciones',
  2
); --id generado -> 4
INSERT INTO subtitulos (nombre, modulo_id) VALUES (
  'Tags',
  2
); --id generado -> 5
INSERT INTO subtitulos (nombre, modulo_id) VALUES (
  'Archivos',
  2
); --id generado -> 6

INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Extensiones',
  'archivos/#/extension',
  4
);
INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Autores',
  'archivos/#/autor',
  5
);
INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Categorias',
  'archivos/#/categoria',
  5
);
INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Libros',
  'archivos/#/libro',
  6
);
INSERT INTO items (nombre, url, subtitulo_id) VALUES (
  'Gestión de Videos',
  'archivos/#/video',
  6
);

-- migrate:down
