-- i. Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)

-- Заполняем таблицу profiles
INSERT profiles VALUES (88, 'm', '1991-12-22', NULL, 'Tver', 'Russia');
INSERT profiles VALUES (5, 'f', '1983-02-13', NULL, 'Kursk', 'Russia');
INSERT profiles VALUES (68, 'f', '1993-09-08', NULL, 'Ivanovo', 'Russia');
INSERT profiles VALUES (55, 'f', '1989-10-23', NULL, 'Omsk', 'Russia');
INSERT profiles VALUES (56, 'm', '2013-04-15', NULL, 'Murom', 'Russia');
INSERT profiles VALUES (57, 'f', '2008-11-03', NULL, 'Murmansk', 'Russia');
INSERT profiles VALUES (58, 'f', '1999-12-19', NULL, 'Bor', 'Russia');
INSERT profiles VALUES (59, 'm', '1996-02-11', NULL, 'Moscow', 'Russia');
INSERT profiles VALUES (60, 'f', '2001-10-01', NULL, 'Ekaterinburg', 'Russia');
INSERT profiles VALUES (61, 'f', '2014-07-25', NULL, 'Nigniy Novgorod', 'Russia');
SELECT * FROM profiles;

-- Заполняем таблицу messages
INSERT INTO messages (from_user_id, to_user_id, txt)
VALUES (57, 61, 'Hi!'), 
(60, 59, 'how are you?'),
(55, 88, 'hello'),
(59, 60, 'Im right'),
(5, 1, 'Its a test message'),
(57, 88, 'This is a messge from the bank'),
(60, 59, 'Do you ignore me?'),
(68, 5, 'Check it'),
(60, 57, 'attention'),
(88, 59, 'you mast pay for me');
SELECT * FROM messages;

-- Заполняем таблицу friend_requests
INSERT friend_requests VALUES (88, 57, DEFAULT);
INSERT friend_requests VALUES (59, 5, DEFAULT);
INSERT friend_requests VALUES (88, 59, DEFAULT);
INSERT friend_requests VALUES (61, 60, DEFAULT);
INSERT friend_requests VALUES (61, 88, DEFAULT);
INSERT friend_requests VALUES (57, 59, DEFAULT);
INSERT friend_requests VALUES (68, 88, DEFAULT);
INSERT friend_requests VALUES (55, 56, DEFAULT);
INSERT friend_requests VALUES (55, 59, DEFAULT);
INSERT friend_requests VALUES (5, 60, DEFAULT);
SELECT * FROM friend_requests;

-- заполняем таблицу communities
INSERT communities VALUES (DEFAULT, 'Python', 'Python community', 55);
INSERT communities VALUES (DEFAULT, 'MySQL', 'MySQL community', 88);
INSERT communities VALUES (DEFAULT, 'Django', 'Django community', 59);
INSERT communities VALUES (DEFAULT, 'Java', 'Java community', 5);
INSERT communities VALUES (DEFAULT, 'C#', 'C# community', 60);
INSERT communities VALUES (DEFAULT, 'Go', 'Go community', 57);
INSERT communities VALUES (DEFAULT, 'C++', 'C++ community', 61);
INSERT communities VALUES (DEFAULT, 'Perl', 'Perl community', 68);
INSERT communities VALUES (DEFAULT, 'Ruby', 'Ruby community', 68);
INSERT communities VALUES (DEFAULT, 'Php', 'Php community', 56);
SELECT * FROM communities;

-- заполняем таблицу communities_users
INSERT INTO communities_users (community_id, user_id)
VALUES (3, 5),
(3, 56),
(3, 58),
(4, 60),
(4, 56),
(4, 68),
(4, 5),
(12, 5),
(12, 57),
(12, 88);
SELECT * FROM communities_users;

-- заполняем таблицу media_types
INSERT INTO media_types (name)
VALUES ('таблица'),
('видео'),
('гифка'),
('коллекция'),
('исполняемый файл'),
('архив'),
('база данных');

SELECT * FROM media_types;

-- заполняем таблицу media
INSERT media VALUES (DEFAULT, 57, 'test', 100, 7, DEFAULT);
INSERT media VALUES (DEFAULT, 61, 'test1', 100, 4, DEFAULT);
INSERT media VALUES (DEFAULT, 88, 'test1', 100, 7, DEFAULT);
INSERT media VALUES (DEFAULT, 5, 'test1', 100, 10, DEFAULT);
INSERT media VALUES (DEFAULT, 68, 'test1', 100, 3, DEFAULT);
INSERT media VALUES (DEFAULT, 60, 'test1', 100, 2, DEFAULT);
INSERT media VALUES (DEFAULT, 5, 'test1', 100, 3, DEFAULT);
INSERT media VALUES (DEFAULT, 57, 'test1', 100, 5, DEFAULT);
INSERT media VALUES (DEFAULT, 57, 'test1', 100, 6, DEFAULT);
INSERT media VALUES (DEFAULT, 61, 'test1', 100, 4, DEFAULT);
SELECT * FROM media;

-- заполняем таблицу с постами пользователя
INSERT INTO user_posts (user_id, txt)
VALUES (61, 'some information'), 
(60, 'cookies book'),
(55, 'breacking news'),
(59, 'yellow press'),
(5, 'Its a test post'),
(57, 'I am infinitely good'),
(60, 'life is pain'),
(68, 'no exit'),
(60, 'I go to the restaurant'),
(88, 'my first post about my life');
SELECT * FROM user_posts;

-- заполняем таблицу статусов пользователя
INSERT INTO user_status VALUES (DEFAULT, 'грущу');
INSERT INTO user_status VALUES (DEFAULT, 'скучаю');
INSERT INTO user_status VALUES (DEFAULT, 'на концерте');
INSERT INTO user_status VALUES (DEFAULT, 'гуляю');
INSERT INTO user_status VALUES (DEFAULT, 'на вечеринке');
INSERT INTO user_status VALUES (DEFAULT, 'прокрастинирую');
INSERT INTO user_status VALUES (DEFAULT, 'думаю о');
INSERT INTO user_status VALUES (DEFAULT, 'быть или не быть?');
SELECT * FROM user_status us;