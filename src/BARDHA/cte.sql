-- note common table expression

-- CTE
-- CTE vs SubQuery
-- Recursion
-- PL/SQL Anonmus Block


-- Inline view vs Sub query

SELECT * FROM EMP;
SELECT * FROM BONUS;
SELECT * FROM SALGRADE;
SELECT * FROM DEPT;


-- note For each employee, find how many people are there in their department - inline views

SELECT DEPTNO, count(EMPNO) AS empCount FROM EMP GROUP BY (DEPTNO);

-- inline view
SELECT e.ENAME, empCount FROM EMP e, (SELECT DEPTNO, count(EMPNO) AS empCount FROM EMP GROUP BY (DEPTNO)) d WHERE e.DEPTNO = d.DEPTNO;

-- Using NATURAL JOIN
SELECT e.ENAME, empCount FROM EMP e NATURAL JOIN (SELECT DEPTNO, count(EMPNO) AS empCount FROM EMP GROUP BY (DEPTNO)) d;

SELECT e.ENAME, d.empCount FROM EMP e NATURAL JOIN (SELECT DEPTNO, count(EMPNO) AS empCount FROM EMP GROUP BY (DEPTNO)) d;

-- Using CTE
WITH dept_empCount AS
(SELECT DEPTNO, count(EMPNO) AS empCount FROM EMP GROUP BY (DEPTNO))
SELECT e.ENAME, empCount FROM EMP e NATURAL JOIN dept_empCount;

-- note Modify the above query to also pull out each employees manager name and the number of people in the managers department - inline views

-- Buddha
WITH noeperdept
AS
(SELECT deptno,count(deptno) count FROM EMP GROUP BY DEPTNO)

SELECT e.EMPNO,e.eName,e.deptno,noempsperdept.count noofemps,mg.empno mgr,mg.deptno mgrdeptno,nomgrsperdept.count
FROM emp e
  INNER JOIN noeperdept noempsperdept ON noempsperdept.DEPTNO=e.DEPTNO
  LEFT JOIN Emp mg ON mg.EMPNO=e.MGR
  LEFT JOIN noeperdept nomgrsperdept ON nomgrsperdept.DEPTNO=mg.DEPTNO
;

SELECT * FROM EMP;

SELECT m.MGRNO, m.DEPTNO, d.COUNT FROM
  (SELECT EMPNO AS MGRNO, DEPTNO FROM EMP WHERE EMPNO = any(SELECT DISTINCT MGR FROM EMP)) m,
  (SELECT DEPTNO,count(deptno) AS COUNT FROM EMP GROUP BY DEPTNO) d WHERE m.DEPTNO = d.DEPTNO;
-- SELECT DISTINCT MGR FROM EMP;

-- BIPPI
WITH dept_count AS (
    SELECT deptno, COUNT(*) AS dept_count
    FROM   emp
    GROUP BY deptno)
SELECT e.ename AS employee_name,
       dc1.dept_count AS emp_dept_count,
       m.ename AS manager_name,
       dc2.dept_count AS mgr_dept_count
FROM   emp e,
  dept_count dc1,
  emp m,
  dept_count dc2
WHERE  e.deptno = dc1.deptno
       AND    e.mgr = m.empno
       AND    m.deptno = dc2.deptno;


-- note list departments with above overall average wages
SELECT * FROM DEPT;
SELECT AVG(SAL) FROM EMP;

SELECT DISTINCT DEPTNO, AVG(SAL) OVER(PARTITION BY DEPTNO) AS avgSal FROM EMP;
-- inline
SELECT * FROM (SELECT DISTINCT DEPTNO, AVG(SAL) OVER(PARTITION BY DEPTNO) AS avgSal FROM EMP) d WHERE d.avgSal > (SELECT AVG(SAL) FROM EMP);

-- CTE
WITH
dept_avgsalary AS
(SELECT DISTINCT DEPTNO, AVG(SAL)  OVER(PARTITION BY DEPTNO) AS avg FROM EMP),
emp_avgsalary AS
(SELECT AVG(SAL) AS avg FROM EMP)
SELECT * FROM dept_avgsalary d WHERE d.deptavg > emp_avgsalary.avg;

WITH
dept_avgsalary AS
(SELECT DISTINCT DEPTNO, AVG(SAL)  OVER(PARTITION BY DEPTNO) AS avg FROM EMP),
emp_avgsalary AS
(SELECT AVG(SAL) AS avg FROM EMP)
SELECT * FROM dept_avgsalary d, emp_avgsalary e WHERE d.avg > e.avg;
--

--  Buddha
WITH deptwiseavg AS (SELECT DEPTno,avg(sal) sal
                     FROM EMP
                     GROUP BY DEPTno),
    avg AS (SELECT avg(sal) sal
            FROM EMP)

SELECT d.*, deptwiseavg.sal deptwiseavgsal, avg.sal avgsal
FROM DEPT d
  INNER JOIN deptwiseavg ON d.deptno=deptwiseavg.DEPTNO
  INNER JOIN avg ON deptwiseavg.sal>avg.sal
;
--