#sql commands to use to create a database, add a table and record in the database and grant a user SELECT

CREATE DATABASE mydatabase;
USE mydatabase;
CREATE TABLE mytable (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);
INSERT INTO mytable (id, name, age) VALUES (1, 'John', 30);
GRANT SELECT ON mytable TO 'myuser'@'localhost';
