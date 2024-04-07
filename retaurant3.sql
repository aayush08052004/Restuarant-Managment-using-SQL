CREATE TABLE restaurant3_customer (
  customer_id INT PRIMARY KEY,
  name VARCHAR(255),
  number bigint,
  address varchar(225)
);
CREATE TABLE restaurant3_menu (
  menu_id INT PRIMARY KEY,
  item_name VARCHAR(255),
  price DECIMAL(10, 2)
);
CREATE TABLE restaurant3_cart (
  cart_id INT PRIMARY KEY,
  customer_id INT,
  item_id INT,
  quantity INT
);
CREATE TABLE restaurant3_order_details (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10, 2)
);
INSERT IGNORE INTO customer (customer_id, name, number, address)
SELECT customer_id, name, number, address
FROM restaurant3_customer;
INSERT INTO restaurant3_customer (customer_id, name, number, address)
VALUES (1, 'Aayush Singh',8956783924,'Borivali, Mumbai'), (4, 'Krish Surti',5673845932,'Malad, Mumbai'), (5, 'Tanya Sanyal',4582237438,'Hiranandani, Thane'), (6, 'Jeet Jain',4582647283,'Kharghar, Navi Mumbai'), (7, 'Jayesh Gawde',3532476842,'Malad, Mumbai'), (8, 'Vansh Doshi',4567313531,'Mulund, Mumbai');
select * from restaurant3_customer;
ALTER TABLE restaurant3_menu CHANGE menu_id item_id INT;
INSERT INTO restaurant3_menu (item_id, item_name, price)
VALUES (1, 'Garlic Bread', 7.99), (2, 'Farmhouse Pizza', 11.99), (3, 'Zinger Burger', 9.99);
INSERT INTO restaurant3_cart (cart_id, customer_id, item_id, quantity)
VALUES (8, 4, 2, 1);
INSERT INTO restaurant3_cart (cart_id, customer_id, item_id, quantity)
VALUES (5, 7, 3, 2);
select * from restaurant3_cart;
INSERT INTO combined_cart (customer_id, restaurant_id, item_id, quantity)
SELECT c.customer_id, 3, r3.item_id, r3.quantity
FROM restaurant3_customer c
JOIN restaurant3_cart r3 ON c.customer_id = r3.customer_id;
INSERT Into restaurant3_order_details (order_id, customer_id, total_amount)
SELECT c.cart_id, cus.customer_id, SUM(c.quantity * m.price) AS total
FROM restaurant3_cart c
JOIN restaurant3_menu m ON c.item_id = m.item_id
JOIN restaurant3_customer cus ON c.customer_id = cus.customer_id
GROUP BY c.cart_id, cus.customer_id;
select * from restaurant3_order_details;