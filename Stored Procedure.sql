# --- Stored Procedure ---
# it is basically like a reusable function

CREATE PROCEDURE large_sal()
SELECT *
FROM employee_salary
WHERE salary > 50000
;

CALL large_sal();

# now the above is a very simple thing, we will actually work on more complex things
# let's use a delimiter (by default it is ; )

DELIMITER $$
CREATE PROCEDURE large_sal2()
BEGIN
	SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
    SELECT *
    FROM employee_salary
    WHERE salary >= 10000;
END $$
DELIMITER ;		# to make the delimiter back to default

CALL large_sal2();

# you can also right click on stored procedures on the left and then choose create like i did for large_sal3()


# -- using parameters --
DELIMITER $$
CREATE PROCEDURE large_sal4(emp_id INT)
BEGIN
	SELECT salary
    FROM employee_salary
    WHERE employee_id = emp_id
    ;
END $$
DELIMITER ;

CALL large_sal4(1);