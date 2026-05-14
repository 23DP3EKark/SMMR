INSERT INTO music_categories (name)
SELECT 'Pop' WHERE NOT EXISTS (SELECT 1 FROM music_categories WHERE name = 'Pop');
INSERT INTO music_categories (name)
SELECT 'Rock' WHERE NOT EXISTS (SELECT 1 FROM music_categories WHERE name = 'Rock');
INSERT INTO music_categories (name)
SELECT 'Hip-Hop' WHERE NOT EXISTS (SELECT 1 FROM music_categories WHERE name = 'Hip-Hop');
INSERT INTO music_categories (name)
SELECT 'Electronic' WHERE NOT EXISTS (SELECT 1 FROM music_categories WHERE name = 'Electronic');
INSERT INTO music_categories (name)
SELECT 'R&B' WHERE NOT EXISTS (SELECT 1 FROM music_categories WHERE name = 'R&B');
INSERT INTO music_categories (name)
SELECT 'Jazz' WHERE NOT EXISTS (SELECT 1 FROM music_categories WHERE name = 'Jazz');

INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'One More Time', 'Daft Punk', 2000, 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/9b/99/fb/9b99fbd1-a965-62ec-bd30-366702e370cb/190296611213.jpg/300x300bb.jpg', NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'One More Time' AND artist = 'Daft Punk');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Get Lucky', 'Daft Punk', 2013, 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/7e/c8/f8/7ec8f83e-24bc-9b21-c1c4-c29ab7e2f205/886443919266.jpg/300x300bb.jpg', NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Get Lucky' AND artist = 'Daft Punk');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Blinding Lights', 'The Weeknd', 2019, 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/41/b5/0c/41b50c34-c48f-9984-55f4-d2a3089e4c7c/20UMGIM02713.rgb.jpg/300x300bb.jpg', NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Blinding Lights' AND artist = 'The Weeknd');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Smells Like Teen Spirit', 'Nirvana', 1991, 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/f5/fb/58/f5fb58c4-6d72-4ee9-725e-a62d2cc1d6f8/00602527779097.rgb.jpg/300x300bb.jpg', NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Smells Like Teen Spirit' AND artist = 'Nirvana');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Sicko Mode', 'Travis Scott', 2018, 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/c2/99/b5/c299b5c1-24cd-64ef-86d7-4281ecfd63c7/886447105329.jpg/300x300bb.jpg', NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Sicko Mode' AND artist = 'Travis Scott');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Take Five', 'Dave Brubeck', 1959, 'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/15/54/b4/1554b4f5-78dc-3755-c888-26ac733fe1bd/886444082891.jpg/300x300bb.jpg', NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Take Five' AND artist = 'Dave Brubeck');

INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Electronic'
WHERE s.title = 'One More Time' AND s.artist = 'Daft Punk'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Electronic'
WHERE s.title = 'Get Lucky' AND s.artist = 'Daft Punk'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Pop'
WHERE s.title = 'Get Lucky' AND s.artist = 'Daft Punk'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Pop'
WHERE s.title = 'Blinding Lights' AND s.artist = 'The Weeknd'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Rock'
WHERE s.title = 'Smells Like Teen Spirit' AND s.artist = 'Nirvana'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Hip-Hop'
WHERE s.title = 'Sicko Mode' AND s.artist = 'Travis Scott'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Jazz'
WHERE s.title = 'Take Five' AND s.artist = 'Dave Brubeck'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);

INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Around the World', 'Daft Punk', 1997, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Around the World' AND artist = 'Daft Punk');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Levitating', 'Dua Lipa', 2020, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Levitating' AND artist = 'Dua Lipa');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'No Role Modelz', 'J. Cole', 2014, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'No Role Modelz' AND artist = 'J. Cole');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Come Away With Me', 'Norah Jones', 2002, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Come Away With Me' AND artist = 'Norah Jones');
DELETE FROM songs
WHERE title = 'Redbone' AND artist = 'Childish Gambino';
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Redbone (Mixed)', 'Childish Gambino', 2016, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Redbone (Mixed)' AND artist = 'Childish Gambino');
INSERT INTO songs (title, artist, release_year, cover_image_url, preview_url)
SELECT 'Bohemian Rhapsody', 'Queen', 1975, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM songs WHERE title = 'Bohemian Rhapsody' AND artist = 'Queen');

INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Electronic'
WHERE s.title = 'Around the World' AND s.artist = 'Daft Punk'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Pop'
WHERE s.title = 'Levitating' AND s.artist = 'Dua Lipa'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Hip-Hop'
WHERE s.title = 'No Role Modelz' AND s.artist = 'J. Cole'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Jazz'
WHERE s.title = 'Come Away With Me' AND s.artist = 'Norah Jones'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'R&B'
WHERE s.title = 'Redbone (Mixed)' AND s.artist = 'Childish Gambino'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);
INSERT INTO song_categories (song_id, category_id)
SELECT s.id, c.id FROM songs s JOIN music_categories c ON c.name = 'Rock'
WHERE s.title = 'Bohemian Rhapsody' AND s.artist = 'Queen'
AND NOT EXISTS (SELECT 1 FROM song_categories sc WHERE sc.song_id = s.id AND sc.category_id = c.id);

INSERT INTO movie_categories (name)
SELECT 'Action' WHERE NOT EXISTS (SELECT 1 FROM movie_categories WHERE name = 'Action');
INSERT INTO movie_categories (name)
SELECT 'Comedy' WHERE NOT EXISTS (SELECT 1 FROM movie_categories WHERE name = 'Comedy');
INSERT INTO movie_categories (name)
SELECT 'Drama' WHERE NOT EXISTS (SELECT 1 FROM movie_categories WHERE name = 'Drama');
INSERT INTO movie_categories (name)
SELECT 'Sci-Fi' WHERE NOT EXISTS (SELECT 1 FROM movie_categories WHERE name = 'Sci-Fi');
INSERT INTO movie_categories (name)
SELECT 'Animation' WHERE NOT EXISTS (SELECT 1 FROM movie_categories WHERE name = 'Animation');
INSERT INTO movie_categories (name)
SELECT 'Thriller' WHERE NOT EXISTS (SELECT 1 FROM movie_categories WHERE name = 'Thriller');

INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'The Matrix', 'Warner Bros.', 1999, 'https://is1-ssl.mzstatic.com/image/thumb/Video115/v4/c8/91/81/c891816d-d9fd-9694-0b8e-b53c45f90600/pr_source.lsr/300x300bb.jpg'
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'The Matrix' AND studio = 'Warner Bros.');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'Inception', 'Warner Bros.', 2010, 'https://is1-ssl.mzstatic.com/image/thumb/Video115/v4/a4/50/fd/a450fd98-38a1-8142-1889-afc6abe3a6f8/pr_source.lsr/300x300bb.jpg'
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'Inception' AND studio = 'Warner Bros.');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'Toy Story', 'Pixar', 1995, 'https://is1-ssl.mzstatic.com/image/thumb/Video115/v4/46/1c/13/461c1361-f36e-22ab-349e-827c5767c62b/pr_source.lsr/300x300bb.jpg'
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'Toy Story' AND studio = 'Pixar');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'The Dark Knight', 'Warner Bros.', 2008, 'https://is1-ssl.mzstatic.com/image/thumb/Video115/v4/f5/67/d8/f567d82c-cbe0-880c-79ba-f66e9b7c020d/pr_source.lsr/300x300bb.jpg'
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'The Dark Knight' AND studio = 'Warner Bros.');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'The Grand Budapest Hotel', 'Fox Searchlight', 2014, 'https://is1-ssl.mzstatic.com/image/thumb/Video124/v4/e9/d1/37/e9d13719-d4eb-0c67-453f-2ad3b339803a/pr_source.lsr/300x300bb.jpg'
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'The Grand Budapest Hotel' AND studio = 'Fox Searchlight');

INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Sci-Fi'
WHERE m.title = 'The Matrix' AND m.studio = 'Warner Bros.'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Action'
WHERE m.title = 'The Matrix' AND m.studio = 'Warner Bros.'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Sci-Fi'
WHERE m.title = 'Inception' AND m.studio = 'Warner Bros.'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Thriller'
WHERE m.title = 'Inception' AND m.studio = 'Warner Bros.'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Animation'
WHERE m.title = 'Toy Story' AND m.studio = 'Pixar'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Action'
WHERE m.title = 'The Dark Knight' AND m.studio = 'Warner Bros.'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Drama'
WHERE m.title = 'The Dark Knight' AND m.studio = 'Warner Bros.'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Comedy'
WHERE m.title = 'The Grand Budapest Hotel' AND m.studio = 'Fox Searchlight'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);

UPDATE movies SET cover_image_url = NULL WHERE cover_image_url LIKE 'https://picsum.photos/%';

INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'Interstellar', 'Paramount Pictures', 2014, NULL
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'Interstellar' AND studio = 'Paramount Pictures');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'Mad Max: Fury Road', 'Warner Bros.', 2015, NULL
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'Mad Max: Fury Road' AND studio = 'Warner Bros.');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'Parasite', 'CJ Entertainment', 2019, NULL
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'Parasite' AND studio = 'CJ Entertainment');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'Spider-Man: Into the Spider-Verse', 'Sony Pictures', 2018, NULL
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'Spider-Man: Into the Spider-Verse' AND studio = 'Sony Pictures');
INSERT INTO movies (title, studio, release_year, cover_image_url)
SELECT 'Knives Out', 'Lionsgate', 2019, NULL
WHERE NOT EXISTS (SELECT 1 FROM movies WHERE title = 'Knives Out' AND studio = 'Lionsgate');

INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Sci-Fi'
WHERE m.title = 'Interstellar' AND m.studio = 'Paramount Pictures'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Action'
WHERE m.title = 'Mad Max: Fury Road' AND m.studio = 'Warner Bros.'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Drama'
WHERE m.title = 'Parasite' AND m.studio = 'CJ Entertainment'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Animation'
WHERE m.title = 'Spider-Man: Into the Spider-Verse' AND m.studio = 'Sony Pictures'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Comedy'
WHERE m.title = 'Knives Out' AND m.studio = 'Lionsgate'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);
INSERT INTO movie_category_map (movie_id, category_id)
SELECT m.id, c.id FROM movies m JOIN movie_categories c ON c.name = 'Thriller'
WHERE m.title = 'Knives Out' AND m.studio = 'Lionsgate'
AND NOT EXISTS (SELECT 1 FROM movie_category_map mcm WHERE mcm.movie_id = m.id AND mcm.category_id = c.id);

UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg'
WHERE title = 'The Matrix' AND studio = 'Warner Bros.';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg'
WHERE title = 'Inception' AND studio = 'Warner Bros.';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg'
WHERE title = 'Toy Story' AND studio = 'Pixar';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/qJ2tW6WMUDux911r6m7haRef0WH.jpg'
WHERE title = 'The Dark Knight' AND studio = 'Warner Bros.';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg'
WHERE title = 'The Grand Budapest Hotel' AND studio = 'Fox Searchlight';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg'
WHERE title = 'Interstellar' AND studio = 'Paramount Pictures';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/hA2ple9q4qnwxp3hKVNhroipsir.jpg'
WHERE title = 'Mad Max: Fury Road' AND studio = 'Warner Bros.';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg'
WHERE title = 'Parasite' AND studio = 'CJ Entertainment';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg'
WHERE title = 'Spider-Man: Into the Spider-Verse' AND studio = 'Sony Pictures';
UPDATE movies SET cover_image_url = 'https://image.tmdb.org/t/p/w342/pThyQovXQrw2m0s9x82twj48Jq4.jpg'
WHERE title = 'Knives Out' AND studio = 'Lionsgate';

UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/fd/4a/77/fd4a77db-0ebc-d043-41a2-f32fa1bb0fb4/dj.qrikkdwj.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/98/96/f6/9896f638-8b47-3f76-c47e-19e43b53677c/mzaf_15900001332254520801.plus.aac.p.m4a'
WHERE title = 'One More Time' AND artist = 'Daft Punk';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/e8/43/5f/e8435ffa-b6b9-b171-40ab-4ff3959ab661/886443919266.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview126/v4/d4/d3/1e/d4d31eb4-7405-b806-8346-3c52ad5b4cf4/mzaf_8095545455942962509.plus.aac.p.m4a'
WHERE title = 'Get Lucky' AND artist = 'Daft Punk';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/a6/6e/bf/a66ebf79-5008-8948-b352-a790fc87446b/19UM1IM04638.rgb.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/17/b4/8f/17b48f9a-0b93-6bb8-fe1d-3a16623c2cfb/mzaf_9560252727299052414.plus.aac.p.m4a'
WHERE title = 'Blinding Lights' AND artist = 'The Weeknd';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/95/fd/b9/95fdb9b2-6d2b-92a6-97f2-51c1a6d77f1a/00602527874609.rgb.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/a6/53/1e/a6531efa-397c-eb73-ecab-9b2790c1471e/mzaf_16440344883389407474.plus.aac.p.m4a'
WHERE title = 'Smells Like Teen Spirit' AND artist = 'Nirvana';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/e7/49/8f/e7498f65-df8f-bead-d6e3-2a8d4d642a79/886447235317.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/85/49/e2/8549e207-7ecf-21a9-7b2f-b414175c6a74/mzaf_10189975321658500285.plus.aac.p.m4a'
WHERE title = 'Sicko Mode' AND artist = 'Travis Scott';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/c3/32/c0/c332c05b-d589-c64f-7ba4-c3633fe75e3f/mzi.uusqmfyq.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/cc/49/99/cc4999b7-b550-cf81-af69-a4c63475fc71/mzaf_10897310118931669841.plus.aac.p.m4a'
WHERE title = 'Take Five' AND artist = 'Dave Brubeck';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/34/8d/c7/348dc71c-d75e-9baf-671a-994e9e74b018/dj.pimdxdmf.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/ee/22/1a/ee221ab0-02dd-7290-47e7-383ad9c81e3b/mzaf_912969547193259322.plus.aac.p.m4a'
WHERE title = 'Around the World' AND artist = 'Daft Punk';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/6c/11/d6/6c11d681-aa3a-d59e-4c2e-f77e181026ab/190295092665.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/59/dc/4d/59dc4dda-93ff-8f1c-c536-f005f6ea6af5/mzaf_3066686759813252385.plus.aac.p.m4a'
WHERE title = 'Levitating' AND artist = 'Dua Lipa';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/ee/28/67/ee286794-6c33-a8c2-5c37-c04f1cb5e8a6/21UM1IM54415.rgb.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/81/a2/33/81a2333c-1a07-0505-5375-2f1aa74ddf8e/mzaf_17607571914784018837.plus.aac.p.m4a'
WHERE title = 'No Role Modelz' AND artist = 'J. Cole';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/80/7b/02/807b023b-fb9e-de08-4c62-dd45d7d2317e/22UMGIM10696.rgb.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/77/ff/fd/77fffdbc-43b6-7d8d-9cc1-b2e957004506/mzaf_1709548897510029754.plus.aac.p.m4a'
WHERE title = 'Come Away With Me' AND artist = 'Norah Jones';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/60/b5/6d/60b56d6e-be3e-fd6c-32df-62ed9fa44c6a/1a2284a9-39d0-4db5-a511-457834a732be.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/86/8f/fd/868ffd10-ec33-726c-af20-ad3ee84a2fd1/mzaf_11660169861219990156.plus.aac.p.m4a'
WHERE title = 'Redbone (Mixed)' AND artist = 'Childish Gambino';
UPDATE songs SET cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/4d/08/2a/4d082a9e-7898-1aa1-a02f-339810058d9e/14DMGIM05632.rgb.jpg/300x300bb.jpg',
    preview_url = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/8f/11/52/8f1152a9-fd5f-0021-f546-b97579c22ec3/mzaf_3962258993076347789.plus.aac.p.m4a'
WHERE title = 'Bohemian Rhapsody' AND artist = 'Queen';
