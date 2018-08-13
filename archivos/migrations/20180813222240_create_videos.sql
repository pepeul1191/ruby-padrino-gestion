-- migrate:up

CREATE TABLE videos (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(45) NOT NULL,
  duracion TIME NOT NULL,
  ruta	VARCHAR(40) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS videos;
