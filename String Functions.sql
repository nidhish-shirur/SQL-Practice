# --- String Functions ---

# -- 1. LENGTH --
SELECT LENGTH('Nidhish');

SELECT first_name, LENGTH(first_name) AS Length
FROM employee_demographics
ORDER BY Length
;

# -- 2. UPPER & LOWER --
SELECT UPPER('sky');
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics
;

# -- 3. TRIM --
SELECT TRIM('        sky          ');
SELECT RTRIM('        sky          ');
SELECT LTRIM('        sky          ');

# -- 4. LEFT, RIGHT, SUBSTRING --
SELECT first_name, 
	LEFT(first_name, 4) AS first_4_chars,
	RIGHT(first_name, 4) AS last_4_chars,
	SUBSTRING(first_name, 3, 2),
    birth_date,
    SUBSTRING(birth_date, 6, 2) AS birth_month 
FROM employee_demographics
;


# -- 5. REPLACE --
SELECT first_name, REPLACE(first_name, 'e', 'z')
FROM employee_demographics
;


# -- 6. LOCATE --
SELECT LOCATE('x', 'Alexander');

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics
;


# -- 7. CONCAT --
SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics
;