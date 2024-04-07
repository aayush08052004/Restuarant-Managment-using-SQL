CREATE TABLE restaurant5_customer (
  customer_id INT PRIMARY KEY,
  name VARCHAR(255),
  number bigint,
  address varchar(225)
);
CREATE TABLE restaurant5_menu (
  menu_id INT PRIMARY KEY,
  item_name VARCHAR(255),
  price DECIMAL(10, 2)
);
CREATE TABLE restaurant5_cart (
  cart_id INT PRIMARY KEY,
  customer_id INT,
  item_id INT,
  quantity INT
);
CREATE TABLE restaurant5_order_details (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10, 2)
);
INSERT INTO restaurant5_customer (customer_id, name, number, address)
VALUES (1, 'Aayush Singh',9834537284,'Dahisar, Mumbai'), (5, 'Tanya Sanyal',4582237438,'Hiranandani, Thane'), (6, 'Jeet Jain',4582647283,'Kharghar, Navi Mumbai');
select * from restaurant5_customer;
ALTER TABLE restaurant5_menu CHANGE menu_id item_id INT;
INSERT INTO restaurant5_menu (item_id, item_name, price)
VALUES (1, 'Garlic Bread', 7.99), (2, 'Margherita Pizza', 10.99), (3, 'Farmhouse Pizza', 11.99);
INSERT INTO restaurant5_cart (cart_id, customer_id, item_id, quantity)
VALUES (2, 1, 1, 1);
INSERT into restaurant5_cart (cart_id, customer_id, item_id, quantity)
VALUES (3, 5, 3, 2);
select * from restaurant5_cart;
INSERT INTO combined_cart (customer_id, restaurant_id, item_id, quantity)
SELECT c.customer_id, 5, r5.item_id, r5.quantity
FROM restaurant5_customer c
JOIN restaurant5_cart r5 ON c.customer_id = r5.customer_id;
select * from restaurant5_cart;
INSERT INTO restaurant5_order_details (order_id, customer_id, total_amount)
SELECT c.item_id,  c.customer_id, SUM((m.price * c.quantity)) AS total
FROM restaurant5_cart c
JOIN restaurant5_menu m ON c.cart_id = m.item_id
GROUP BY c.item_id, c.customer_id;
select * from restaurant5_order_details;