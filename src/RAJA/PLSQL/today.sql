-- CURSOR - > Implicit , Explicit
-- %ISOPEN
-- %FOUND
-- %NOTFOUND
-- %ROWCOUNT

-- note Can only print row count other attributes are boolesan

SET SERVEROUTPUT ON;
DECLARE
  v_empname VARCHAR2(50);
BEGIN
  DBMS_OUTPUT.PUT_LINE(CAST(SQL%ROWCOUNT AS NUMBER ));
  SELECT EMPNAME INTO v_empname FROM EMPLOYEE WHERE EMPNO=1;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
END;
--

DECLARE
  v_empname VARCHAR2(50);
BEGIN
  SELECT EMPNAME INTO v_empname FROM EMPLOYEE WHERE EMPNO=1;
  IF (SQL%FOUND) THEN
      DBMS_OUTPUT.PUT_LINE('SOMETHING');
    ELSE
      DBMS_OUTPUT.PUT_LINE('NOTHING');
  END IF;
END;

-- note before selection isopen, found, notfound = false, rowcount=null
DECLARE
  v_empname VARCHAR2(50);
BEGIN
  IF (SQL%NOTFOUND) THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING');
  ELSE
    DBMS_OUTPUT.PUT_LINE('NOTHING');
  END IF;
END;

-- note CURSOR Phases - declare, open, fetch, close
DECLARE
  CURSOR EMP_CUR
    IS
  SELECT EMPNO, EMPNAME FROM EMPLOYEE;
  v_empno NUMBER(8);
  v_empname VARCHAR(50);
BEGIN
  OPEN EMP_CUR;
  LOOP
    FETCH  EMP_CUR into v_empno, v_empname;
    EXIT when (EMP_CUR%notfound);
    DBMS_OUTPUT.PUT_LINE(v_empname || v_empno);
  END LOOP;
END;

DECLARE
  CURSOR EMP_CUR(v_deptno NUMBER)
  IS
    SELECT EMPNO, EMPNAME FROM EMPLOYEE WHERE DEPTNO=v_deptno;
  v_empno NUMBER(8);
  v_empname VARCHAR(50);
BEGIN
  OPEN EMP_CUR(1);
  LOOP
    FETCH  EMP_CUR into v_empno, v_empname;
    EXIT when (EMP_CUR%notfound);
    DBMS_OUTPUT.PUT_LINE(v_empname || v_empno);
  END LOOP;
  CLOSE EMP_CUR;
END;

DECLARE
  CURSOR EMP_CUR
  IS
    SELECT EMPNO, EMPNAME FROM EMPLOYEE;
BEGIN
  FOR i IN EMP_CUR
  LOOP
    DBMS_OUTPUT.PUT_LINE(i.empname);
  END LOOP;
END;

-- note Dept wala cursor
DECLARE
  CURSOR EMP_CUR(v_deptno EMPLOYEE.DEPTNO%TYPE)
  IS
    SELECT EMPNO, EMPNAME FROM EMPLOYEE WHERE DEPTNO=v_deptno;
BEGIN
  FOR i IN EMP_CUR(1)
  LOOP
    DBMS_OUTPUT.PUT_LINE(i.empname);
  END LOOP;
END;

BEGIN
  FOR i IN (SELECT EMPNO, EMPNAME FROM EMPLOYEE)
  LOOP
    DBMS_OUTPUT.PUT_LINE(i.empname);
  END LOOP;
END;


-- note Assignment
