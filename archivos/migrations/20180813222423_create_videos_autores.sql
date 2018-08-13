-- migrate:up

CREATE TABLE videos_autores(
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  video_id INTEGER,
  autor_id INTEGER,
  FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE,
  FOREIGN KEY (autor_id) REFERENCES autores(id) ON DELETE CASCADE
)

-- migrate:down

DROP TABLE IF EXISTS videos_autores;
