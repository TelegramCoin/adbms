-- 
SELECT * FROM Employee;

DROP TABLE EMPLOYEE_CLONE;

CREATE TABLE EMPLOYEE_CLONE AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_CLONE;

DESCRIBE EMPLOYEE;

CREATE TABLE EMPLOYEE_CLONE AS SELECT CAST(EMPNO AS VARCHAR2(8)) AS EMPNO, EMPNAME, SALARY, DEPTNO FROM EMPLOYEE;

DESCRIBE EMPLOYEE_CLONE;

CREATE TABLE EMPLOYEE_CLONE AS SELECT CONVERT(EMPNO, NUMBER ,VARCHAR2(8)) AS EMPNO, EMPNAME, SALARY, DEPTNO FROM EMPLOYEE);

SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE print_emp_name6 (emp_num NUMBER)
  AS
    emp_name VARCHAR2(50);
  BEGIN
    
    DBMS_OUTPUT.PUT_LINE('pooja');
END;
/
SET SERVEROUTPUT ON;
DECLARE
BEGIN
  print_emp_name6(12); 
END;
/

CREATE OR REPLACE PROCEDURE print_emp_name (emp_num OUT NUMBER)
  AS
    emp_name VARCHAR2(50);
  BEGIN
    SELECT EMPNAME INTO emp_name FROM EMPLOYEE WHERE EMPNO=emp_num;
    DBMS_OUTPUT.PUT_LINE(emp_name);
END;
  /

EXECUTE print_emp_name(1);

BEGIN 
  print_emp_name(1);
END;

CREATE OR REPLACE PROCEDURE P_PRINT_EMPNAME (i_empnum IN VARCHAR2)
AS
  v_empname VARCHAR2(50);
  BEGIN
    i_empnum := i_empnum + 1;
    SELECT EMPNAME INTO v_empname FROM EMPLOYEE WHERE EMPNO=i_empnum;
    DBMS_OUTPUT.PUT_LINE(v_empname);
  END;
/

CREATE OR REPLACE PROCEDURE P_PRINT_EMPNAME (i_empnum OUT VARCHAR2)
AS
  v_empname VARCHAR2(50);
  BEGIN
    i_empnum := i_empnum + 1;
    SELECT EMPNAME INTO v_empname FROM EMPLOYEE WHERE EMPNO=i_empnum;
    DBMS_OUTPUT.PUT_LINE(v_empname);
  END;
/


CREATE OR REPLACE PROCEDURE P_PRINT_EMPNAME (i_empno OUT VARCHAR)
AS
  v_empname VARCHAR2(50);
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Inside procedure' || CAST(i_empno AS NUMBER) || 'END');
    i_empno := 10;
  END;
/

DECLARE
  expectation NUMBER(8);
BEGIN 
  expectation := 23;
  P_PRINT_EMPNAME(expectation);
  DBMS_OUTPUT.PUT_LINE(expectation);
END;

