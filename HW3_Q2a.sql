REM Xindi Lan
REM HW3_Q2a_Lan

SET SERVEROUTPUT ON;
DECLARE
employee_start_date DATE;
employee_end_date DATE := SYSDATE;
employee_duration NUMBER;
job_type CHAR;
extra_merit BOOLEAN;
current_salary NUMBER;
bonus NUMBER;

BEGIN
employee_start_date := TRUNC(to_date('1-May-2010'));
job_type := 'A';
extra_merit := FALSE;
current_salary := 55100;
bonus := 0;
employee_duration := ROUND((employee_end_date-employee_start_date)/365);

IF extra_merit=TRUE THEN
    bonus := current_salary*0.05;
END IF;

IF ((employee_duration>=1) AND (employee_duration<=5)) THEN
    bonus := bonus+200;
ELSIF ((employee_duration>=6) AND (employee_duration<=10)) THEN
    bonus := bonus+300;
ELSIF ((employee_duration>=11) AND (employee_duration<=15)) THEN
    bonus := bonus+400;
ELSIF (employee_duration>=16) THEN
    bonus := bonus+500;
END IF;

IF job_type = 'A' THEN
    bonus := bonus+200;
ELSIF job_type = 'B' THEN
    bonus := bonus+300;
END IF;
DBMS_OUTPUT.PUT_LINE('The bonus for this employee is ' || bonus);
END;
/