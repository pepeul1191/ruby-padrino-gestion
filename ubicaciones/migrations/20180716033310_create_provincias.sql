-- migrate:up

CREATE TABLE provincias(
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nombre	VARCHAR(30) NOT NULL,
  departamento_id INTEGER,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id) ON DELETE CASCADE
)

-- migrate:down

DROP TABLE IF EXISTS provincias;
