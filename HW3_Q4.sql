REM Xindi Lan
REM HW3_Q4_Lan
start D:\hw3\DreamHome_Tables.sql;
start D:\hw3\Northwoods.txt;
alter table staff modify(position varchar2(20));

--a)
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE create_staff(numbers in staff.staffno%type, firstn in staff.fname%type, lastn in staff.lname%type, positions in staff.position%type, sex1 in staff.sex%type, dob1 in staff.dob%type, salary1 in staff.salary%type, branchno1 in staff.branchno%type)
AS

BEGIN

INSERT INTO staff values (numbers, firstn, lastn, positions, sex1, dob1, salary1, branchno1);
DBMS_OUTPUT.PUT_LINE('Insert successfully');
END;
/

--b)
ALTER TABLE registration DISABLE CONSTRAINT registration_clientno_fk;
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE clean_viewless_clients AS
delete_client client%rowtype;
CURSOR c is 
    select client.*
    from client LEFT OUTER JOIN viewing
    on client.clientno=viewing.clientno
    where viewing.propertyno is null;

BEGIN
OPEN c;
LOOP
FETCH c INTO delete_client;
DELETE FROM client where clientno=delete_client.clientno;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Delete successfully');
END LOOP;
CLOSE c;
END;
/

--c)
ALTER TABLE propertyforrent DISABLE CONSTRAINT propertyforrent_ownerno_fk;
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE change_property_ownership(prop in propertyforrent.propertyno%type, oowner in propertyforrent.ownerno%type, nowner in propertyforrent.ownerno%type)
AS

BEGIN

UPDATE propertyforrent SET ownerno=nowner where propertyno=prop and ownerno=oowner;
DBMS_OUTPUT.PUT_LINE('Update successfully');
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No such property found');
WHEN VALUE_ERROR THEN
DBMS_OUTPUT.PUT_LINE('The given value is wrong');
END;
/



