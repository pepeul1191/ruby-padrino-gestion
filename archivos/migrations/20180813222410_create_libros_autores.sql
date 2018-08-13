-- migrate:up

CREATE TABLE libros_autores(
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  libro_id INTEGER,
  autor_id INTEGER,
  FOREIGN KEY (libro_id) REFERENCES libros(id) ON DELETE CASCADE,
  FOREIGN KEY (autor_id) REFERENCES autores(id) ON DELETE CASCADE
)

-- migrate:down

DROP TABLE IF EXISTS libros_autores;
