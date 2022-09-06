/*
 * Подсчитайте средний возраст пользователей в таблице users.
*/

SELECT round(SUM(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) / COUNT(*), 1) AS middle_age FROM users;