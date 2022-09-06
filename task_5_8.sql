/*
 * Подсчитайте произведение чисел в столбце таблицы
*/

DROP TABLE IF EXISTS example_table;
CREATE TABLE example_table(
     value bigint
);
insert example_table values (1), (2), (3), (4), (5);

SELECT * FROM example_table;

select exp(sum(ln(value))) from example_table;