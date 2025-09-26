
-- Ecommerce Database for MySQL Workbench

DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  signup_date DATE
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  category VARCHAR(100),
  price DECIMAL(10,2)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  order_date DATE,
  total DECIMAL(10,2),
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);

CREATE TABLE order_items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY(order_id) REFERENCES orders(order_id),
  FOREIGN KEY(product_id) REFERENCES products(product_id)
);

INSERT INTO users (user_id, name, email, signup_date) VALUES
(1,'Asha','asha@example.com','2025-01-05'),
(2,'Ravi','ravi@example.com','2025-02-14'),
(3,'Maya','maya@example.com','2025-03-20'),
(4,'Karan','karan@example.com','2025-04-11');

INSERT INTO products (product_id, name, category, price) VALUES
(1,'Notebook','Stationery',2.50),
(2,'Pen','Stationery',1.20),
(3,'USB Cable','Electronics',5.00),
(4,'Headphones','Electronics',25.00);

INSERT INTO orders (order_id, user_id, order_date, total) VALUES
(1,1,'2025-06-01',10.00),
(2,2,'2025-06-02',30.00),
(3,1,'2025-06-05',15.00),
(4,3,'2025-06-07',25.00),
(5,4,'2025-06-09',0.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
(1,1,1,2,2.50),
(2,2,4,1,25.00),
(3,2,3,1,5.00),
(4,3,2,5,1.20),
(5,4,4,1,25.00);

CREATE OR REPLACE VIEW view_user_revenue AS
SELECT user_id, SUM(total) AS total_spent
FROM orders
GROUP BY user_id;

CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orderitems_product_id ON order_items(product_id);
