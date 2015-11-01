drop table College;
drop table Student;
drop table Apply;

create table College(cName varchar2(100), state varchar2(10), enrollment number(10));
create table Student(sID number(10), sName varchar2(100), GPA number(5,1), sizeHS number(10));
create table Apply(sID number(10), cName VARCHAR2(100), major VARCHAR2(100), decision varchar2(100));