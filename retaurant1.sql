CREATE TABLE restaurant1_customer (
  customer_id INT PRIMARY KEY,
  name VARCHAR(255),
  number bigint,
  address varchar(225)
);
CREATE TABLE restaurant1_menu (
  menu_id INT PRIMARY KEY,
  item_name VARCHAR(255),
  price DECIMAL(10, 2)
);
CREATE TABLE restaurant1_cart (
  cart_id INT PRIMARY KEY,
  customer_id INT,
  item_id INT,
  quantity INT
);
CREATE TABLE restaurant1_order_details (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10, 2)
);
INSERT INTO restaurant1_customer (customer_id, name, number, address)
VALUES (1, 'Aayush Singh',9834537284,'Dahisar, Mumbai'), (2, 'Aditya Ladge',9385354324,'Vashi, Navi Mumbai'), (3, 'Adarsh Pandey',4999274283,'Kandivali ,Mumbai'), (4, 'Krish Surti',5673845932,'Malad, Mumbai'), (5, 'Tanya Sanyal',4582237438,'Hiranandani, Thane'), (6, 'Jeet Jain',4582647283,'Kharghar, Navi Mumbai'), (7, 'Jayesh Gawde',3532476842,'Malad, Mumbai'), (8, 'Vansh Doshi',4567313531,'Mulund, Mumbai');
select * from restaurant1_customer;
ALTER TABLE restaurant1_menu CHANGE menu_id item_id INT;
INSERT IGNORE INTO customer (customer_id, name, number, address)
SELECT customer_id, name, number, address
FROM restaurant1_customer;
INSERT INTO restaurant1_menu (item_id, item_name, price)
VALUES (1, 'Margherita Pizza', 10.99), (2, 'Pepporani Pizza 2', 12.99), (3, 'Corn and Cheese 3', 8.99);
INSERT INTO restaurant1_cart (cart_id, customer_id, item_id, quantity)
VALUES (2, 1, 2, 1);
INSERT INTO restaurant1_cart (cart_id, customer_id, item_id, quantity)
VALUES (1, 1, 1, 2);
select * from restaurant1_cart;
INSERT INTO combined_cart (customer_id, restaurant_id, item_id, quantity)
SELECT c.customer_id, 1, r1.item_id, r1.q uantity
FROM restaurant1_customer c
JOIN restaurant1_cart r1 ON c.customer_id = r1.customer_id;
INSERT INTO restaurant1_order_details (order_id, customer_id, total_amount)
SELECT c.item_id,  c.customer_id, SUM((m.price * c.quantity)) AS total
FROM restaurant1_cart c
JOIN restaurant1_menu m ON c.cart_id = m.item_id
GROUP BY c.item_id, c.customer_id;
select * from restaurant1_order_details;