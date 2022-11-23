USE db_home_storage;

/*DROP TABLE IF EXISTS owners;
CREATE TABLE owners(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nick_name VARCHAR(30) NOT NULL COMMENT 'Прозвище',
    first_name VARCHAR(30) NOT NULL,
    second_name VARCHAR(30),
    last_name VARCHAR(30),
    birthday DATE,
    phone BIGINT(10) UNSIGNED COMMENT 'Номер телефона 10 знаков без междунар. кода',
    email VARCHAR(80),
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    UNIQUE (nick_name, first_name, second_name, last_name)
) COMMENT 'Владельцы вещей';*/

INSERT INTO owners (nick_name, first_name, second_name, last_name, birthday, phone, email) VALUES
    ('Общее', 'Семья', NULL, 'Лавровых', '2005-08-06', 9991234567, NULL),
    ('Папа', 'Алексей', 'Александрович', 'Лавров', '1977-11-02', 9011234567, 'dad@mail.ru'),
    ('Мама', 'Екатерина', 'Павловна', 'Лаврова', '1985-11-07', 9021234567, 'mom@mail.ru'),
    ('Сын', 'Сережа', NULL, 'Лавров', '2012-07-26', 9031234567, 'son@mail.ru'),
    ('Дочь', 'Маша', NULL, 'Лаврова', '2016-05-31', NULL, NULL),
    ('Баба Галя', 'Галина', 'Сергеевна', 'Лаврова', '1955-05-27', 9981234567, 'grandma_LGS@mail.ru'),
    ('Баба Света', 'Светлана', 'Николаевна', 'Кочкина', NULL, 9971234567, NULL);


/*DROP TABLE IF EXISTS objects;
CREATE TABLE objects(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    owner_id INT UNSIGNED NOT NULL COMMENT 'Владелец объекта',
    name VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    description VARCHAR(200),
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    FOREIGN KEY fk_owner (owner_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'Справочник объектов (дом, квартира, гараж, дача)';*/

INSERT INTO objects (owner_id, name, address) VALUES
    (1, 'Квартира', 'г.Тула, ул.Я.Гашека, д.7, кв.77'),
    (6, 'Дача', 'Тул.обл., Ленинский р-н, пос.Дачный, СНТ "Урожай"'),
    (6, 'Квартира бабы Гали', 'г.Тула, ул.Кр.Партизан, д.10, кв.88'),
    (7, 'Квартира бабы Светы', 'г.Тула, ул.Я.Гашека, д.7, кв.99');


/*DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    object_id INT UNSIGNED NOT NULL COMMENT 'Находится в объекте',
    owner_id INT UNSIGNED COMMENT 'Владелец комнаты',
    name VARCHAR(50) NOT NULL COMMENT 'Полное наименование',
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    FOREIGN KEY fk_object (object_id) REFERENCES objects (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_owner (owner_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'Справочник помещений/комнат в объектах';*/

INSERT INTO rooms (object_id, owner_id, name) VALUES
    (1, 1, 'Прихожая'),
    (1, 1, 'Кухня'),
    (1, 4, 'Сережина комната'),
    (1, 5, 'Машина комната'),
    (1, 1, 'Зал'),
    (1, 1, 'Спальня'),
    (1, 1, 'Ванная'),
    (1, 1, 'Туалет'),
    (1, 1, 'Балкон-лоджия'),
    (2, 6, 'Дача, мал. комната'),
    (2, 6, 'Дача, бол. комната'),
    (2, 6, 'Дача, чердак'),
    (2, 6, 'Сарай'),
    (3, 6, 'Прихожая/коридор'),
    (3, 6, 'Кухня'),
    (3, 6, 'Зал'),
    (3, 6, 'Спальня'),
    (3, 6, 'Ванная'),
    (3, 6, 'Туалет'),
    (3, 6, 'Кладовка'),
    (3, 6, 'Балкон-лоджия'),
    (4, 7, 'Прихожая'),
    (4, 7, 'Зал/кухня'),
    (4, 7, 'Спальня'),
    (4, 7, 'Кладовка'),
    (4, 7, 'Ванная/туалет'),
    (4, 7, 'Балкон-лоджия');
        

/*DROP TABLE IF EXISTS types_storage;
CREATE TABLE types_storage(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    alias VARCHAR(20) NOT NULL UNIQUE COMMENT 'Краткое название',
    name VARCHAR(100) COMMENT 'Полное наименование',
    is_deleted BOOL NOT NULL DEFAULT FALSE
) COMMENT 'Типы хранилищ';*/

INSERT INTO types_storage (name) VALUES
    ('Шкаф'),
    ('Шкаф-купе'),
    ('Встроенный шкаф'),
    ('Навесной шкаф'),
    ('Угловой шкаф'),
    ('Сервант'),
    ('Комод'),
    ('Тумба'),
    ('Антресоль'),
    ('Стеллаж'),
    ('Кровать'),
    ('Диван'),
    ('Хранилище');


/*DROP TABLE IF EXISTS storages;
CREATE TABLE storages(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type_storage_id INT UNSIGNED NOT NULL COMMENT 'Тип хранилища',
    room_id INT UNSIGNED NOT NULL COMMENT 'Нахождение в помещении',
    name VARCHAR(50) NOT NULL,
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    UNIQUE (room_id, name),
    FOREIGN KEY fk_type_storage (type_storage_id) REFERENCES types_storage(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY fk_room (room_id) REFERENCES rooms(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'Хранилища вещей (шкафы, стеллажи и т.д.)';*/

