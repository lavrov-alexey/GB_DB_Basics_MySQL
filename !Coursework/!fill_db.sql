USE db_home_storage;

/*DROP TABLE IF EXISTS objects;
CREATE TABLE objects(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    description VARCHAR(200),
    is_deleted BOOL NOT NULL DEFAULT FALSE
) COMMENT 'Справочник объектов (дом, квартира, гараж, дача)';*/

INSERT INTO objects (name, address) VALUES
    ('Квартира', 'г.Тула, ул.Ф.Энгельса, д.16, кв.330'),
    ('Дача', 'Тул.обл., Ленинский р-н, пос.Хомяково, СНТ "Родник"'),
    ('Квартира бабы Гали', 'г.Тула, ул.Демонстрации, д.10, кв.87'),
    ('Квартира бабы Светы', 'г.Тула, ул.Демонстрации, д.10, кв.87');
    
    
/*DROP TABLE IF EXISTS types_storage;
CREATE TABLE types_storage(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    alias VARCHAR(20) NOT NULL UNIQUE COMMENT 'Краткое название',
    name VARCHAR(100) COMMENT 'Полное наименование',
    is_deleted BOOL NOT NULL DEFAULT FALSE
) COMMENT 'Типы хранилищ';*/

INSERT INTO types_storage (alias, name) VALUES
    ('ШКФ', 'Шкаф'),
    ('КМД', 'Комод'),
    ('АНТР', 'Антресоль'),
    ('СТЛЖ', 'Стеллаж');


/*DROP TABLE IF EXISTS owners;
CREATE TABLE owners(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    alias VARCHAR(30) UNIQUE COMMENT 'Прозвище, позывной',
    first_name VARCHAR(30) NOT NULL,
    second_name VARCHAR(30),
    last_name VARCHAR(30),
    birthday DATE,
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    UNIQUE (first_name, second_name, last_name)
) COMMENT 'Владельцы вещей';*/

INSERT INTO owners (alias, first_name, second_name, last_name, birthday) VALUES
    ('Общее', 'Алексей', 'Александрович', 'Лавров', 1977-11-02),
    ('Папа', 'Алексей', 'Александрович', 'Лавров', 1977-11-02),
    ('Мама', 'Екатерина', 'Павловна', 'Лаврова', 1985-11-07),
    ('Сын', 'Сережа', NULL, 'Лавров', 2012-07-26),
    ('Дочь', 'Маша', NULL, 'Лаврова', 2016-05-31),
    ('Баба Галя', 'Галина', 'Сергеевна', 'Лаврова', 1955-05-27),
    ('Баба Света', 'Светлана', 'Николаевна', 'Кочкина', NULL);


