-- Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)


-- создадим таблицу с постами пользователя
CREATE TABLE user_posts(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users (id),
)

-- создаим таблицу статусов пользователя
CREATE TABLE user_status(
	id INT AUTO_INCREMENT PRIMARY KEY,
	status VARCHAR(50) NOT NULL UNIQUE
); 

INSERT INTO media_types VALUES (DEFAULT, 'дома');
INSERT INTO media_types VALUES (DEFAULT, 'на работе');
INSERT INTO media_types VALUES (DEFAULT, 'в отпуске');
INSERT INTO media_types VALUES (DEFAULT, 'учусь');
INSERT INTO media_types VALUES (DEFAULT, 'читаю');

-- создаим таблицу для добавления в черный список
CREATE TABLE black_list(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	blocked_user_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, blocked_user_id),
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (locked_user_id) REFERENCES users (id)
)
