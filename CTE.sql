# --- CTE ---

WITH CTE_eg (Gender, avg_sal, max_sal, min_sal, count_sal) AS
(
SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender 
)
SELECT AVG(avg_sal)
FROM CTE_eg
;


# if we want to do it without CTE
SELECT AVG(avg_sal)
FROM (
	SELECT gender, AVG(salary) AS avg_sal, MAX(salary) AS max_sal, MIN(salary) AS min_sal, COUNT(salary) AS count_sal
	FROM employee_demographics AS dem
	JOIN employee_salary AS sal
		ON dem.employee_id = sal.employee_id
	GROUP BY gender
) AS example_subquery;
# the above is also fine but CTEs are more cleaner to use

# -- using multiple CTEs withing one query --
WITH CTE_eg AS
(
SELECT employee_id, gender, birth_date
FROM employee_demographics AS dem
WHERE birth_date > '1985-1-01'
),
CTE_eg_2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_eg
JOIN CTE_eg_2
	ON CTE_eg.employee_id = CTE_eg_2.employee_id
;