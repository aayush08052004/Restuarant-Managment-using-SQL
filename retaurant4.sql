CREATE TABLE restaurant4_customer (
  customer_id INT PRIMARY KEY,
  name VARCHAR(255),
  number bigint,
  address varchar(225)
);
CREATE TABLE restaurant4_menu (
  menu_id INT PRIMARY KEY,
  item_name VARCHAR(255),
  price DECIMAL(10, 2)
);
CREATE TABLE restaurant4_cart (
  cart_id INT PRIMARY KEY,
  customer_id INT,
  item_id INT,
  quantity INT
);
CREATE TABLE restaurant4_order_details (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10, 2)
);
INSERT IGNORE INTO customer (customer_id, name, number, address)
SELECT customer_id, name, number, address
FROM restaurant4_customer;
select * from restaurant4_customer;
Select * from customer;
INSERT INTO restaurant4_customer (customer_id, name, number, address)
VALUES (2, 'Aditya Ladge',9385354324,'Vashi, Navi Mumbai'), (3, 'Adarsh Pandey',4999274283,'Kandivali ,Mumbai'), (7, 'Jayesh Gawde',3532476842,'Malad, Mumbai');
select * from restaurant4_customer;
INSERT IGNORE INTO customer (customer_id, name, number, address)
SELECT customer_id, name, number, address
FROM restaurant4_customer;
ALTER TABLE restaurant4_menu CHANGE menu_id item_id INT;
INSERT INTO restaurant4_menu (item_id, item_name, price)
VALUES (1, 'Cheese and Corn', 8.99), (2, 'Veg Burger', 14.99);
INSERT INTO restaurant4_cart (cart_id, customer_id, item_id, quantity)
VALUES (2, 2, 2, 1);
INSERT INTO restaurant4_cart (cart_id, customer_id, item_id, quantity)
VALUES (1, 3, 1, 2);
select * from restaurant4_cart;
INSERT INTO combined_cart (customer_id, restaurant_id, item_id, quantity)
SELECT c.customer_id, 4, r4.item_id, r4.quantity
FROM restaurant4_customer c
JOIN restaurant4_cart r4 ON c.customer_id = r4.customer_id;
INSERT INTO restaurant4_order_details (order_id, customer_id, total_amount)
SELECT c.item_id,  c.customer_id, SUM((m.price * c.quantity)) AS total
FROM restaurant4_cart c
JOIN restaurant4_menu m ON c.cart_id = m.item_id
GROUP BY c.item_id, c.customer_id;
select * from restaurant4_order_details;