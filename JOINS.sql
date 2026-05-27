# --- JOINS ---

# -- 1. INNER JOIN --
SELECT *
FROM employee_demographics
JOIN employee_salary	# by default it is INNER JOIN
	ON employee_demographics.employee_id = employee_salary.employee_id	# we specify the table names because both have employee_id so it results in ambiguity error
;

# shorter way by using aliasing
SELECT *
FROM employee_demographics AS dem
JOIN employee_salary AS sal		# by default it is INNER JOIN
	ON dem.employee_id = sal.employee_id	# we specify the table names because both have employee_id so it results in ambiguity error
;



# -- 2. OUTER JOIN --
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal	# LEFT JOIN is by default LEFT OUTER JOIN
	ON dem.employee_id = sal.employee_id
;

SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal	# LEFT JOIN is by default LEFT OUTER JOIN
	ON dem.employee_id = sal.employee_id
;		# for RIGHT JOIN, it will take everything from right table and take the match from left table. if no match then it gives null



# -- 3. SELF JOIN --
SELECT emp1.employee_id AS emp_santa,
	emp1.first_name AS first_name_santa,
    emp1.last_name AS last_name_santa,
    emp2.employee_id AS emp_id,
	emp2.first_name AS first_name_emp,
    emp2.last_name AS last_name_emp
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id		# assigning emp_id + 1 to emp_id
;



# -- 4. Joining multiple tables together --

# we have this parks_departments table
SELECT *
FROM parks_departments;

# now we will join employee salary table with the above table
SELECT *
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments as pd
	ON sal.dept_id = pd.department_id
;