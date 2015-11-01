BEGIN
  NULL;
END;

DECLARE
  message  varchar2(20):= 'Hello, World!';
BEGIN
  dbms_output.put_line('Pooja');
  dbms_output.put_line(message);
END;

/*Hello World*/


SET SERVEROUTPUT ON;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello World');
END;

set serveroutput on size 30000;