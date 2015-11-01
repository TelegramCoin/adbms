-- note RECORD TYPE - Basically Structure in C , don't hold values

DECLARE
  TYPE EMPLOYEE_TYPE IS RECORD
  (
    REC_EMPNO   NUMBER(8)
    ,REC_EMPNAME VARCHAR(50)
    ,REC_SALARY  NUMBER(8)
    ,REC_DEPTNO  NUMBER(8)
  );

  v_emp_rec EMPLOYEE_TYPE;
BEGIN
  NULL;
END;


--
DECLARE
  CURSOR EMP_CUR
  IS
    SELECT * FROM EMPLOYEE;

  TYPE EMPLOYEE_TYPE IS RECORD
  (
    REC_EMPNO   NUMBER(8)
    ,REC_EMPNAME VARCHAR(50)
    ,REC_SALARY  NUMBER(8)
    ,REC_DEPTNO  NUMBER(8)
  );

  v_emp_rec EMPLOYEE_TYPE;

BEGIN
  OPEN EMP_CUR;
  LOOP
    FETCH  EMP_CUR into v_emp_rec;
    EXIT when (EMP_CUR%notfound);
    DBMS_OUTPUT.PUT_LINE(v_emp_rec.REC_EMPNO);
  END LOOP;
END;

--
DECLARE
  CURSOR EMP_CUR
  IS
    SELECT * FROM EMPLOYEE;
  v_emp_rec EMPLOYEE%ROWTYPE;

BEGIN
  OPEN EMP_CUR;
  LOOP
    FETCH  EMP_CUR into v_emp_rec;
    EXIT when (EMP_CUR%notfound);
    DBMS_OUTPUT.PUT_LINE(v_emp_rec.EMPNO);
  END LOOP;
END;

-- note Loose cursor -


DECLARE
  TYPE REF_EMP_CUR IS REF CURSOR;
  cur_emp REF_EMP_CUR;
  v_emp_rec EMPLOYEE%ROWTYPE;
  v_job_rec JOBS%ROWTYPE;
BEGIN
  OPEN cur_emp FOR SELECT * FROM EMPLOYEE;
  LOOP
    FETCH  cur_emp into v_emp_rec;
    EXIT when (cur_emp%notfound);
    DBMS_OUTPUT.PUT_LINE(v_emp_rec.EMPNO);
  END LOOP;

  OPEN cur_emp FOR SELECT * FROM JOBS;
  LOOP
    FETCH  cur_emp into v_job_rec;
    EXIT when (cur_emp%notfound);
    DBMS_OUTPUT.PUT_LINE(v_job_rec.JOB_ID);
  END LOOP;
END;


-- note [ASS] procedure & function return emp_cursor
-- note [ASS] procedure & function record type returns

UPDATE EMPLOYEE
SET DEPTNO=30
WHERE DEPTNO=NULL;



CREATE OR REPLACE PROCEDURE P_GET_EMP_CUR(ARG_CUR_EMP IN REF CURSOR)
AS
  V_FOO NUMBER(2);
BEGIN
  OPEN ARG_CUR_EMP FOR SELECT * FROM EMPLOYEE;
END;

DECLARE
  CUR_EMP REF CURSOR;
BEGIN
  P_GET_EMP_CUR(CUR_EMP);
END;

declare
  CUR_EMP REF CURSOR;
  procedure P_GET_EMP_CUR( ARG_CUR_EMP IN CURSOR )
  is
  begin
      null;
  end P_GET_EMP_CUR;
begin
  null;
end;