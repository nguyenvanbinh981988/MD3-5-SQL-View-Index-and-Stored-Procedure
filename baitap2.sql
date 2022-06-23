create database cinema;

Create table phong(
    maphong int primary key,
    tenphong varchar(255),
    trangthai bit
);
create table ghe(
    maghe int primary key,
    maphong int, foreign key (maphong) references phong(maphong),
    soghe varchar(20)
);

create table film(
    mafilm int primary key not null,
    filmname varchar(50),
    loaifilm varchar(50),
    giochieu int(4)
);
create table ticket(
	mafilm int , foreign key (mafilm) references film(mafilm),
	maghe int,foreign key (maghe) references ghe(maghe),
	ngaychieu datetime,
    trangthai varchar(40),
    primary key(mafilm,maghe)
);

INSERT INTO film VALUES (1, 'Em bé Hà Nôi', 'Tâm lý',90),(2, 'Nhiệm vụ bất khả thi', 'Hành động',100),(3, 'Dị nhân', 'Viễn tưởng',90),(4, 'Cuốn theo chiều gió', 'Tình cảm',120);

INSERT INTO phong VALUES (1, 'Phòng chiếu 1', 1),(2, 'Phòng chiếu 2', 1),(3, 'Phòng chiếu 1', 0);

INSERT INTO ghe VALUES (1, 1, 'A3'),(2, 1, 'B5'),(3, 2, 'A7'),(4, 2, 'D1'),(5, 3, 'T2');

INSERT INTO ticket VALUES (1, 1, '2008-10-20','Đã bán'),(1, 3, '2008-11-20','Đã bán'),(1, 4,'2008-12-23','Đã bán'),(2, 1, '2009-02-14','Đã bán'),(3, 1, '2009-02-14','Đã bán'),(2, 5, '2009-03-08','Chưa bán'),(2, 3, '2009-03-08','Chưa bán');

----- cau 2 ---------

select * from film order by giochieu ASC;


----- cau 3 ---------

select film.filmname,giochieu,'film dai nhat' as 'commnet'
from film
where giochieu = (select max(giochieu) from film);

----- cau 4 ---------

select film.filmname,giochieu,'film dai nhat' as 'commnet'
from film
where giochieu = (select min(giochieu) from film);

----- cau 5 ---------

select * from ghe
where soghe like 'A%';

----- cau 6 ---------

ALTER TABLE phong
CHANGE COLUMN trangthai trangthai VARCHAR(20) NULL DEFAULT NULL ;

----- cau 7 ---------

update phong set trangthai = if(trangthai = '0', 'Đang sửa',if(trangthai ='1','Đang sử dụng','Unknow')) where maphong >0;

----- cau 8 ---------

select * from film
where CHAR_LENGTH(filmname) between 15 and 25;

----- cau 9 ---------

select concat(tenphong,' ',trangthai) as 'trang thai cac phong' from phong;

----- cau 10 ---------

create table  tblRank(
STT int primary key not null auto_increment,
filmname varchar(50),
giochieu int(4)
);

insert into tblRank(filmname,giochieu)
SELECT film.filmname,film.giochieu
FROM film
order by filmname;

----- cau 11 ---------

alter table film add Mo varchar(255);

update film set Mo = concat('Đây là bộ phim thể loại ',loaifilm) where mafilm >0;

select * from film;

update film set Mo = concat('Đây là Film thể loại ',loaifilm) where mafilm >0;

select * from film;

----- cau 12 ---------

ALTER TABLE ticket
DROP FOREIGN KEY ticket_ibfk_1;

ALTER TABLE ticket
DROP FOREIGN KEY ticket_ibfk_2;

----- cau 13 ---------

delete from ticket;

--cac bang khac lam tuong tu

----- cau 14 ---------

select now() from film where mafilm = 1;

select ADDTIME( 50000, now()) from film where mafilm = 1;

