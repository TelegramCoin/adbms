DECLARE
  EMP_RECORD EMPLOYEE%ROWTYPE;
  N_MAX_SALARY NUMBER(10);
BEGIN
  SELECT MAX(SALARY) INTO N_MAX_SALARY FROM EMPLOYEE;
  SELECT * INTO EMP_RECORD FROM EMPLOYEE WHERE SALARY = N_MAX_SALARY;
END;
/

-- note transaction within transaction [Autonomous Transaction]

-- note problem with constrants - entire data which already exsists in system has to follow it
-- note Triggers

-- note DML TRIGGER - INSERT , UPDATE, DELETE
-- note timming BEFORE, AFTER, INSTEAD OF (Alternate option)
-- note ROW LEVEL, STMT LEVEL
-- note Autonomous Transaction


-- note RATINA
DROP TABLE log_table;

CREATE TABLE log_table ( source_of_message VARCHAR2(30) NOT NULL, message VARCHAR2(100) NOT NULL, time_of_event DATE DEFAULT SYSDATE);

DROP PROCEDURE p_log_message;

CREATE OR REPLACE PROCEDURE p_log_message (src_of_msg IN VARCHAR, msg IN VARCHAR) AS
PRAGMA AUTONOMOUS_TRANSACTION;
  sql_stmnt VARCHAR(100);
  BEGIN
    sql_stmnt := 'INSERT INTO log_table (source_of_message, message) VALUES (:1 , :2 )';
    execute immediate sql_stmnt USING src_of_msg, msg;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    null;
  END;
/

SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE P_UPDATE_SALARY
AS PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE EMPLOYEE SET SALARY=(SALARY+500) WHERE DEPTNO=10;
    COMMIT;
  END;

BEGIN
  insert into Employee values (10, 'Z', 5000, 10);
  P_UPDATE_SALARY;
  COMMIT;
END;


-- no of employee in dept

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE P_COUNT_EMPLOYEES_IN_DEPT(n_deptno NUMBER, n_count OUT NUMBER)
AS
BEGIN
  SELECT COUNT(EMPNO) INTO n_count FROM EMPLOYEE WHERE DEPTNO=n_deptno;
  INSERT INTO EMPLOYEE values (n_deptno, 'Y', 5000, n_deptno);
  EXECUTE IMMEDIATE 'ALTER TABLE EMPLOYEE ADD STATUS VARCHAR2(30)';
END;

DECLARE
  n_count NUMBER(8);
BEGIN
P_COUNT_EMPLOYEES_IN_DEPT(1, n_count);
DBMS_OUTPUT.put_line(n_count);
END;

-- Temporary table