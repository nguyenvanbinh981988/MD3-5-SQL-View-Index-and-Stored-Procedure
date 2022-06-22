create database quanlyhocvienBT3;

create table test(
testid int not null primary key,
Subtestname varchar(60)
);

create table student(
RN int not null primary key,
Name varchar(50) not null,
Age int(4)
);

create table studenttest(
testid int, foreign key (testid) references test(testid),
RN int, foreign key (RN) references student(RN),
Date datetime,
mark float
);

insert into test value(1,'EPC'),(2,'DWMX'),(3,'SQL1'),(4,'SQL2');

insert into student value(1,'Nguyen Hong Ha',20),(2,'Truong Ngoc Anh',30),
(3,'Tuan Minh',25),(4,'Dan Truong',22);

insert into studenttest value(1,1,'2006-07-17',8),(1,2,'2006-07-18',5),(1,3,'2006-07-19',7),
(2,1,'2006-07-17',7),(2,2,'2006-07-18',4),(2,3,'2006-07-19',2),(3,1,'2006-07-17',10)
,(3,3,'2006-07-19',1);


--cau 2:
CREATE VIEW DSdiemthi AS
select dsdiemthiS.name,T.Subtestname,ST.mark,ST.date
from studenttest ST join test T on ST.testid = T.testid join student S on ST.RN = S.RN;

select * from dsdiemthi;

-- cau 3: 
Select * from student
where not exists (select * from studenttest where student.RN = studenttest.RN);

-- cau 4:
CREATE VIEW DSthilai AS
select S.name,T.Subtestname,ST.mark,ST.date
from studenttest ST join test T on ST.testid = T.testid join student S on ST.RN = S.RN
where ST.mark < 5;

select * from dsthilai;

-- cau 5:
CREATE VIEW DSdiemtrungbinh AS
select dsdiemthi.name,avg(mark) as 'AVGmark'
from dsdiemthi
group by name;

select * from dsdiemtrungbinh;

-- cau 6:
select dsdiemtrungbinh.name,max(avgmark) as 'maxmark'
from dsdiemtrungbinh;


--cau 7:
select dsdiemthi.subtestname,max(mark) as 'maxmark'
from dsdiemthi
group by dsdiemthi.subtestname
order by  dsdiemthi.subtestname ASC;

-- cau 8:
select dsdiemthi.name,dsdiemthi.subtestname
from dsdiemthi
order by  dsdiemthi.name ASC;

--cau 9:
update student set age = age + 1
where RN = 1 or RN = 2 or RN = 3 or RN = 4;

-- cau 10:
alter table student add status varchar(10);

-- cau 11:
CREATE INDEX student_age ON student (age);
update student set status = 'young'
where Age <= 30;

update student set status = 'old'
where Age > 30;

-- cau 12:
CREATE VIEW vwStudentTestList AS
select * from dsdiemthi
order by  dsdiemthi.date ASC;

select * from vwStudentTestList;

-- cau 13:
CREATE TRIGGER tgSetStatus after update on student
FOR EACH ROW
 INSERT INTO student
 SET action = 'update', status = 'young' having Age <= 30,
 
 chua lam xong
 


 
