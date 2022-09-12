-- Задание 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
USE shop;

SELECT name FROM users WHERE id IN (SELECT user_id FROM orders);
SELECT name FROM users JOIN orders WHERE users.id = orders.user_id;


-- Задание 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT name, (SELECT name FROM catalogs WHERE id = products.catalog_id) AS catalogs FROM products WHERE name LIKE 'Inte%';

SELECT products.name, catalogs.name FROM products JOIN catalogs ON catalogs.id = products.catalog_id;

-- Задание 3.
-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;

CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    _from VARCHAR(255),
    _to VARCHAR(255)
);

INSERT INTO flights VALUES
    (NULL, 'moscow', 'anapa'),
    (NULL, 'nigniy novgorod', 'kazan'),
    (NULL, 'vladivostok', 'moscow'),
    (NULL, 'anapa', 'vladivostok'),
    (NULL, 'moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
    label VARCHAR(255),
    name VARCHAR(255)
);

INSERT INTO cities VALUES
    ('moscow', 'Москва'),
    ('vladivostok', 'Владивосток'),
    ('nigniy novgorod', 'Нижний Новгород'),
    ('kazan', 'Казань'),
    ('anapa', 'Анапа');


SELECT 
  id, 
  (SELECT name FROM cities WHERE label = _from) AS flight_from,
  (SELECT name FROM cities WHERE label = _to) AS flight_to
 FROM 
   flights;