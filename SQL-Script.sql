--Проект: Анализ продаж интернет магазина (ProstgreSQL)
--Автор: cxber

--(1) Создание схемы БД

create table if not	exists users (
    user_id serial primary key,
    name varchar(50) not null ,
    email varchar(100) unique not null ,
    created_at timestamp default current_timestamp 
);

create table if not exists products (
    product_id serial primary key,
    title varchar(100) not null ,
    category varchar(50) not null,
    price numeric(10, 2) not null
);

create table if not exists orders (
    order_id serial primary key,
    user_id int references users (user_id),
    product_id int references products (product_id),
    quantity int default 1,
    order_date timestamp default current_timestamp 
);

--(2) Заполнение данными

insert into users (name, email) values
('Алексей', 'alex@example.com'),
('Мария', 'maria@example.com'),
('Иван', 'ivan@example.com'),
('Елена', 'elena@example.com');


insert into products (title, category, price) values
('Наушники', 'Электроника', 8390),
('Телефон', 'Электроника', 45300),
('Термос-кружка', 'Товары для дома', 655),
('Игровая клавиатура', 'Электроника', 7200),
('Настольная лампа', 'Товары для дома', 2100);


insert into orders (user_id, product_id, quantity) values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1),
(2, 5, 1),
(4, 3, 4); 

--(3) SQL запросы для анализа

select --клиенты и их заказ
	u.name as customer_name,
	p.title as product_title,
	p.price as product_price,
	o.quantity as ordered_qty
from orders o
join users u on o.user_id = u.user_id 
join products p on o.product_id = p.product_id;

select --какой клиент сколько потратил
	u.name as customer_name,
	SUM(p.price * o.quantity) as total_spent
from orders o
join users u on o.user_id = u.user_id 
join products p on o.product_id = p.product_id
group by u.name
order by total_spent desc;
