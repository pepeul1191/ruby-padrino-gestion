-- migrate:up

CREATE TABLE videos_categorias(
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  video_id INTEGER,
  categoria_id INTEGER,
  FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE
)

-- migrate:down

DROP TABLE IF EXISTS videos_categorias;
