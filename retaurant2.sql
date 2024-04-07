CREATE TABLE restaurant2_customer (
  customer_id INT PRIMARY KEY,
  name VARCHAR(255),
  number bigint,
  address varchar(225)
);
CREATE TABLE restaurant2_menu (
  menu_id INT PRIMARY KEY,
  item_name VARCHAR(255),
  price DECIMAL(10, 2)
);
CREATE TABLE restaurant2_cart (
  cart_id INT PRIMARY KEY,
  customer_id INT,
  item_id INT,
  quantity INT
);
CREATE TABLE restaurant2_order_details (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10, 2)
);
INSERT INTO restaurant2_customer (customer_id, name, number, address)
VALUES (1, 'Aayush Singh',9834537284,'Dahisar, Mumbai'), (2, 'Aditya Ladge',9385354324,'Vashi, Navi Mumbai'), (3, 'Adarsh Pandey',7839204024,'Kandivali ,Mumbai'), (4, 'Krish Surti',5673845932,'Malad, Mumbai'), (5, 'Tanya Sanyal',4582237438,'Hiranandani, Thane'), (6, 'Jeet Jain',4582647283,'Kharghar, Navi Mumbai'), (7, 'Jayesh Gawde',3859304234,'Malad, Mumbai'), (8, 'Vansh Doshi',7838492748,'Mulund, Mumbai');
select * from restaurant2_customer;
INSERT IGNORE INTO customer (customer_id, name, number, address)
SELECT customer_id, name, number, address
FROM restaurant2_customer;
ALTER TABLE restaurant2_menu CHANGE menu_id item_id INT;
INSERT INTO restaurant2_menu (item_id, item_name, price)
VALUES (1, 'Veg Burger', 14.99), (2, 'Chicken Burger 2', 9.99);
INSERT INTO restaurant2_cart (cart_id, customer_id, item_id, quantity)
VALUES (2, 6, 2, 2);
INSERT INTO restaurant2_cart (cart_id, customer_id, item_id, quantity)
VALUES (1, 6, 1, 3);
select * from restaurant2_cart;
INSERT INTO combined_cart (customer_id, restaurant_id, item_id, quantity)
SELECT c.customer_id, 2, r2.item_id, r2.quantity
FROM restaurant2_customer c
JOIN restaurant2_cart r2 ON c.customer_id = r2.customer_id;
INSERT INTO restaurant2_order_details (order_id, customer_id, total_amount)
SELECT c.cart_id, c.customer_id, SUM((m.price * c.quantity)) AS total
FROM restaurant2_cart c
JOIN restaurant2_menu m ON c.item_id = m.item_id
JOIN restaurant2_customer cus ON c.customer_id = cus.customer_id
GROUP BY c.cart_id, c.customer_id;
select * from restaurant2_order_details;