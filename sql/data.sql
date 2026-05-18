INSERT INTO customers VALUES
(1,'Rahul','Chennai'),
(2,'Priya','Bangalore'),
(3,'Amit','Hyderabad'),
(4,'Sneha','Mumbai'),
(5,'Arjun','Delhi');

INSERT INTO menu VALUES
(101,'Burger','Fast Food',120),
(102,'Pizza','Fast Food',250),
(103,'Pasta','Italian',180),
(104,'Coffee','Beverage',90),
(105,'Sandwich','Snack',110),
(106,'Mojito','Beverage',150);

INSERT INTO orders VALUES
(1001,1,'2026-05-01',370),
(1002,2,'2026-05-02',250),
(1003,3,'2026-05-03',300),
(1004,4,'2026-05-03',240),
(1005,5,'2026-05-04',450);

INSERT INTO order_items VALUES
(1,1001,101,1),
(2,1001,104,1),
(3,1002,102,1),
(4,1003,103,1),
(5,1003,104,2),
(6,1004,105,2),
(7,1005,102,1),
(8,1005,106,1);