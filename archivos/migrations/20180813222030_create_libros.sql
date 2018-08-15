-- migrate:up

CREATE TABLE libros (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(45) NOT NULL,
  paginas	INTEGER NOT NULL,
  anio	INTEGER NOT NULL,
	archivo_id INTEGER,
  FOREIGN KEY (archivo_id) REFERENCES archivos(id) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS libros;
