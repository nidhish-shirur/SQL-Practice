# --- LIMIT and ALIASING ---

# -- LIMIT --
# Top 3 oldest employees
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;		# start at position 2 and take next 1 row


# -- ALIASING --

SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;