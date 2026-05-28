# --- CASE Statements ---

SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Middle'
    WHEN age >= 51 THEN 'Old'
END AS age_case
FROM employee_demographics
;


-- < 50000 = 5% bonus
-- >= 50000 = 7% bonus
-- Finance = 10% bonus

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary >= 50000 THEN salary + (salary * 0.07)
END AS new_salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS Bonus
FROM employee_salary
;