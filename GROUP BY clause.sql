# --- GROUP BY clause ---

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;


SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;


# -- ORDER BY --
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC;	# gender in asc, age in desc
							# also ORDER BY age, gender will not sort gender