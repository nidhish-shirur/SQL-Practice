# --- SELECT Statement ---

SELECT *
FROM parks_and_recreation.employee_demographics;


SELECT first_name
FROM parks_and_recreation.employee_demographics;


SELECT first_name, last_name, birth_date, age
FROM parks_and_recreation.employee_demographics;


# with age + 10
SELECT first_name, last_name, birth_date, age, age + 10
FROM parks_and_recreation.employee_demographics;


# --- using DISTINCT ---
# without:
SELECT gender
FROM parks_and_recreation.employee_demographics;

# with:
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

# if we have 2 columns, it will group and it give unique values for both together
SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;