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

cach 2: 
Select *
from student S left join studenttest ST on ST.RN = S.RN
where mark is null;


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


cach 2:
select dsdiemthi.name,avg(mark) as 'AVGmark'
from dsdiemthi
group by name
order by mark DESC
limit 1;


--cau 7:
select dsdiemthi.subtestname,max(mark) as 'maxmark'
from dsdiemthi
group by dsdiemthi.subtestname
order by  dsdiemthi.subtestname ASC;

-- cau 8:
select dsdiemthi.name, if(dsdiemthi.subtestname ='EPC','khong can hoc',dsdiemthi.subtestname)  as 'mon hoc'
from dsdiemthi
order by  dsdiemthi.name ASC;

--cau 9:
update student set age = age + 1
where RN > 0;

-- cau 10:
alter table student add status varchar(10);

-- cau 11:
update student set status = 'young'
where Age <= 30;

update student set status = 'old'
where Age > 30;

cach 2:
update student set status = if(Age < 30, 'young','old') where RN >0;

-- cau 12:
CREATE VIEW vwStudentTestList AS
select * from dsdiemthi
order by  dsdiemthi.date ASC;

select * from vwStudentTestList;

-- cau 13:
DELIMITER $$
CREATE TRIGGER tgSetStatus before update on student
FOR EACH row
 begin
set new.status = if(new.Age < 30, 'young','old');
END$$
 DELIMITER ;
 
 drop TRIGGER tgSetStatus;
 
update student set age = 50 where RN = 1;


-- Câu 14:
CREATE VIEW view1 as
SELECT s.Name ,t.Subtestname ,st.mark
FROM Student as s 
		LEFT JOIN studenttest as st on s.RN=st.RN 
        LEFT JOIN Test as t on st.testid =t.testid;

DELIMITER $$
CREATE procedure spViewStatus(IN nameHV varchar(50), IN nameMH varchar(50),OUT output1 varchar(50),out output2 float)
BEGIN
DECLARE diem float;
	if nameHV not in (select Name from Student) or nameMH not in(select Subtestname from test) then
		set output1='Khong tìm thấy';
	else
		SELECT Mark INTO diem FROM view1 WHERE view1.Name=nameHV and view1.Subtestname=nameMH;
            set output2=diem;
 			IF diem>=5 then
				SET output1='Đỗ';
			ELSEIF diem<5 then
				SET output1='Trượt';
			ELSE
				SET output1='Chưa thi';
			end if;
	end if;
END$$


call spViewStatus('Nguyen Hong Ha','SQL1',@a,@b);

select @a as 'trạng thái' , @b as 'Điểm thi';


cach 2: 
DELIMITER $$
create procedure spViewStatus1(IN tenSV varchar(30),IN tenMH varchar(30))
begin
if tenSV not in (select Name from dsdiemthi)  then
select tenSV as 'name','khong tim thay sinh vien hoac k' as 'ketqua' ;

elseif  tenSV in (select Name from dsdiemthi) and tenMH  not in (select subtestname from dsdiemthi) then
select tenSV as 'name',tenMH as 'subtestname','chua thi' as 'ketqua';

else select dsdiemthi.name,dsdiemthi.subtestname,if(mark<5,'truot','do') as 'ket qua' from dsdiemthi
where dsdiemthi.name = tenSV and dsdiemthi.subtestname = tenMH ;

end if;

end$$

call spViewStatus1('Tuan Minh','DWMX');