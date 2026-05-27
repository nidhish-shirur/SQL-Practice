# --- WHERE Clause ---

SELECT *
FROM employee_demographics
WHERE first_name = 'Leslie';


SELECT *
FROM employee_salary
WHERE salary >= 50000;


# -- AND OR NOT -- Logical Operators
# 1. AND
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01' AND gender = 'Male';

# 2. OR
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01' OR gender = 'Male';

# 3. NOT
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01' OR NOT gender = 'Male';

# 4. Together
SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;


# LIKE Statement: % and _
SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%';	# anything before or after

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___';	# starts with 'a'. has exactly 3 chars after 'a'

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';	# starts with 'a', has atleast 3 chars after 'a'

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1985%';	# born only in 1985, then any month or date