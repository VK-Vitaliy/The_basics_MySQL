-- Задание 1:
-- Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем 
-- (написал ему сообщений).

SELECT 
	CONCAT(u1.firstname,' ', u1.lastname) AS from_user,
	count(m.from_user_id) AS cnt_message,
	CONCAT(u2.firstname,' ', u2.lastname) AS to_user
FROM messages m JOIN users u1 ON m.from_user_id = u1.id 
JOIN users u2 ON m.to_user_id = u2.id 
WHERE m.to_user_id = 1 GROUP BY m.from_user_id LIMIT 1;


-- Задание 2:
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT
	u.firstname,
	u.lastname, 
	COUNT(pl.user_id)
FROM posts_likes pl JOIN users u ON pl.user_id = u.id
JOIN profiles p ON pl.user_id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10
GROUP BY pl.user_id;


-- Задание 3:
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT
	COUNT(pl.user_id) AS cnt_likes, 
	CASE (gender)
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		ELSE 'not defend'
	END AS gender 
FROM profiles p JOIN posts_likes pl ON p.user_id = pl.user_id
GROUP BY gender
HAVING gender = 'm' OR gender = 'f'
ORDER BY cnt_likes DESC LIMIT 1; 