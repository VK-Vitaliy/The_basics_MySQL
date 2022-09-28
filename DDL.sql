DROP DATABASE IF EXISTS shop_lighting_poles;
CREATE DATABASE IF NOT EXISTS shop_lighting_poles;

USE shop_lighting_poles;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название раздела',
desription TEXT COMMENT 'Описание раздела',
UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
	(DEFAULT, 'Опоры освещения', 'Oпopы для ocвeщeния улиц, дopoг, и мaгиcтpaлeй, двopoв и микpopaйoнoв, тeppитopий шкoл, дeтcaдoв, aвтoзaпpaвoк, плoщaдeй и дpугиx oбъeктoв'),
	(DEFAULT, 'Закладные детали фундаментов', 'Зaклaдныe дeтaли фундaмeнтoв (ЗДФ) пpимeняютcя для уcтaнoвки oпop и мaчт ocвeщeния, a тaкжe мoлниeoтвoдoв и дpугиx выcoтныx мeтaллoкoнcтpукций.'),
	(DEFAULT, 'Кронштейны', 'Kpoнштeйны, oгoлoвники, плeчи, пoпepeчины, кopoны - мeтaллoкoнcтpукции, coeдиняющиe ocвeтитeльнoe oбopудoвaниe (cвeтильники и пpoжeктopы) c oпopoй или мaчтoй.'),
	(DEFAULT, 'Молниеотводы', 'Moлниeoтвoд - выcoтнaя мeтaллoкoнcтpукция, пpeднaнaчeннaя для зaщиты тeppитopий и oбъeктoв oт пoпaдaния мoлний.'),
	(DEFAULT, 'Прожекторные мачты', 'Пpoжeктopныe мaчты - ocoбыe мeтaллoкoнcтpукции, пpeднaзнaчeнныe для уcтaнoвки гaбapитныx ocвeтитeльныx пpибopoв - пpoжeктopoв нa знaчитeльную выcoту.');

DROP TABLE IF EXISTS manufacturer;
CREATE TABLE manufacturer (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL COMMENT 'Наименование',
	UNIQUE unique_name(name(10))
) COMMENT = 'Производители';

INSERT INTO manufacturer VALUES
	(DEFAULT, 'Opora Engineering'),
	(DEFAULT, 'Амира'),
	(DEFAULT, 'Пересвет'),
	(DEFAULT, 'УМЕКОН'),
	(DEFAULT, 'Социнтех-инжиниринг');


DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL COMMENT 'наименование организации',
	inn CHAR(10) NOT NULL UNIQUE CHECK(REGEXP_LIKE(inn, '^[0-9]{10}$')) COMMENT 'ИНН организации',
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL UNIQUE CHECK(REGEXP_LIKE(phone, '^[0-9]{11}$')),
	password_hash CHAR(65) DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users VALUES
	(DEFAULT, 'ООО Новэкс', '5257171536', 'ooo_noveks1@mail.ru', '88312820013', DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'АО АСЭ', '7701186067', 'post@atomstroyexport.ru', '84957379037', DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'АО 345 механический завод', '5001000059', 'Karimov@345mz.ru', '84985217011', DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'ООО СК Авангард', '5019022303', 'somov@citystroy-group.ru', '84994907584', DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'ООО Водоканал Строй Сервис', '0278932221', 'vss_ufa@mail.ru', '89371557346', DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'ООО ИнБиз', '7720293667', 'sales@inbizgroup.ru', '84957600820', DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'ООО БАЗИСЭНЕРГОСНАБ', '4401195153', 'basissnab@yandex.ru', '84942454131', DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'ООО Стратегия', '4401161411', 'strategy44@yandex.ru', '89036342001', DEFAULT, DEFAULT, DEFAULT);


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  	id SERIAL PRIMARY KEY,
  	name VARCHAR(255) NOT NULL COMMENT 'Название',
  	desription TEXT COMMENT 'Описание',
  	serial_number VARCHAR(150) NOT NULL UNIQUE COMMENT 'Код товара',
    manufacturer_id BIGINT UNSIGNED NOT NULL,
  	price DECIMAL (11,2) NOT NULL COMMENT 'Цена',
	catalog_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (catalog_id) REFERENCES catalogs (id),
	FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (id)
) COMMENT = 'Товарные позиции';

