USE shop;
/* Задание 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
 * Используйте транзакции. */

START TRANSACTION;
DELETE FROM sample.users WHERE sample.users.id = 1;
INSERT INTO sample.users SELECT * FROM shop.users WHERE shop.users.id = 1;
COMMIT;

/* Задание 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
 * и соответствующее название каталога name из таблицы catalogs. */


CREATE VIEW prod_name AS 
SELECT 
	p.name AS product_name,
	c.name AS catalog_name
FROM products p JOIN catalogs c ON p.catalog_id = c.id;
	
SELECT * FROM prod_name;

/* Задание 3.
 * Пусть имеется таблица с календарным полем created_at. 
 * В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 * Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
 * если дата присутствует в исходном таблице и 0, если она отсутствует. */

DROP PROCEDURE IF EXISTS FillCalendar;
DROP TABLE IF EXISTS calendar;
CREATE TABLE IF NOT EXISTS calendar(calendar_date DATE NOT NULL PRIMARY KEY);

DELIMITER //
    CREATE PROCEDURE FillCalendar(start_date DATE, end_date DATE)
    BEGIN
    DECLARE crt_date DATE;
    SET crt_date = start_date;
    WHILE crt_date <= end_date DO
        INSERT IGNORE INTO calendar VALUES(crt_date);
        SET crt_date = ADDDATE(crt_date, INTERVAL 1 DAY);
    END WHILE;
    END//
DELIMITER ;

CALL FillCalendar('2018-08-01', '2018-08-31');

DROP TABLE IF EXISTS dates;
CREATE TABLE dates (
	created_at DATE NOT NULL
);

INSERT INTO dates (created_at) VALUES ('2018-08-01'), ('2016-08-04'), ('2018-08-16'), ('2018-08-17');

SELECT
	calendar.calendar_date ,
	CASE 
		WHEN dates.created_at IS NULL THEN '0'
		ELSE '1'
	END AS value
FROM calendar 
LEFT JOIN dates ON (
calendar.calendar_date = dates.created_at); 



/* Задание 4. Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/

USE vk;
PREPARE del_messages from "DELETE FROM messages ORDER BY created_at LIMIT ?";
SET @ROWS = (SELECT COUNT(*)-5 FROM messages);
EXECUTE del_messages USING @ROWS;

SELECT * FROM messages m  ORDER BY created_at DESC;