start D:\hw3\DreamHome_Tables.sql;
start D:\hw3\Northwoods.txt;

SPOOL "D:\hw3\HW3_Part2_lan.log"
Set echo on;
SET SERVEROUTPUT ON;

--HW3_Q1 (param)
start D:\hw3\HW3_Q1_Lan.sql;

--HW3_Q2
start D:\hw3\HW3_Q2a_Lan.sql;
start D:\hw3\HW3_Q2b_Lan.sql;
start D:\hw3\HW3_Q2c_Lan.sql;

--HW3_Q3 (Param)
start D:\hw3\HW3_Q3_Lan.sql;
execute display_branch_staff('B003', 'Glasgow', 'Manager');

--HW3_Q4 (PARAM)
start D:\hw3\HW3_Q4_Lan.sql;
execute create_staff('AS48', 'James', 'Smith', 'Assistant Manager', 'M', '24/Nov/1979', 59000, 'B002');
select *
from staff
where staffno='AS48';

execute clean_viewless_clients;
select *
from client;

execute change_property_ownership('PA14', 'CO46', 'CO23');
select *
from propertyforrent;

SPOOL OFF;

