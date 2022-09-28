/*
 * При создании товара в products автоматически добавлять товар в список складских позиций, общее количество 0. 
 */

DROP TRIGGER IF EXISTS filling_storehouses;
DELIMITER //
CREATE TRIGGER filling_storehouses AFTER INSERT ON products
FOR EACH ROW
BEGIN 
	INSERT INTO storehouses_products (product_id, value) VALUES (NEW.id, 0);
END //
DELIMITER ;

/*
 * Тригер, обновление складских запасов при поступлении товара на склад от поставщиков. 
 */

DROP TRIGGER IF EXISTS refresh_storehouses;
DELIMITER //
CREATE TRIGGER refresh_storehouses AFTER INSERT ON incoming_goods
FOR EACH ROW
BEGIN 
	UPDATE storehouses_products sp INNER JOIN incoming_goods ig ON sp.product_id = ig.product_id SET sp.value = sp.value + NEW.total;
END //
DELIMITER ;

SELECT * FROM storehouses_products sp ;


/*
 * (Процедура) По inn покупателя вывести номера всех его заказов, названия товаров и каталогов и их количество.
 */

DROP PROCEDURE IF EXISTS show_buyer;
DELIMITER //
CREATE PROCEDURE show_buyer(IN inn CHAR(10)) NOT DETERMINISTIC
BEGIN
	DECLARE id_ INT;
	SELECT id INTO id_ FROM users u WHERE u.inn = inn;
	SELECT o.id as order_number, p.name as product, c.name as catalog_name, op.total as count_prod
	FROM orders o JOIN orders_products op ON o.id = op.order_id
				  JOIN products p ON op.product_id = p.id 
				  JOIN catalogs c ON p.catalog_id = c.id
	WHERE o.user_id = id_;
END //
DELIMITER ;

CALL show_buyer('7701186067');