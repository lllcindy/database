REM Xindi Lan
REM HW3_Part3

SET SERVEROUTPUT ON;
DECLARE
student_id varchar2(6);
student_f varchar2(30);
student_l varchar2(30);
--sum_grade number;
--sum_credit number;
sum_gpa number;
CURSOR Studentinfo 
IS 
select student.s_id, student.s_first, student.s_last
from student, enrollment
where student.s_id =enrollment.s_id;

CURSOR GPA
IS
select sum(course.credits*enrollment.grade)/sum(course.credits)
from enrollment, course_section, course
where enrollment.s_id = student_id
And enrollment.c_sec_id = course_section.c_sec_id
And course_section.course_no = course.course_no
group by enrollment.s_id;

BEGIN
OPEN Studentinfo;
LOOP
FETCH Studentinfo INTO student_id, student_f, student_l;
OPEN GPA;
LOOP
FETCH GPA INTO sum_gpa;
DBMS_OUTPUT.PUT_LINE('+');
DBMS_OUTPUT.PUT_LINE('Student: ' || student_f || ' ' || student_l);
DBMS_OUTPUT.PUT_LINE('s_id= ' || student_id);
DBMS_OUTPUT.PUT_LINE('GPA: ' || sum_gpa);
END LOOP;
CLOSE GPA;
END LOOP;
CLOSE Studentinfo;
--DBMS_OUTPUT.PUT_LINE('+');
--DBMS_OUTPUT.PUT_LINE('Student: ' || student_f || ' ' || student_l);
--DBMS_OUTPUT.PUT_LINE('s_id= ' || student_id);
--DBMS_OUTPUT.PUT_LINE('GPA: ' || sum_gpa);
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('The PLSQL procedure returns an exception');
END;
/