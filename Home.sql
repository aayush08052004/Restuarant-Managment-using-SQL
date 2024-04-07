CREATE TABLE customer ( customer_id INT PRIMARY KEY, name VARCHAR(255), number bigint, address varchar(225));
CREATE TABLE restaurant ( restaurant_id INT PRIMARY KEY, name VARCHAR(255));  
CREATE TABLE combined_cart ( cart_id INT PRIMARY KEY AUTO_INCREMENT, customer_id INT,
restaurant_id INT, item_id INT, quantity INT, FOREIGN KEY (customer_id) REFERENCES customer(customer_id));
CREATE TABLE combined_order_details (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  restaurant_id INT,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
INSERT INTO combined_order_details (customer_id, restaurant_id, total_amount)
SELECT customer_id, 1 AS restaurant_id, total_amount
FROM restaurant1_order_details;
INSERT INTO combined_order_details (customer_id, restaurant_id, total_amount)
SELECT customer_id, 2 AS restaurant_id, total_amount
FROM restaurant2_order_details;
INSERT INTO combined_order_details (customer_id, restaurant_id, total_amount)
SELECT customer_id, 3 AS restaurant_id, total_amount
FROM restaurant3_order_details;
INSERT INTO combined_order_details (customer_id, restaurant_id, total_amount)
SELECT customer_id, 4 AS restaurant_id, total_amount
FROM restaurant4_order_details;
INSERT INTO combined_order_details (customer_id, restaurant_id, total_amount)
SELECT customer_id, 5 AS restaurant_id, total_amount
FROM restaurant5_order_details;
select * from combined_order_details;
INSERT INTO restaurant (restaurant_id, name)
VALUES (1, 'Restaurant 1'), (2, 'Restaurant 2'), (3, 'Restaurant 3'), (4, 'Restaurant 4'), (5, 'Restaurant 5');
CREATE TABLE restaurant_menu (
  item_id INT PRIMARY KEY AUTO_INCREMENT,
  restaurant_id INT,
  item_name VARCHAR(255),
  price DECIMAL(10, 2),
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id)
);
INSERT INTO restaurant_menu (restaurant_id, item_name, price)
SELECT 1 AS restaurant_id, item_name, price
FROM restaurant1_menu
UNION
SELECT 2 AS restaurant_id, item_name, price
FROM restaurant2_menu
UNION
SELECT 3 AS restaurant_id, item_name, price
FROM restaurant3_menu
UNION
SELECT 4 AS restaurant_id, item_name, price
FROM restaurant4_menu
UNION
SELECT 5 AS restaurant_id, item_name, price
FROM restaurant5_menu;
SELECT c.name, c.number, c.address,
       cod.order_id, cod.restaurant_id, r.name AS restaurant_name,
       m.item_name, cc.quantity, cod.total_amount
FROM customer c
INNER JOIN combined_order_details cod ON c.customer_id = cod.customer_id
INNER JOIN restaurant r ON cod.restaurant_id = r.restaurant_id
INNER JOIN combined_cart cc ON cod.order_id = cc.cart_id
INNER JOIN restaurant_menu m ON cc.item_id = m.item_id
WHERE c.customer_id = 5;
SELECT c.name, c.number, c.address,
       cod.order_id, cod.restaurant_id, r.name AS restaurant_name,
       m.item_name, cc.quantity, cod.total_amount
FROM customer c
INNER JOIN combined_order_details cod ON c.customer_id = cod.customer_id
INNER JOIN restaurant r ON cod.restaurant_id = r.restaurant_id
INNER JOIN combined_cart cc ON cod.order_id = cc.cart_id
INNER JOIN restaurant_menu m ON cc.item_id = m.item_id
WHERE c.name = 'Aayush Singh';
UPDATE restaurant SET name = 'Restaurant 5' WHERE restaurant_id = 3;
SELECT c.name AS customer_name, c.number, c.address,
       cod.order_id, r.name AS restaurant_name,
       m.item_name, cc.quantity, cod.total_amount
FROM customer c
INNER JOIN combined_order_details cod ON c.customer_id = cod.customer_id
INNER JOIN restaurant r ON cod.restaurant_id = r.restaurant_id
INNER JOIN combined_cart cc ON cod.order_id = cc.cart_id
INNER JOIN restaurant_menu m ON cc.item_id = m.item_id
WHERE cod.restaurant_id = 2;
UPDATE customer
SET name = 'Jeet Sharma'
WHERE customer_id = 6;
DELETE FROM combined_order_details WHERE order_id = 3;
select * from combined_order_details;
INSERT INTO restaurant1_cart (cart_id, customer_id, item_id, quantity)
VALUES (3, 2, 2, 3);
INSERT INTO combined_cart (customer_id, restaurant_id, item_id, quantity)
VALUES (2, 1, 2, 3);
INSERT INTO combined_order_details (order_id, customer_id, restaurant_id, total_amount)
VALUES (3, 2, 1, 
    (SELECT SUM((m.price * c.quantity)) 
     FROM restaurant1_cart c 
     JOIN restaurant1_menu m ON c.item_id = m.item_id 
     WHERE c.customer_id = 2 AND c.cart_id = 3)
);
INSERT INTO restaurant1_order_details (order_id, customer_id, total_amount)
VALUES (3, 2, 
    (SELECT SUM((m.price * c.quantity)) 
     FROM restaurant1_cart c 
     JOIN restaurant1_menu m ON c.item_id = m.item_id 
     WHERE c.customer_id = 2 AND c.cart_id = 3)
);
select * from restaurant1_order_details;
select * from combined_order_details;
SELECT c.name, c.number, c.address,
       cod.order_id, cod.restaurant_id, r.name AS restaurant_name,
       m.item_name, cc.quantity, cod.total_amount
FROM customer c
INNER JOIN combined_order_details cod ON c.customer_id = cod.customer_id
INNER JOIN restaurant r ON cod.restaurant_id = r.restaurant_id
INNER JOIN combined_cart cc ON cod.order_id = cc.cart_id
INNER JOIN restaurant_menu m ON cc.item_id = m.item_id
WHERE c.name = 'Aditya Ladge';