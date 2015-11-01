SQL
-- DDL
-- DML
-- DCL (GRANT, REVOKE)
-- TCL
-- DQL

CLIENT -> SERVER

For SQL/ Oracle Query
  SQL parser/engine
  -> takes query as INPUT
  -> start parsing mechanism
        * syntax check (throws compilation error)
        * semantics check (logical check) -> Example in where clause using ":=" assignment operator
        * access (user executing the table/view has access to the data or not)
  -> Sending result back to the client.

For PL/SQL Query
  PL/SQL ENGINE
  * Superset on Sql engine
  * syntax, semantics and access CHECK
  * Assign memory to variables
  * Binding of variables to some memory
  * generates PCODE (set of instructions at machine level through which it delegates job to SQL
        and THEN set of operation it performs itself)
  * It will send SQL statement to SQL Parser/Engine
  * SELECT will be executed by SQL engine while variable assignment will be executed by PL/SQL engine
  * Sends data only once to the server and get the response after complete execution

TYPES OF PL/SQL BLOCKS
  ANONYMOUS PL/SQL BLOCK
    BEGIN
      EXECUTION SECTION
    END;
    /

  NAMED BLOCKS (STORED PROCEDURE AND FUNCTIONS)
    META info : Procedure name and valid

DBMS_OUTPUT is PL/SQL package
-- DBMS_OUTPUT.PUT_LINE('someString' || number); //concatenation of str to num cries
CAST and CONVERT COMMAND_FUNCTION
-- DBMS_OUTPUT.PUT_LINE('someString' || cast(number as varchar(n)));