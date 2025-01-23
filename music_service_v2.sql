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

ALTER TABLE track ADD CHECK (duration <= 240);

INSERT INTO genre (name) VALUES
	('Rock'),
	('K-pop'),
	('pop music');

INSERT INTO singer (nickname) values
	('BTS'),
	('Нервы'),
	('Три дня дождя'),
	('Ramil');

INSERT INTO album (name, year_of_issue) VALUES
	('Слишком влюблён', 2016),
	('Всё Что Вокруг', 2012),
	('Love Yourself', 2017),
	('Пепел', 2020),
	('Сияй', 2020);

INSERT INTO track (name, duration, album_id) VALUES
	('Слишком влюблён', 209, 1),
	('Нервы', 158, 2),
	('Глупая', 212, 2),
	('Кофе мой друг', 187, 2),
	('DNA', 223, 3),
	('Go Go', 235, 3),
	('Привычка', 161, 4);

INSERT INTO track (name, duration, album_id) VALUES
	('Проиграли', 217, 4),
	('Падали', 159, 5),
	('Аромат', 210, 5);

INSERT INTO track (name, duration, album_id) VALUES
	('Беги от меня', 198, 4)

INSERT INTO collection (name, year_of_issue) VALUES
	('Золотая коллекция', 2021),
	('The best of the best', 2020),
	('For you', 2018),
	('То, что ты ищешь', 2022); 

INSERT INTO genres_singers (singer_id, genre_id) VALUES 
	(2, 5),
	(3, 5),
	(1, 6),
	(4, 7),
	(2, 7);

INSERT INTO singers_albums (singer_id, album_id) VALUES
	(1, 3),
	(2, 1),
	(3, 4),
	(2, 2),
	(4, 5);

INSERT INTO collections_tracks (track_id, collection_id) VALUES
	(3, 1),
	(7, 1),
	(6, 1);

INSERT INTO collections_tracks (track_id, collection_id) VALUES
	(2, 2),
	(1, 2),
	(9, 2),
	(4, 3),
	(10, 3),
	(1, 3),
	(5, 4),
	(8, 4),
	(9, 4);


SELECT name, duration FROM track
ORDER BY duration DESC LIMIT 1

SELECT name, duration FROM track
WHERE duration >= 210

SELECT * FROM collection c
WHERE year_of_issue BETWEEN 2018 AND 2020

SELECT nickname FROM singer
WHERE nickname NOT LIKE '% %'

SELECT name FROM track t 
WHERE name LIKE '% мой %'

SELECT genre_id, count(singer_id) FROM genres_singers gs
GROUP BY genre_id
HAVING count(genre_id) >= 1 

SELECT COUNT(t.id) FROM track t
JOIN album a ON a.id = t.album_id 
WHERE a.year_of_issue BETWEEN 2019 AND 2020

SELECT AVG(t.duration) FROM track t
JOIN album a ON a.id = t.album_id 
GROUP BY a.id

SELECT nickname FROM singer s 
JOIN singers_albums sa ON sa.album_id = s.id 
JOIN album a ON sa.singer_id = a.id
WHERE year_of_issue != 2020

SELECT c."name" FROM collection c 
JOIN collections_tracks ct ON ct.track_id = c.id
JOIN track t ON t.id = ct.track_id 
JOIN album a ON a.id = t.id
JOIN singers_albums sa ON sa.album_id = a.id
JOIN singer s ON s.id = sa.singer_id
WHERE nickname = 'Нервы'

SELECT a.name FROM album a 
JOIN singers_albums sa ON sa.album_id = a.id 
JOIN genres_singers gs ON sa.singer_id = gs.singer_id
GROUP BY a.name
HAVING count(a.name) > 1

SELECT t.name FROM track t
LEFT JOIN collections_tracks ct ON ct.track_id = t.id 
WHERE ct.collection_id IS null

SELECT s.nickname FROM singer s 
JOIN singers_albums sa ON sa.singer_id = s.id 
JOIN track t ON t.album_id = sa.album_id
ORDER BY t.duration LIMIT 1

select a.name, count(t.album_id) from album a 
join track t on t.album_id = a.id 
group by a.name
order by count(t.album_id) limit 1
