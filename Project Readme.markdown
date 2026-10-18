# E-commerce Database Analytics (PostgreSQL)

Практический проект по проектированию реляционной базы данных интернет-магазина и анализу клиентских заказов с помощью **PostgreSQL** и **SQL**.

## 📌 Цели проекта
- Спроектировать реляционную модель данных для базовой e-commerce системы.
- Написать и протестировать DDL-скрипты для создания таблиц и внешних ключей.
- Выполнить аналитические запросы для оценки активности пользователей и расчета финансовых показателей.

## 🛠 Технологии
- **Database:** PostgreSQL
- **SQL Client:** DBeaver
- **Key Concepts:** DDL, DML, INNER JOIN, Aggregate Functions (`SUM`), `GROUP BY`, `ORDER BY`.

---

## 📐 Структура базы данных

База состоит из трех основных таблиц:

1. **`users`** — профили покупателей (`user_id`, `name`, `email`, `created_at`).
2. **`products`** — каталог товаров (`product_id`, `title`, `category`, `price`).
3. **`orders`** — история покупок (`order_id`, `user_id`, `product_id`, `quantity`, `order_date`).

### ER-связи:
- `orders.user_id` $\rightarrow$ `users.user_id` (Many-to-One)
- `orders.product_id` $\rightarrow$ `products.product_id` (Many-to-One)

---

## 🔍 Основные аналитические запросы

### 1. Расчет общих трат каждого клиента
Запрос агрегирует стоимость всех купленных товаров с учетом количества и ранжирует пользователей по сумме чека:

```sql
SELECT 
    u.name AS customer_name,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id
GROUP BY u.name
ORDER BY total_spent DESC;
```

### 2. Детализированная выгрузка заказов
Связывание таблиц для получения подробного отчета по совершенным покупкам:

```sql
SELECT 
    u.name AS customer_name,
    p.title AS product_title,
    p.price AS product_price,
    o.quantity AS ordered_qty
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id;
```

---

## 🚀 Как запустить проект локально
1. Установите PostgreSQL и DBeaver.
2. Создайте новую базу данных.
3. Выполните скрипт из файла `schema_and_queries.sql`.