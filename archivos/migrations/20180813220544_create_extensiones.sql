-- migrate:up

CREATE TABLE extensiones (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(10) NOT NULL,
  mime	VARCHAR(30) NOT NULL
);

-- migrate:down

DROP TABLE IF EXISTS extensiones;
