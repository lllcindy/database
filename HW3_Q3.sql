REM Xindi Lan
REM HW3_Q3_Lan

SET SERVEROUTPUT ON;
DECLARE
Branch_Number varchar2(4) := 'B003';
City varchar2(10) := 'Glasgow';
Positions varchar2(10) := 'Manager';
currentuser varchar2(10):= USER;
currentdate DATE := SYSDATE;
CURSOR display_branch_staff 
IS 
select branch.branchno, branch.street, branch.city, branch.postcode, staff.staffno, staff.fname, staff.lname, staff.position, staff.salary
from branch LEFT OUTER JOIN staff
on branch.branchno=staff.branchno
where branch.branchno = Branch_Number and branch.city = City and staff.position = Positions;
branch_staff display_branch_staff%ROWTYPE;

BEGIN
open display_branch_staff;
LOOP
FETCH display_branch_staff INTO branch_staff;
EXIT WHEN display_branch_staff%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Branch Number  City     Street        Postcode  Staff Number  First Name  Last Name  Position  Salary');
DBMS_OUTPUT.PUT_LINE(branch_staff.branchno || '           ' || branch_staff.city || '  ' || branch_staff.street || '  ' || branch_staff.postcode || '   ' || branch_staff.staffno || '           ' || branch_staff.fname || '       ' || branch_staff.lname || '      ' || branch_staff.position || '   ' || branch_staff.salary);
END LOOP;
CLOSE display_branch_staff;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No such branch and staff found');
WHEN ZERO_DIVIDE THEN
DBMS_OUTPUT.PUT_LINE('Cannot divided by zero');
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('Too many rows');
WHEN INVALID_CURSOR THEN
DBMS_OUTPUT.PUT_LINE('The cursor is invalid');
WHEN CURSOR_ALREADY_OPEN THEN
DBMS_OUTPUT.PUT_LINE('The cursor is already open');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('The PLSQL procedure executed by' || currentuser || 'returned and unhandled exception on' || currentdate);
END;
/