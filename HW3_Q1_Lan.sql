--start D:\hw3\DreamHome_Tables.sql;
--start D:\hw3\Northwoods.txt;

REM Xindi Lan
REM HW3_Q1_Lan

SET SERVEROUTPUT ON;
DECLARE
Pi number :=3.1415926;
Current_radius number(5,2);
BEGIN
Current_radius := 3;
DBMS_OUTPUT.PUT_LINE('For a circle with radius 3, the circumference is ' || ROUND(2*Pi*Current_radius, 2) || ' and the area is ' || ROUND(Pi*Current_radius*Current_radius, 2));
END;
/