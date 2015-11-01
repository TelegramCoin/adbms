SELECT * FROM Employee;

students pair:select distinct s1.sName, s2.sName from (student s1 join student s2 on s1.GPA = s2.GPA and s1.sID < s2.sID);
students name and major:select distinct student.sName, apply.major from (student join Apply on student.sId = apply.sID);


-- raja's class
-- all non aggrate column part of select list should be in group by
-- read about gorup by
-- window function in sql
-- order of processing
-- having  vs where
-- aggregate vs scaler function
-- coalesce vs nvl
-- assignments
-- revice join
-- oracle sequence
-- ** maximum salary emp name each dept **
-- ** remove the repetation **

create table Emp(EMPNO number(8), EMPNAME varchar2(50), SALARY number(8), DEPTNO number(8));

insert into EMP values (1, 'A', 2000, 10);
insert into EMP values (2, 'B', 4000, 10);
insert into EMP values (3, 'C', 3000, 10);
insert into EMP values (4, 'D', 2000, 20);
insert into EMP values (5, 'E', 5000, null);

UPDATE EMP SET EMPNAME = 'A' || EMPNAME;

-- get sum of salary where deptno is not null
-- where don't allow aggregate function but having allows

SELECT DEPTNO,
  SUM(SALARY)
FROM Emp
where DEPTNo is not null
Group By DEPTNO;

SELECT DEPTNO,
  SUM(SALARY)
FROM Emp
Group By DEPTNO
Having SUM(SALARY) > 2000;

SELECT DEPTNO,
  SUM(SALARY)
FROM Emp
Group By DEPTNO
where DEPTNo is not null;

SELECT DEPTNO,
  SUM(SALARY)
FROM Emp;

SELECT DEPTNO, EMPNAME,SUM(SALARY) FROM Emp Group by DEPTNO, EMPNAME;

-- aggregate is not allowed group by class
SELECT DEPTNO, SUM(SALARY)
FROM Emp
Group by SUM(SALARY);

select EMPNAME, SUM(SALARY)
FROM EMP
Group BY EMPNAME;

select SUBSTR(EMPNAME, 1, 1), SUM(SALARY)
FROM EMP
Group BY SUBSTR(EMPNAME, 1, 1);

select count(*)
FROM EMP
Group By DEPTNO;

select DEPTNO, count(DEPTNO)
FROM EMP
Group By DEPTNO;

SELECT 'A' || null from dual;
SELECT AVG(SALARY) from EMP;
SELECT AVG(EMPNAME) from EMP;

SELECT AVG(coalesce(DEPTNO, 0)) FROM Emp;
SELECT AVG(NVL(DEPTNO, 0)) FROM Emp;

SELECT EMPNAME,SALARY from emp where salary in (SELECT Max(salary) from emp group by DEPTNO);

-- get sum of salary where deptno is not null

SELECT E.EMPNAME, MS.MAXSAL FROM EMP E,
  (SELECT DEPTNO, MAX(SALARY) MAXSAL FROM EMP GROUP BY DEPTNO) MS
WHERE (NVL(MS.DEPTNO, 0) = NVL(E.DEPTNO, 0) and MS.MAXSAL = E.SALARY)

--raja problem
--windowing fnction
--analytical function
--different type of joins
--partiition by vs order by
--pagination query
--order by do not garantee the order of records
--what is parsing
--soft and hard parsing
--indexes
--execution plan
--using aggregate with order by
--rank()
--dense_rank()
--** read carefully **

SELECT * from (SELECT empname, deptno, salary, max(salary) over(partition by deptno) maxsal from emp) a where a.maxsal = a.salary;
SELECT * from (SELECT empname, deptno, salary, max(salary) over() maxsal from emp) a where a.maxsal = a.salary;



select empname, salary, max(salary) over(order by empno) from emp;

select * from (select empname, empno, salary, row_number() over (order by empno desc) as rn from emp) where rn between 1 and 2;
select empname, empno, salary, row_number() over (partition by deptno order by empno desc)as rn from emp;

select *
from (
  select empname, empno, salary, row_number()
                                 over (partition by deptno order by salary desc)as rn
  from emp
)
where rn = 1;

select *
from (
  select empname, empno, salary, dense_rank()
                                 over (order by deptno)as rn
  from emp
);

select *
from (
  select empname, empno, salary, rank()
                                 over (partition by deptno order by deptno)as rn
  from emp
);
