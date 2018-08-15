-- migrate:up

CREATE TABLE videos (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(45) NOT NULL,
  duracion TIME NOT NULL,
  ruta	VARCHAR(40) NOT NULL,
	anio	INTEGER NOT NULL,
	archivo_id INTEGER,
  FOREIGN KEY (archivo_id) REFERENCES archivos(id) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS videos;
