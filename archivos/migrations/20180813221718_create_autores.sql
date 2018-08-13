-- migrate:up

CREATE TABLE autores (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(45) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS autores;
