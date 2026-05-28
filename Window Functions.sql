# --- Window Functions ---

# without window function
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;

# with window function
SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

# if we use first_name last_name etc with the GROUP BY function, it will not give correct output:
SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender;


# now instead of AVG we will find SUM using Rolling Total
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;


# to list row number, rank & dense rank
SELECT dem.first_name, dem.last_name, gender, salary,
	ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS Row_No,	# unique
	RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS Rank_No,	# if salary is same, rank is same
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS Dense_Rank_No	# does not skip numbers like in rank it skipped 6
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;