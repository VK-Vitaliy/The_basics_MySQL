/*
 * Получить список из 5 самых дорогих товаров, указать имя товара, имя каталога и стоимость товара.
 */

SELECT p.name as product_name, c.name as catalog_name, p.price
FROM products p JOIN catalogs c ON p.catalog_id = c.id 
ORDER BY p.price DESC LIMIT 5;


/*
 * Показать последние 10 заказов (сортировка по дате), с указанием номера заказа, наименования, инн и почтового адреса покупателя.
 */

SELECT o.id as order_number, u.name, u.inn, u.email FROM orders o JOIN users u ON o.user_id = u.id 
ORDER BY o.created_at DESC LIMIT 10;


/*
 * Вывести самы популярные товары, купленные в текущем году, с указанием их номера заказа, названия товара и соответствующего каталога, 
 * упорядочив по убыванию количества купленных позиций.
 */

SELECT o.id as order_number, c.name as catalog_name, p.name as product_name, op.total as total_sales, o.created_at as date_order
FROM orders_products op JOIN products p ON op.product_id = p.id 
						 JOIN catalogs c ON p.catalog_id = c.id 
						 JOIN orders o ON op.order_id = o.id 
						 WHERE YEAR(o.created_at) = YEAR(NOW())
ORDER BY op.total DESC;


/*
 * Вывести все заказы, с указанием наименования и количества товарных позиций в каждом заказе.
 */

SELECT op.order_id, p.name, total FROM orders_products op JOIN products p ON op.product_id = p.id GROUP BY op.order_id;