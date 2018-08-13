-- migrate:up

CREATE TABLE categorias (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(25) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS categorias;
