-- migrate:up

CREATE TABLE libros_categorias(
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  libro_id INTEGER,
  categogia_id INTEGER,
  FOREIGN KEY (libro_id) REFERENCES libros(id) ON DELETE CASCADE,
  FOREIGN KEY (categogia_id) REFERENCES categorias(id) ON DELETE CASCADE
)

-- migrate:down

DROP TABLE IF EXISTS libros_categorias;
