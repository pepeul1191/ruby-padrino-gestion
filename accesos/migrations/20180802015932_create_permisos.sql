-- migrate:up

CREATE TABLE permisos(
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(30) NOT NULL,
	llave	VARCHAR(30)
)

-- migrate:down

DROP TABLE IF EXISTS permisos;