DROP TABLE IF EXISTS storages;
CREATE TABLE storages(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type_storage_id INT UNSIGNED NOT NULL COMMENT 'Тип хранилища',
    object_id INT UNSIGNED NOT NULL COMMENT 'Расположение хранилища',
    owner_id INT UNSIGNED COMMENT 'Владелец хранилища',
    name VARCHAR(80) NOT NULL,
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    UNIQUE (type_storage_id, object_id, owner_id),
    FOREIGN KEY fk_type_storage (type_storage_id) REFERENCES types_storage(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_object_id (object_id) REFERENCES objects(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_owner_id (owner_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE SET NULL
) COMMENT 'Хранилища вещей';

DROP TABLE IF EXISTS cat_things;
CREATE TABLE cat_things(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    alias VARCHAR(20) NOT NULL UNIQUE COMMENT 'Краткое название',
    name VARCHAR(100) NOT NULL COMMENT 'Полное наименование',
    is_deleted BOOL NOT NULL DEFAULT FALSE
) COMMENT 'Категории вещей';

DROP TABLE IF EXISTS cat_sizes;
CREATE TABLE cat_sizes(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    alias VARCHAR(20) NOT NULL UNIQUE COMMENT 'Краткое название',
    rus_size VARCHAR(20) COMMENT 'Русский размер',
    int_size VARCHAR(20) COMMENT 'Международный размер',
    note VARCHAR(200) COMMENT 'Примечание',
    is_deleted BOOL NOT NULL DEFAULT FALSE
) COMMENT 'Справочник размеров одежды, обуви';

DROP TABLE IF EXISTS cat_things_sizes;
CREATE TABLE cat_things_sizes(
    cat_things_id INT UNSIGNED NOT NULL,
    cat_sizes_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (cat_things_id, cat_sizes_id),
    FOREIGN KEY fk_cat_things_id(cat_things_id) REFERENCES cat_things(id),
    FOREIGN KEY fk_cat_sizes(cat_sizes_id) REFERENCES cat_sizes(id)
) COMMENT 'Связь категорий вещей и размеров';

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    rus_name VARCHAR(50) NOT NULL,
    eng_name VARCHAR(50) NOT NULL,
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    UNIQUE (rus_name, eng_name)
) COMMENT 'Каталог производителей';

DROP TABLE IF EXISTS th_statuses;
CREATE TABLE th_statuses(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    status VARCHAR(20) NOT NULL UNIQUE,
    note VARCHAR(100) NOT NULL COMMENT 'Примечание',
    is_deleted BOOL NOT NULL DEFAULT FALSE
) COMMENT 'Статусы вещей';

DROP TABLE IF EXISTS cat_measures;
CREATE TABLE cat_measures(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    rus_msr VARCHAR(50) NOT NULL UNIQUE,
    eng_msr VARCHAR(50) NOT NULL UNIQUE,
    is_deleted BOOL NOT NULL DEFAULT FALSE
) COMMENT 'Справочник единиц измерения';

DROP TABLE IF EXISTS thinks;
CREATE TABLE thinks(
    id SERIAL PRIMARY KEY,
    cat_thing_id INT UNSIGNED COMMENT 'Категория вещи',
    cat_size_id INT UNSIGNED COMMENT 'Размер вещи',
    manufacturer_id INT UNSIGNED COMMENT 'Производитель вещи',
    name VARCHAR(200) NOT NULL COMMENT 'Наименование вещи',
    th_count INT UNSIGNED DEFAULT 0 COMMENT 'Количество',
    cat_measure_id INT UNSIGNED COMMENT 'Единица измерения',
    storage_id INT UNSIGNED COMMENT 'Место хранения',
    th_status_id INT UNSIGNED NOT NULL COMMENT 'Статус вещи',
    owner_id INT UNSIGNED COMMENT 'Владелец',
    date_buy DATE COMMENT 'Дата покупки',
    price_buy INT UNSIGNED COMMENT 'Цена покупки, коп.',
    date_sell DATE COMMENT 'Дата продажи',
    price_sell INT UNSIGNED COMMENT 'Цена продажи, коп.',
    date_next_check DATE COMMENT 'Дата следующей проверки',
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    INDEX thinks_name_idx(name),
    FOREIGN KEY fk_cat_thing_id (cat_thing_id) REFERENCES cat_things(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_cat_size_id (cat_size_id) REFERENCES cat_sizes(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_manufacturer_id (manufacturer_id) REFERENCES manufacturers(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_cat_measure_id (cat_measure_id) REFERENCES cat_measures(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_storage_id (storage_id) REFERENCES storages(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_th_status_id (th_status_id) REFERENCES th_statuses(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_owner_id (owner_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'Таблица вещей';

DROP TABLE IF EXISTS thinks_history;
CREATE TABLE thinks_history(
    think_id BIGINT UNSIGNED NOT NULL,
    changed_at DATETIME DEFAULT NOW() COMMENT 'Дата, время изменения',
    old_cat_thing_id INT UNSIGNED COMMENT 'Старая категория вещи',
    new_cat_thing_id INT UNSIGNED COMMENT 'Новая категория вещи',
    old_cat_size_id INT UNSIGNED COMMENT 'Старый размер вещи',
    new_cat_size_id INT UNSIGNED COMMENT 'Новый размер вещи',
    old_manufacturer_id INT UNSIGNED COMMENT 'Старый производитель вещи',
    new_manufacturer_id INT UNSIGNED COMMENT 'Новый производитель вещи',
    old_name VARCHAR(200) COMMENT 'Старое наименование вещи',
    new_name VARCHAR(200) COMMENT 'Новое наименование вещи',
    old_th_count INT UNSIGNED COMMENT 'Старое кол-во',
    new_th_count INT UNSIGNED COMMENT 'Новое кол-во',
    old_cat_measure_id INT UNSIGNED COMMENT 'Старая единица измерения',
    new_cat_measure_id INT UNSIGNED COMMENT 'Новая единица измерения',
    old_storage_id INT UNSIGNED COMMENT 'Старое место хранения',
    new_storage_id INT UNSIGNED COMMENT 'Новое место хранения',
    old_th_status_id INT UNSIGNED COMMENT 'Старый статус вещи',
    new_th_status_id INT UNSIGNED COMMENT 'Новый статус вещи',
    old_owner_id INT UNSIGNED COMMENT 'Старый владелец',
    new_owner_id INT UNSIGNED COMMENT 'Новый владелец',
    old_date_buy DATE COMMENT 'Старая дата покупки',
    new_date_buy DATE COMMENT 'Новая дата покупки',
    old_price_buy INT UNSIGNED COMMENT 'Старая цена покупки, коп.',
    new_price_buy INT UNSIGNED COMMENT 'Новая цена покупки, коп.',
    old_date_sell DATE COMMENT 'Старая дата продажи',
    new_date_sell DATE COMMENT 'Новая дата продажи',
    price_sell INT UNSIGNED COMMENT 'Цена продажи, коп.',
    old_date_next_check DATE COMMENT 'Старая дата следующей проверки',
    new_date_next_check DATE COMMENT 'Новая дата следующей проверки',
    old_is_deleted BOOL,
    new_is_deleted BOOL,
    PRIMARY KEY think_date_idx(think_id, changed_at),
    FOREIGN KEY fk_think_id (think_id) REFERENCES thinks(id),
    FOREIGN KEY fk_old_cat_thing_id (old_cat_thing_id) REFERENCES cat_things(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_new_cat_thing_id (new_cat_thing_id) REFERENCES cat_things(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_old_cat_size_id (old_cat_size_id) REFERENCES cat_sizes(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_new_cat_size_id (new_cat_size_id) REFERENCES cat_sizes(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_old_manufacturer_id (old_manufacturer_id) REFERENCES manufacturers(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_new_manufacturer_id (new_manufacturer_id) REFERENCES manufacturers(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_old_cat_measure_id (old_cat_measure_id) REFERENCES cat_measures(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_new_cat_measure_id (new_cat_measure_id) REFERENCES cat_measures(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_old_storage_id (old_storage_id) REFERENCES storages(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_new_storage_id (new_storage_id) REFERENCES storages(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_old_th_status_id (old_th_status_id) REFERENCES th_statuses(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_new_th_status_id (new_th_status_id) REFERENCES th_statuses(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_old_owner_id (old_owner_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY fk_new_owner_id (new_owner_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE SET NULL
) COMMENT 'Таблица истории вещей';

DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
    id SERIAL PRIMARY KEY,
    think_id BIGINT UNSIGNED NOT NULL COMMENT 'Ссылка на вещь',
    file_path VARCHAR(260) NOT NULL COMMENT 'Путь к файлу',
    description VARCHAR(300) COMMENT 'Описание к файлу',
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    INDEX think_id_idx (think_id),
    INDEX description_idx (description),
    FOREIGN KEY fk_think_id (think_id) REFERENCES thinks(id) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT 'Фотографии';