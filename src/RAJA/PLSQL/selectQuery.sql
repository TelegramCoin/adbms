
SET SERVEROUTPUT ON;
DECLARE
  v_empNum NUMBER(8)
BEGIN
  SELECT empNum
    INTO v_empNum
    FROM employee
    WHERE empName='A';
  DBMS_OUTPUT.PUT_LINE('empNum is '|| cast(v_empNum as varchar));
END;
/

-- WONT WORK-- ALTER TABLE employee modify empNum VARCHAR2(10);

create table employee_new as (select cast(empNum as VARCHAR(10)) as empNum, empName, salary, deptNum from employee);
select * from employee_new;
drop table employee;

ALTER TABLE employee_new RENAME TO employee;

SET SERVEROUTPUT ON;
DECLARE
  v_empNum NUMBER(8)
BEGIN
  SELECT empNum
    INTO v_empNum
    FROM employee
    WHERE empName='A';
  DBMS_OUTPUT.PUT_LINE('empNum is '|| cast(v_empNum as varchar));
END;
/









