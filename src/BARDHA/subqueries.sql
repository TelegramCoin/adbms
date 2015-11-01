-- note using left & right outer join seplrately
-- note unions without joins
-- note union all

-- Sid
SELECT
  DISTINCT
  s.sname sname,
  a.sid   sid,
  a.cname cname,
  a.major major
FROM student s RIGHT JOIN apply a ON s.sid = a.sid

UNION

SELECT
  DISTINCT
  s.sname sname,
  s.sid   sid,
  a.cname cname,
  a.major major
FROM APPLY a RIGHT JOIN STUDENT s ON s.sid = a.SID;

-- Dolly
select sname, sid, cname, major from student natural join apply
union
select sname,sid,null,null from student where sid not in (select sid from apply)
union
select null,sid, cname, major from apply where sid not in (select sid from student);

-- BP
select sName, sID, cName, major
from Student full outer join Apply using(sID);

-- Pooja
-- IDs and names of students applying to CS

SELECT * FROM STUDENT;
SELECT * FROM APPLY;
SELECT * FROM COLLEGE;

SELECT s.sid, sname, major,cname from STUDENT s, APPLY a WHERE s.SID = a.SID;
SELECT  * FROM (SELECT s.sid, sname, major, cname from STUDENT s, APPLY a WHERE s.SID = a.SID) WHERE MAJOR='CS';

-- Dolly
select sid,sname from student where sid in (select sid from apply where major = 'CS');

select sid from apply where major = 'CS';
-- GPA
select sid,sname, GPA from student where sid in (select sid from apply where major = 'CS');

--
select sid from apply where major = 'CS' or MAJOR = 'EE';

select sid,sname, GPA from student where sid in (select sid from apply where major = 'CS');


select sid,sname FROM STUDENT WHERE sid NOT IN
                        (select sid from apply where major = 'CS'
                         INTERSECT
                         select sid from apply where major = 'EE');


SELECT CNAME FROM (SELECT CNAME, STATE, COUNT(STATE) OVER(PARTITION BY STATE) as countState FROM COLLEGE)  WHERE countState > 1;

SELECT * FROM COLLEGE;

SELECT c.STATE , c.CNAME
FROM COLLEGE c
WHERE c.STATE in (SELECT c1.STATE
                  FROM COLLEGE c1
                  WHERE c1.STATE = c.STATE
                  AND c1.CNAME != c.CNAME);

select cName FROM COLLEGE where State in(
  Select STATE from COLLEGE group by state having count(cName)>1);
-- note RD
select cname,state from college where state in (select lead(state,1,0)  over (partition by state order by cname) AS state from college);

select lead(state,1,null)  over (partition by state order by cname) AS state from college;

-- note 9 Oct Corelated - Refernce of outer query in inner query

SELECT c.cname, c.ENROLLMENT FROM COLLEGE c
WHERE ENROLLMENT = (SELECT max(ENROLLMENT) from COLLEGE);

SELECT max(ENROLLMENT) , CNAME from COLLEGE;

SELECT CNAME FROM COLLEGE c WHERE CNAME IN (SELECT * FROM COLLEGE c1 WHERE c.ENROLLMENT >= c1.ENROLLMENT);
SELECT 1 FROM COLLEGE;

-- note Bipi
select cName
from College C1
where not exists (select 1 from College C2
where C2.enrollment > C1.enrollment);

-- student with high GPA
SELECT * FROM STUDENT;

select sName
from STUDENT s1
where not exists (select 1 from STUDENT S2
where S2.GPA > S1.GPA);

select sName, GPA
from STUDENT s1
where s1.GPA >= all (select s2.GPA from STUDENT S2);

-- note SB
select s.sname , s.gpa from student s where s.gpa = All(select s1.gpa from student s1 where s1.GPA>s.GPA);

select cName
from College S1
where not enrollment <= any (select enrollment from College S2
where S2.cName <> S1.cName);

select cName
from College S1
where enrollment > any (select enrollment from College S2
where S2.cName <> S1.cName);

-- note who are not from smallest High school
SELECT sname FROM STUDENT s1 WHERE SNAME = any(SELECT SNAME FROM STUDENT s2 WHERE 200 <> s1.SIZEHS);

SELECT sname FROM STUDENT s1 WHERE SIZEHS <> (SELECT MIN(SIZEHS) from STUDENT);

-- note same using EXists

-- SELECT sname FROM STUDENT s1 WHERE exists( SELECT );

-- note Find students who applied to CS but not EE
SELECT * FROM APPLY;
SELECT sid FROM APPLY a1 WHERE SNAME = any(SELECT MAJOR FROM APPLY a WHERE )
SELECT sid FROM APPLY WHERE MAJOR <> 'EE'

IN(All applications for CS)  NOT IN (All applications for EE)

SELECT sname FROM STUDENT s WHERE sid IN (SELECT SID FROM STUDENT WHERE major = 'CS') and NO

-- note Find students who applied to CS but not EE, use ‘any

-- note Pooja G
select s1.sName from Student s1 where s1.sID = any(select ap1.sID from Apply ap1 where s1.SID = ap1.SID and ap1.major = 'CS' and ap1.major <>'EE');


-- note Mahesh
select distinct s.sName from student s, apply a where s.sid = a.sid and a.major = 'CS' and not s.sid = any(select sid from apply where major='EE');
select sName from student where sid in (select sid from apply where major='CS' and not sid = any(select sid from apply where major='EE'));
--

SELECT * FROM STUDENT;
SELECT c.cname, s.GPA, c.state  FROM APPLY a, STUDENT s, COLLEGE c WHERE a.SID = s.SID and a.cname = c.cname and c.CNAME <> 'MIT';

SELECT sid, sname FROM STUDENT
WHERE sid = any( SELECT sid FROM APPLY WHERE MAJOR='CS' AND sid not in (SELECT sid FROM APPLY WHERE MAJOR='EE'));

WITH OnlyCSStudents AS (SELECT DISTINCT * FROM APPLY WHERE MAJOR='CS' AND sid not in (SELECT sid FROM APPLY WHERE MAJOR='EE'))
SELECT * FROM OnlyCSStudents;

WITH Applications AS (SELECT * from APPLY)
SELECT * FROM Applications;







