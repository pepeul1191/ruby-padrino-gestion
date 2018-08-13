-- migrate:up

CREATE TABLE archivos (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(45) NOT NULL,
  ruta	VARCHAR(40) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS archivos;