INSERT INTO products VALUES
	(DEFAULT, 'НФГ-6.0-05-ц', 'Опора несиловая фланцевая граненая', 'OE-09465', 1, 23824.02, 1),
	(DEFAULT, 'ОГКф-8', 'Опора граненая коническая фланцевая', 'В00000172', 3, 28118.00, 1),
	(DEFAULT, 'ОГКс-10', 'Опора граненая коническая складывающаяся', 'В00004033', 3, 85296.00, 1),
	(DEFAULT, 'ЗДФ-0.159-2.0 (К240-180-4х25)', 'Закладная деталь фундамента', 'В00000210', 3, 8226.00, 2),
	(DEFAULT, 'ЗФ-20/4/К230-2.0-б', 'Деталь фундамента закладная', 'OE-04015', 1, 11742.10, 2),
	(DEFAULT, 'ЗФ-36/12/Д540-3.0-б', 'Деталь фундамента закладная', 'OE-00036', 1, 108587.17, 2),
	(DEFAULT, 'К1К-1.0-1.0-К110/48-0.048-ц', 'Koнcoльный кpoнштeйн', 'В00002728', 3, 3178.00, 3),
	(DEFAULT, '1.К1-1.5-1.0-О2-ц', 'Koнcoльный кpoнштeйн', 'OE-00069', 1, 7145.26, 3),
	(DEFAULT, '1.К2-2.5-2.0-30/-О4-ц', 'Koнcoльный кpoнштeйн', 'OE-00095', 1, 24434.42, 3),
	(DEFAULT, 'МОГК-28.1', 'Молниеотвод граненый конусный', 'СИ.МОГК-28.1.00/2022-КМ-02', 5, 132775.00, 4),
	(DEFAULT, 'МОГК-25-IV-ц', 'Молниеотвод граненый конический', '00-006408', 3, 214780.00, 4),
	(DEFAULT, 'Молниеотвод 2м-К110/76', 'Молниеотвод', '00-003412', 3, 5057.00, 4),
	(DEFAULT, 'МГФ16-СР(150)-III-4-ц', 'Maчтa co cтaциoнapнoй кopoнoй', 'OE-11173', 1, 277889.00, 5),
	(DEFAULT, 'ВМОМ-35.3', 'Высокомачтовая опора с мобильной короной', 'СИ.ВМОМ-35.3.00/2021-КМ-02', 5, 682775.00, 5),
	(DEFAULT, 'ВМОН-30 л/о', 'Bыcoкoмaчтoвая гpaнeная oпopа co cтaциoнapнoй кopoнoй', 'ВМОН-30 л/о', 2, 780000.00, 5);
					
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  	id SERIAL PRIMARY KEY,
  	user_id BIGINT UNSIGNED NOT NULL,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users (id)
) COMMENT = 'Заказы';

INSERT INTO orders VALUES
	(DEFAULT, 1, '2022-10-22 13:02:31', NULL),
	(DEFAULT, 1, '2022-09-12 13:02:31', NULL),
	(DEFAULT, 2, '2022-10-21 13:02:31', NULL),
	(DEFAULT, 2, '2022-10-22 13:02:31', NULL),
	(DEFAULT, 3, '2022-11-28 13:02:31', NULL),
	(DEFAULT, 3, '2021-07-22 13:02:31', NULL),
	(DEFAULT, 3, '2020-12-26 13:02:31', NULL),
	(DEFAULT, 4, '2022-09-01 13:02:31', NULL),
	(DEFAULT, 5, '2022-12-20 13:02:31', NULL);

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  	id SERIAL PRIMARY KEY,
  	order_id BIGINT UNSIGNED NOT NULL,
  	product_id BIGINT UNSIGNED NOT NULL,
  	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  	FOREIGN KEY (order_id) REFERENCES orders (id),
  	FOREIGN KEY (product_id) REFERENCES products (id)
) COMMENT = 'Состав заказа';

INSERT INTO orders_products VALUES
	(DEFAULT, 1, 11, 1),
	(DEFAULT, 2, 6, 1),
	(DEFAULT, 3, 2, 10),
	(DEFAULT, 4, 3, 6),
	(DEFAULT, 5, 7, 25),
	(DEFAULT, 6, 15, 1),
	(DEFAULT, 7, 4, 60),
	(DEFAULT, 8, 1, 12),
	(DEFAULT, 9, 14, 4);

DROP TABLE IF EXISTS product_values;
CREATE TABLE product_values (
	product_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	height INT DEFAULT NULL COMMENT 'высота',
	weight INT DEFAULT NULL COMMENT 'вес',
	material VARCHAR(100) DEFAULT NULL COMMENT 'материал',
	type_of_coverage VARCHAR(100) DEFAULT NULL COMMENT 'покрытие',
	flange VARCHAR(100) DEFAULT NULL COMMENT 'фланец',
	FOREIGN KEY (product_id) REFERENCES products (id)
) COMMENT = 'Характеристики товара';