INSERT INTO storages (type_storage_id, room_id, name) VALUES
    (2, 1, 'Шкаф в прихожей'),
    (8, 1, 'Белая тумбочка для сидения'),
    (3, 2, 'Хоз. шкаф'),
    (4, 2, 'Шкафчик над холодильником'),
    (4, 2, 'Шкаф над столешницей слева'),
    (4, 2, 'Шкаф-сервант над столешницей'),
    (4, 2, 'Шкаф над раковиной'),
    (5, 2, 'Шкаф над столешницей справа'),
    (4, 2, 'Шкафчик над вар. поверхностью'),
    (5, 2, 'Крайний шкафчик над столешницей'),
    (8, 3, 'Встроенная тумба в комп. столе'),
    (1, 3, 'Пенал слева от кровати'),
    (1, 3, 'Шкафчик-стеллаж над кроватью'),
    (1, 3, 'Пенал справа от кровати'),
    (5, 3, 'Бол. угловой шкаф'),
    (1, 3, 'Пенал справа от углового'),
    (1, 3, 'Полуоткрытый шкаф справа'),
    (11, 3, 'Выкатное хранилище под кроватью'),
    (7, 4, 'Большой комод'),
    (1, 4, 'Платяной шкаф'),
    (10, 4, 'Открытый стеллаж'),
    (1, 5, 'Полуоткрытый шкафч-тумба слева от ТВ'),
    (8, 5, 'Тумба под ТВ'),
    (6, 5, 'Шкаф-сервант справа от ТВ'),
    (8, 5, 'Выкатная тумба компьютерного стола'),
    (12, 5, 'Хранилище под диваном'),
    (1, 6, 'Зеркальный шкаф слева'),
    (5, 6, 'Большой угловой шкаф'),
    (8, 6, 'Прикроватная тумбочка слева'),
    (8, 6, 'Прикроватная тумбочка справа'),
    (4, 7, 'Шкафчик над раковиной'),
    (13, 7, 'Свободное место под ванной'),
    (3, 8, 'Хоз. шкаф за унитазом'),
    (1, 9, 'Шкаф слева'),
    (1, 9, 'Шкаф справа'),
    (8, 10, 'Кухонная тумбочка'),
    (1, 11, 'Платяной шкаф'),
    (1, 11, 'Пенал'),
    (7, 11, 'Комод'),
    (13, 12, 'Чердак в целом'),
    (10, 13, 'Чердак в целом'),
    (1, 14, 'Большой платяной шкаф'),
    (9, 14, 'Встроенная над проходом в кухню'),
    (4, 15, 'Шкаф над раковиной'),
    (4, 15, 'Шкаф над столешницей слева'),
    (4, 15, 'Шкаф-сервант над столешницей справа'),
    (1, 16, 'Шкаф слева от ТВ'),
    (1, 16, 'Шкаф-сервант справа от ТВ'),
    (8, 16, 'Встроенная тумбочка комп. стола'),
    (1, 17, 'Платяной шкаф'),
    (7, 17, 'Комод'),
    (7, 20, 'Стеллажи слева'),
    (1, 21, 'Хоз. шкаф'),
    (3, 22, 'Встроенный шкаф-купе'),
    (1, 23, 'Шкаф слева от ТВ'),
    (1, 23, 'Шкаф-стеллаж для ТВ'),
    (6, 23, 'Шкаф-сервант справа от ТВ'),
    (3, 24, 'Встроенный шкаф'),
    (13, 25, 'Кладовка-хранилище');


/*DROP TABLE IF EXISTS sub_storages;
CREATE TABLE sub_storages(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    storage_id INT UNSIGNED NOT NULL COMMENT 'Нахождение в хранилище',
    owner_id INT UNSIGNED COMMENT 'Владелец элемента в хранилище',
    name VARCHAR(100) COMMENT 'Наименование ',
    is_deleted BOOL NOT NULL DEFAULT FALSE,
    UNIQUE (storage_id, name),
    FOREIGN KEY fk_owner_id (owner_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT 'Элементы хранилищ (полки, отделения и т.д.)';*/

INSERT INTO sub_storages (storage_id,  owner_id, name) VALUES
    ('ТМБ1', 'Тумба 1'),
    ('ТМБ2', 'Тумба 2'),
    ('ПКС1', 'Полка стекляная 1'),
    ('ПКС2', 'Полка стекляная 2'),
    ('ПКС3', 'Полка стекляная 3'),
    ('ПКС4', 'Полка стекляная 4'),
    ('ПКС5', 'Полка стекляная 5'),
    ('ПКС6', 'Полка стекляная 6'),
    ('ПЛК1', 'Полка 1'),
    ('ПЛК1', 'Полка 2'),
    ('ПЛК1', 'Полка 3'),
    ('ПЛК1', 'Полка 4'),
    ('ПЛК1', 'Полка 5'),
    ('ПЛК1', 'Полка 6'),
    ('ЯЩК1', 'Ящик 1'),
    ('ЯЩК2', 'Ящик 2'),
    ('ЯЩК3', 'Ящик 3'),
    ('ЯЩК4', 'Ящик 4'),
    ('ЯЩК5', 'Ящик 5'),
    ('ЯЩК6', 'Ящик 6'),
    ('АНТР1', 'Антресоль 1'),
    ('АНТР2', 'Антресоль 2'),
    ('ШТН1', 'Штанга для одежды 1'),
    ('ШТН2', 'Штанга для одежды 2'),
    ('ОТД1', 'Отделение 1'),
    ('ОТД2', 'Отделение 2'),
    ('КНТ1', 'Контейнер 1'),
    ('КНТ2', 'Контейнер 2'),
    ('КНТ3', 'Контейнер 3'),
    ('КНТ4', 'Контейнер 4');










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