-- Задание 1:
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT 
	(SELECT firstname FROM users WHERE id = from_user_id) AS from_user_id, 
	count(from_user_id) AS cnt_message, 
	(SELECT firstname FROM users WHERE id = to_user_id) AS to_user_id
FROM messages WHERE to_user_id = 1 GROUP BY from_user_id LIMIT 1; 


-- Задание 2:
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT 
	user_id,
	(SELECT firstname FROM users WHERE id = user_id) AS name, 
	count(user_id) AS cnt_likes 
FROM posts_likes WHERE user_id IN (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10) GROUP BY user_id; 


-- Задание 3:
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT
	COUNT(gender) AS cnt_likes, 
	(SELECT 
			CASE(gender)
				WHEN 'm' THEN 'male'
				WHEN 'f' THEN 'female'
				WHEN 'x' THEN 'not defined'
			END) AS gender 
	FROM profiles WHERE user_id IN (SELECT user_id FROM posts_likes) GROUP BY gender ORDER BY cnt_likes DESC;


