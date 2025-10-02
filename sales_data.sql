
mysql> -- Create a new database
mysql> CREATE DATABASE salesdb;
Query OK, 1 row affected (0.18 sec)

mysql>
mysql> -- Use the database
mysql> USE salesdb;
Database changed
mysql>
mysql> -- Create sales table
mysql> CREATE TABLE sales (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     product VARCHAR(50),
    ->     quantity INT,
    ->     price DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.15 sec)

mysql>
mysql> -- Insert sample rows
mysql> INSERT INTO sales (product, quantity, price) VALUES
    -> ('Apples', 10, 2.5),
    -> ('Bananas', 15, 1.2),
    -> ('Oranges', 8, 3.0),
    -> ('Mangoes', 12, 2.8),
    -> ('Grapes', 20, 1.5),
    -> ('Apples', 5, 2.5),
    -> ('Bananas', 7, 1.2),
    -> ('Oranges', 10, 3.0),
    -> ('Mangoes', 6, 2.8),
    -> ('Grapes', 8, 1.5);
Query OK, 10 rows affected (0.04 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT product,
    ->        SUM(quantity) AS total_qty,
    ->        SUM(quantity * price) AS revenue
    -> FROM sales
    -> GROUP BY product;
+---------+-----------+---------+
| product | total_qty | revenue |
+---------+-----------+---------+
| Apples  |        15 |   37.50 |
| Bananas |        22 |   26.40 |
| Oranges |        18 |   54.00 |
| Mangoes |        18 |   50.40 |
| Grapes  |        28 |   42.00 |
+---------+-----------+---------+
5 rows in set (0.07 sec)

mysql>