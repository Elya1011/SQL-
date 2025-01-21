CREATE TABLE IF NOT EXISTS genre (
	id SERIAL PRIMARY key,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS singer (
	id serial PRIMARY KEY,
	nickname VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS genres_singers (
	singer_id INTEGER REFERENCES singer(id),
	genre_id INTEGER REFERENCES genre(id),
	CONSTRAINT pk PRIMARY KEY (singer_id, genre_id)
);

CREATE TABLE IF NOT EXISTS album (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	year_of_issue INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS singers_albums (
	singer_id INTEGER REFERENCES singer(id),
	album_id INTEGER REFERENCES album(id),
	CONSTRAINT pk PRIMARY KEY (singer_id, album_id)
);


CREATE TABLE IF NOT EXISTS track(
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	duration INTEGER NOT NULL,
	album_id INTEGER NOT NULL REFERENCES album(id)
);

alter table track add check (duration <= 240);