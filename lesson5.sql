/* Примеры транзакций */
/* Добавление нового сотрудника */
SET AUTOCOMMIT = 0;
BEGIN;
INSERT INTO employees VALUE (991, '1966-06-06', 'Mary', 'Manson', 'F', '2020-06-29');
INSERT INTO dept_emp VALUE (991, 'd004', '2020-06-29', '9999-01-01');
INSERT INTO titles VALUE (991,'Engineer', '2020-06-29', '9999-01-01');
INSERT INTO salaries VALUE (991, 15000, '2020-06-30', '2020-06-30');
COMMIT;


/* Перевод сотрудника в другой отдел */

SET AUTOCOMMIT = 0;
BEGIN;
UPDATE dept_emp SET to_date = '2020-07-01' WHERE emp_no = 991 and dept_no = 'd004';
INSERT INTO dept_emp VALUE (991, 'd005', '2020-07-01', '9999-01-01');
UPDATE titles SET to_date = '2020-07-01' WHERE emp_no = 991 and title = 'Engineer';
INSERT INTO titles VALUE (991,'Staff', '2020-07-01', '9999-01-01');
COMMIT;