
-- 1. Create database called "lab6"
CREATE DATABASE lab6;

-- 2. Create following tables:
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

INSERT INTO locations (street_address, postal_code, city, state_province)
VALUES
('123 Main St', '12345', 'Springfield', 'IL'),
('456 Elm St', '67890', 'Gotham', 'NY'),
('789 Oak Ave', '54321', 'Metropolis', 'CA');

INSERT INTO departments (department_name, budget, location_id)
VALUES
('Human Resources', 500000, 1),
('Engineering', 1200000, 2),
('Marketing', 300000, 3);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 75000, 1),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 85000, 2),
('Alice', 'Johnson', 'alice.j@example.com', '345-678-9012', 90000, 2),
('Bob', 'Brown', 'bob.b@example.com', '456-789-0123', 50000, NULL); -- Bob does not have a department


-- 3. Select the first name, last name, department id, and department name for each employee
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 4. Select the first name, last name, department id, and department name, for all employees for departments 80 or 40
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN (80, 40);

-- 5. Select the first and last name, department, city, and state province for each employee
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

-- 6. Select all departments including those where does not have any employee
SELECT d.department_name, e.first_name, e.last_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

-- 7. Select the first name, last name, department id and name, for all employees who have or have not any department
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
