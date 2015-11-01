DROP TABLE Employee;

create table Employee(empno number(8), empname varchar2(50), salary number(8), deptno number(8));

insert into Employee values (1, 'A', 2000, 1);
insert into Employee values (2, 'B', 4000, 1);
insert into Employee values (3, 'C', 3000, 1);
insert into Employee values (4, 'D', 2000, 2);
insert into Employee values (5, 'E', 5000, null);

COMMIT ;
SELECT * FROM Employee;

