/*1. Представление (количество сотрудников во всех отделах)*/

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `quantity_of_employees` AS
    SELECT 
        `d`.`dept_name` AS `dept_name`,
        COUNT(`de`.`dept_no`) AS `quantity`
    FROM
        (`dept_emp` `de`
        JOIN `departments` `d` ON ((`d`.`dept_no` = `de`.`dept_no`)))
    WHERE
        (`de`.`to_date` = '9999.01.01')
    GROUP BY `de`.`dept_no`
	
	
	
/*2. Хранимые процедуры. 	Найти менеджера по имени и фамилии (номер сотрудника, отдел)*/


USE `employees`;
DROP procedure IF EXISTS `manager_info`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_info`(IN full_name VARCHAR(255), OUT num INT(11), OUT department VARCHAR(40) )
BEGIN
SELECT 
    dm.emp_no AS 'num', d.dept_name AS 'department'
FROM
    dept_manager dm
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    CONCAT(last_name, ' ', first_name) = full_name;
END$$

DELIMITER ;

/*Вызов процедуры:*/

CALL manager_info('Minakawa Vishwani', @num, @department);
SELECT @num, @department

/* Триггеры */

USE `employees`;

DELIMITER $$

DROP TRIGGER IF EXISTS employees.employees_AFTER_INSERT$$
USE `employees`$$
CREATE DEFINER = CURRENT_USER TRIGGER `employees`.`employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW
BEGIN
INSERT INTO salaries (emp_no, from_date, to_date, salary) VALUES (NEW.emp_no, NEW.hire_date, NEW.hire_date, 10000);
END$$
DELIMITER ;


INSERT INTO employees(emp_no, birth_date, first_name, last_name, gender, hire_date) VALUES (999, '1953-09-12', 'Mary', 'Ten','F', '2020-06-25');
SELECT * FROM salaries WHERE emp_no = 999;
