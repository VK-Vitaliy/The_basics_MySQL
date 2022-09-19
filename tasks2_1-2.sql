/* Задание 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
 * в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 * с 18:00 до 00:00 — "Добрый вечер", 
 * с 00:00 до 6:00 — "Доброй ночи". 
DROP FUNCTION IF EXISTS hello;

DELIMITER //
CREATE FUNCTION hello()
	RETURNS VARCHAR(255) DETERMINISTIC
	BEGIN
		SET @time := DATE_FORMAT(NOW(), '%H');
		CASE
			WHEN @time BETWEEN 0 AND 6 THEN RETURN "Доброй ночи";
			WHEN @time BETWEEN 6 AND 12 THEN RETURN "Доброе утро";
			WHEN @time BETWEEN 12 AND 18 THEN RETURN "Добрый день";
			WHEN @time BETWEEN 18 AND 0 THEN RETURN "Добрый вечер";
		END CASE;
	END//
	
DELIMITER ;

SELECT hello();*/


/* Задание 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. 
 * Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию

DELIMITER //
DROP TRIGGER IF EXISTS check_product_insert//
CREATE TRIGGER check_product_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN  
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;
END//

DELIMITER ;

INSERT INTO products (name, description, price, catalog_id)
VALUES ('AMD Ryzen 5 5600G', NULL, 6000, 1);
INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 6000, 1);
SELECT * FROM products p ;
INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 5500, 2); */


