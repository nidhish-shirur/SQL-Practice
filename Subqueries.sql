# --- Subqueries: Query within another query ---

SELECT *
FROM employee_demographics
WHERE employee_id IN (
	SELECT employee_id		# over here we can only choose one column
    FROM employee_salary
    WHERE dept_id = 1
);

# -- Subquery in SELECT statement --
SELECT first_name, salary, (
	SELECT AVG(salary)
    FROM employee_salary
)
FROM employee_salary;


SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

# we will use the above in the next part to find average of max ages of males & females
SELECT AVG(`MAX(age)`)
FROM (
	SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
	FROM employee_demographics
	GROUP BY gender
) AS agg_table		# we need to give table name
;