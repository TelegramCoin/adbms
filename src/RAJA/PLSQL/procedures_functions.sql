-- note Procedure - return no output[In SQL they can] ,steps
-- note function - retuns output

-- note Procedure Syntax
-- CREATE [OR REPLACE] PROCEDURE <pocedure name> [(<param list>)]
-- AS | IS
--    local declareation
-- BEGIN
--    execuable section
-- EXCEPTION
--    exception handling
-- END [<procedure name>];
-- /

-- note param list syntax
-- <param name> IN|OUT|INOUT <datatype.sql> [DEFAULT <value>], .. , ..
-- note param-mode IN|OUT|INOUT
-- note <datatype.sql> Xsize means no size

-- note Why can't we create & alter inside block ?
-- note Do we have functions in oracle ?

-- SHOW ERRORS;

-- note Executing procedure 2 Ways:-
-- 1) EXECUTE <procedure name> [(<param list>)];
-- 2) BEGIN
--      <procedure name> [(<param list>)];
--    END;

SELECT * FROM EMPLOYEE;
CREATE OR REPLACE PROCEDURE print_emp_name (emp_num NUMBER)
  AS
    emp_name VARCHAR2(50);
  BEGIN
    SELECT EMPNAME INTO emp_name FROM EMPLOYEE WHERE EMPNO=emp_num;
    DBMS_OUTPUT.PUT_LINE(emp_name);
END;
/
EXECUTE print_emp_name(1);
EXECUTE print_emp_name(10);

BEGIN
  print_emp_name(1);
END;

CREATE OR REPLACE PROCEDURE P_PRINT_EMPNAME (i_empno IN NUMBER)
AS
  v_empname VARCHAR2(50);
  BEGIN
    SELECT EMPNAME INTO v_empname FROM EMPLOYEE WHERE EMPNO=i_empno;
    DBMS_OUTPUT.PUT_LINE(v_empname);
  END;
/

-- note Any arithmatic operation on NULL is NULL e.g. NULL + 1 = NULL
-- note position matters in params ano
-- note passing params
-- * By position
-- * By Name
-- * Mixture of both

-- note Function Syntax
-- CREATE [OR REPLACE] FUNCTION <function name> [(<param list>)]
-- RETURN <data type>
-- AS | IS
--    local declareation
-- BEGIN
--    execuable section
-- EXCEPTION
--    exception handling
--    return value;
-- END [<function name>];
-- /

-- note SCALAR s, COLLECTION c RETURN TYPE
-- note Function can be used in
-- SELECT ... s
-- FROM ... c
-- WHERE ... s or c

-- note IN - actual param -> formal param
-- note OUT - actual param <- formal param
-- note IN OUT - actual param <-> formal param ,

CREATE OR REPLACE PROCEDURE P_PARAMS_TRY(fist NUMBER, second VARCHAR, third VARCHAR2)
  BEGIN
    DBMS_OUTPUT.PUT_LINE(first)
END

--note Assignment -
--     Create function & use it in SELECT clause
--     Create function & use it in FROM clause
--     Create function & use it in WHERE clause

Using function in SELECT Clause

CREATE OR REPLACE FUNCTION F_APPEND_PREFIX (v_empname IN EMPLOYEE.EMPNAME%TYPE)
  RETURN EMPLOYEE.EMPNAME%TYPE
  AS v_result EMPLOYEE.EMPNAME%TYPE;
BEGIN
  RETURN ('A' ||  v_empname);
END;

SELECT F_APPEND_PREFIX(EMPNAME) AS PREFIXED_EMPLOYEE_NAMES FROM EMPLOYEE;

-- Using function in FROM Clause

