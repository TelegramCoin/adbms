insert into Employee values (5, 'E', 5000, null);
SELECT * FROM EMPLOYEE;

SELECT * FROM V$transaction;
SELECT * FROM V$locks;

--SCN System change numbre

UPDATE EMPLOYEE
SET SALARY=5000
WHERE EMPNAME='J';


Two phase commit
CAP theorom
clusters
horizontal & vertical scaling
latches
distributed systems
hadup
