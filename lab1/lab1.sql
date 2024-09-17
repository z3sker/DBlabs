-- Создаём базу данных
CREATE DATABASE lab1;

-- 2. Создаём таблицу "users"
CREATE TABLE users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

-- 3. Добавляем столбец "isadmin" интежер типа в "users"
ALTER TABLE users
ADD COLUMN isadmin INTEGER;

-- 4. Меняем тип столбца "isadmin" в булеан
ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN
USING isadmin::BOOLEAN;

-- 5. Делаем значение по умолчанию "isadmin"-а ложным то есть 0
ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT FALSE;

-- 6. Меняем тип "id" столбца на PRIMARY
ALTER TABLE users
ADD CONSTRAINT users_pkey PRIMARY KEY (id);

-- 7. Создаем таблицу "tasks"
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    user_id INTEGER REFERENCES users(id)
);

-- 8. Удаляем "tasks"
DROP TABLE tasks;

-- 9. Удаляем базу данных "lab1"
DROP DATABASE lab1;
