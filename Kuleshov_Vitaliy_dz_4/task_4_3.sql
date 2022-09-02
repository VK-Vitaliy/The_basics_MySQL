-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
ALTER TABLE profiles ADD COLUMN is_active TINYINT(1) DEFAULT TRUE;
UPDATE profiles SET is_active = FALSE WHERE TIMESTAMPDIFF(YEAR, birthday, curdate()) < 18;
SELECT * FROM profiles WHERE is_active = FALSE;