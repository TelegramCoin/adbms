-- note row_number(), rank(), dense_rank()
-- note from each dept highest & lowest salary

SELECT * FROM EMPLOYEE;

SELECT * from (SELECT empname, deptno, salary, max(salary) over(partition by deptno) maxsal from emp) a where a.maxsal = a.salary;

SELECT * from (SELECT empname, deptno, salary, avg(salary) over(partition by deptno) avgsal from emp) a where a.avgsal <= a.salary;

SELECT * from (SELECT empname, deptno, salary, max(salary) over(partition by deptno) maxsal from emp) a where a.maxsal = a.salary;

SELECT * from (SELECT empname, deptno, salary, max(salary) over(partition by deptno) maxsal, min(salary) over(partition by deptno) minsal from emp) a
where a.maxsal = a.salary or a.minsal = a.salary;

SELECT empname, deptno, salary, max(salary) over(partition by deptno) maxsal, min(salary) over(partition by deptno) minsal from emp;

SELECT empname, deptno, salary, avg(salary) over(partition by deptno) avgsal from emp;

SELECT empname, deptno, salary, max(salary) over(order by deptno) maxsal, min(salary) over(partition by deptno) minsal from emp;
-- note didn't get

SELECT empname, deptno, salary, rank() over(partition by deptno order by SALARY DESC ) rank from emp;
SELECT empname, emoid, deptno, salary, dense_rank() over(partition by deptno order by SALARY DESC ) rank from emp;

-- SELECT * (
--   SELECT empname, deptno, salary, rank() over(partition by deptno order by SALARY DESC,
--   dense_rank() over(partition by deptno order by SALARY DESC) rank
--   from emp
-- ) as rankedEmp from where rankedEmp.;


-- note syntax LAG, LEAD

select empname, deptno, EMPno, salary, LAG(SALARY,1) OVER(PARTITION BY deptno ORDER BY empno) from EMP;
select empname, deptno, EMPno, salary, LEAD(SALARY,1) OVER(PARTITION BY deptno ORDER BY empno) from EMP;
select empname, deptno, EMPno, salary, LEAD(SALARY,1) OVER (ORDER BY empno) from EMP;
select empname, deptno, EMPno, salary, first_value(SALARY) OVER (PARTITION BY deptno ORDER BY empno) from EMP;
select empname, deptno, EMPno, salary, last_value(SALARY) OVER (PARTITION BY deptno ORDER BY empno) from EMP;


-- note Why there is difference in behaviour of first & last value-cummulative
-- note 01JAN2015 to 31JAN2015
-- note last values of date

