-- migrate:up

CREATE TABLE archivos (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(45) NOT NULL,
	nombre_generado	VARCHAR(80) NOT NULL,
  ruta	VARCHAR(40) NOT NULL,
	extension_id INTEGER,
  FOREIGN KEY (extension_id) REFERENCES extensiones(id) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS archivos;
