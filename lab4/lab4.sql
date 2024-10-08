-- 1. Create database called «lab4»
CREATE DATABASE lab4;

-- 2. Create following tables «Warehouses» and «Boxes»:
CREATE TABLE warehouse (
    code INTEGER PRIMARY KEY,
    location CHARACTER VARYING(255),
    capacity INTEGER
);

-- 3. Download lab4.sql file from intranet. Copy content of the file
-- and run using Query Tool
CREATE TABLE items (
    code CHARACTER(4) PRIMARY KEY,
    contents CHARACTER VARYING(255),
    value REAL,
    warehouse INTEGER,
    FOREIGN KEY (warehouse) REFERENCES warehouse(code)
);

INSERT INTO warehouse (code, location, capacity) VALUES
(1, 'Chicago', 3),
(2, 'Chicago', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'San Francisco', 8);

INSERT INTO items (code, contents, value, warehouse) VALUES
('OMN7', 'Rocks', 180, 3),
('4HRP', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 2),
('7G3H', 'Rocks', 200, 1),
('8NJ6', 'Papers', 75, 3),
('8Y6U', 'Papers', 50, 3),
('9EF7', 'Papers', 175, 1),
('LL08', 'Rocks', 140, 1),
('P0H6', 'Scissors', 125, 4),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);

-- 4. Select all warehouses with all columns.
SELECT * FROM warehouse;

-- 5. Select all boxes with a value larger than $150.
SELECT * FROM items WHERE value > 150;

-- 6. Select all the boxes distinct by contents.
SELECT DISTINCT contents FROM items;

-- 7. Select the warehouse code and the number of the boxes in each warehouse.
SELECT  code, capacity AS number_of_boxes
FROM warehouse
GROUP BY warehouse.code
ORDER BY warehouse.code;

-- 8. Same as previous exercise, but select only those warehouses where the number of the boxes is greater than 2.
SELECT code, SUM(capacity) AS number_of_boxes
FROM warehouse
GROUP BY warehouse.code
HAVING SUM(capacity) > 2
ORDER BY warehouse.code;

-- 9. Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO warehouse (code, location, capacity)
VALUES (6, 'New York', 3);

-- 10. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO items (code, contents, value, warehouse)
VALUES ('H5RT', 'Papers', 200, 2);

-- 11. Reduce the value of the third largest box by 15%.
UPDATE items
SET value = value * 0.85
WHERE code = (
    SELECT code
    FROM items
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
);

-- 12. Remove all boxes with a value lower than $150.
DELETE FROM items
WHERE value < 150
RETURNING *;

-- 13. Remove all boxes which is located in New York. Statement should return all deleted data.
DELETE FROM warehouse
WHERE location = 'New York'
RETURNING warehouse.*;


