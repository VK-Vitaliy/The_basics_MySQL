/*
 * Весь товар на складе с указанием его названия, каталога и актуального количества.
 */

CREATE OR REPLACE VIEW v_prod AS
	SELECT p.id, p.name as product, c.name as catalog_name, sp.value FROM storehouses_products sp
	JOIN products p ON sp.product_id = p.id 
	JOIN catalogs c ON p.catalog_id = c.id ;

SELECT * FROM v_prod;

/*
 * Поступивший на склад товар с указанием его названия, каталога, количества поступившего товара, наименования и ИНН поставщика.
 */

CREATE OR REPLACE VIEW inc_prod AS
	SELECT p.name as product, c.name as catalog_name, ig.total, s.name, s.inn FROM incoming i
	JOIN incoming_goods ig ON i.id = ig.incoming_id
	JOIN suppliers s ON i.supplier_id = s.id 
	JOIN products p ON ig.product_id = p.id 
	JOIN catalogs c ON p.catalog_id = c.id; 

SELECT * FROM inc_prod;