INSERT INTO product_values VALUES
	(1, 6, 63, 'сталь', 'горячий цинк', '190x190/140'),
	(2, 8, 74, 'сталь', 'горячий цинк', '240x240/180'),
	(3, 10, 190, 'сталь', 'горячий цинк', '280x280/200'),
	(4, 2, 34, 'сталь', 'битумная мастика', '240x240/180'),
	(5, 2, 44, 'сталь', 'битумная мастика', '320x320/230'),
	(6, 3, 271, 'сталь', 'битумная мастика', '640x640/540'),
	(7, 1, 9, 'сталь', 'горячий цинк', '110'),
	(8, 1, 11, 'сталь', 'горячий цинк', '180'),
	(9, 2, 23, 'сталь', 'горячий цинк', '280'),
	(10, 28, 1100, 'сталь', 'горячий цинк', '640(540)');


DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	product_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (product_id) REFERENCES products (id)
) COMMENT = 'Запасы на складе';


INSERT INTO storehouses_products VALUES
	(1, 50, DEFAULT, DEFAULT),
	(2, 50, DEFAULT, DEFAULT),
	(3, 70, DEFAULT, DEFAULT),
	(4, 70, DEFAULT, DEFAULT),
	(5, 44, DEFAULT, DEFAULT),
	(6, 20, DEFAULT, DEFAULT),
	(7, 9, DEFAULT, DEFAULT),
	(8, 11, DEFAULT, DEFAULT),
	(9, 13, DEFAULT, DEFAULT),
	(10, 2, DEFAULT, DEFAULT);

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers  (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL COMMENT 'наименование организации',
	inn CHAR(10) NOT NULL UNIQUE CHECK(REGEXP_LIKE(inn, '^[0-9]{10}$')) COMMENT 'ИНН организации',
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL UNIQUE CHECK(REGEXP_LIKE(phone, '^[0-9]{11}$')),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Поставщики';


INSERT INTO suppliers VALUES
	(1, 'ООО Электропоставка', '7707707132', 'smo6@nnov.russvet.ru', '89202558755', DEFAULT, DEFAULT),
	(2, 'ООО ТПК Энергострой', '6658444535', '104@enestroy.ru', '89939930485', DEFAULT, DEFAULT),
	(3, 'ООО НОРМАСВЕТА', '7719466019', 'lnv@opora-sp.ru', '89687085117', DEFAULT, DEFAULT),
	(4, 'ООО СОЦИНТЕХ-ИНЖИНИРИНГ', '7722356351', 'zmo_fornaks@mail.ru', '88313310052', DEFAULT, DEFAULT),
	(5, 'ООО ПК Городская высота', '5027252614', 'zm@pkgv.ru', '89296321757', DEFAULT, DEFAULT),
	(6, 'ООО Электростарт', '5036098951', 'Kamalova@opora-peresvet.ru', '89260975154', DEFAULT, DEFAULT),
	(7, 'ООО Среднеуральский завод ПРОФИТЭНЕРГО', '6671060440', 'kuraeva-64@mail.ru', '89022741959', DEFAULT, DEFAULT);
	

DROP TABLE IF EXISTS incoming;
CREATE TABLE incoming (
  	id SERIAL PRIMARY KEY,
  	supplier_id BIGINT UNSIGNED NOT NULL,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
) COMMENT = 'Поставка на склад';

INSERT INTO incoming VALUES
	(DEFAULT, 1, DEFAULT, NULL),
	(DEFAULT, 1, DEFAULT, NULL),
	(DEFAULT, 2, DEFAULT, NULL),
	(DEFAULT, 2, DEFAULT, NULL),
	(DEFAULT, 3, DEFAULT, NULL),
	(DEFAULT, 3, DEFAULT, NULL),
	(DEFAULT, 3, DEFAULT, NULL),
	(DEFAULT, 4, DEFAULT, NULL),
	(DEFAULT, 5, DEFAULT, NULL);

DROP TABLE IF EXISTS incoming_goods;
CREATE TABLE incoming_goods (
  	id SERIAL PRIMARY KEY,
  	incoming_id BIGINT UNSIGNED NOT NULL,
  	product_id BIGINT UNSIGNED NOT NULL,
  	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество поступивших товарных позиций',
  	FOREIGN KEY (incoming_id) REFERENCES incoming (id),
  	FOREIGN KEY (product_id) REFERENCES products (id)
) COMMENT = 'поступление товара на склад';

INSERT INTO incoming_goods VALUES
	(DEFAULT, 1, 11, 1),
	(DEFAULT, 2, 6, 1),
	(DEFAULT, 3, 2, 10),
	(DEFAULT, 4, 3, 6),
	(DEFAULT, 5, 7, 25),
	(DEFAULT, 6, 15, 1),
	(DEFAULT, 7, 4, 60),
	(DEFAULT, 8, 1, 12),
	(DEFAULT, 9, 14, 4);


