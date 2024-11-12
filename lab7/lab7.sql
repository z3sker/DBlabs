CREATE DATABASE lab7;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO countries (name) VALUES
('Kazakhstan'),
('Russia'),
('United States'),
('Germany'),
('France');

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    salary NUMERIC(10, 2),
    department_id INTEGER
);

INSERT INTO employees (name, surname, salary, department_id) VALUES
('John', 'Doe', 50000, 1),
('Jane', 'Smith', 55000, 2),
('Alex', 'Brown', 45000, 1),
('Chris', 'Johnson', 60000, 3),
('Pat', 'Taylor', 70000, 2);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50),
    budget NUMERIC(10, 2)
);

INSERT INTO departments (department_name, budget) VALUES
('IT', 200000),
('Finance', 150000),
('HR', 100000);

-- 1. Create index for queries like: SELECT * FROM countries WHERE name = ‘string’;
CREATE INDEX idx_countries_name ON countries(name);

-- 2. Create index for queries like: SELECT * FROM employees WHERE name = ‘string’ AND surname = ‘string’;
CREATE INDEX idx_employees_name_surname ON employees(name, surname);

-- 3. Create unique index for queries like: SELECT * FROM employees WHERE salary < value1 AND salary > value2;
CREATE UNIQUE INDEX idx_employees_salary_range ON employees(salary);

-- 4. Create index for queries like: SELECT * FROM employees WHERE substring(name from 1 for 4) = ‘abcd’;
CREATE INDEX idx_employees_name_substring ON employees((substring(name from 1 for 4)));

-- 5. Create index for queries like: SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id
-- WHERE d.budget > value2 AND e.salary < value2;
CREATE INDEX idx_departments_budget_employees_salary ON departments(budget) INCLUDE (department_id);
CREATE INDEX idx_employees_salary_department ON employees(salary, department_id);
