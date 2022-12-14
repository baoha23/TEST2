create database QLHANG

USE [QLHANG]
CREATE TABLE VATTU
(
MAVAT char(4) primary key,
TENVT nvarchar (20) not null,
DVTINH nvarchar(10) not null,
SLCON nvarchar(10) not null,
)
create table HDBAN
(
MAHD char(4) primary key,
NGAYXUAT smalldatetime,
HOTENKH nvarchar(40) not null,
)
create table HANGXUAT
(
MAHD char(4) not null,
MAVT char(4) not null,
DONGIA money not null,
SLBAN int not null,
constraint pk_hangxuat primary key(MAHD,MAVT)
)

--THÊM DỮ LIỆU cho bảng vạt tư
insert into VATTU values ('VT01','Dụng cụ học tập','Cái','2')
insert into VATTU values ('VT02','Dụng cụ làm vườn','Cái','4')

--THÊM DỮ LIỆU CHO BẢNG HDBAN
insert into HDBAN values ('HD01','1/1/2022','Trần Ngọc Cường')
insert into HDBAN values ('HD02','1/2/2022','Trần Ngọc Bảo')
--THÊM DỮ LIỆU CHO BẢNG HANGXUAT
insert into HANGXUAT values ('HD01','VT01',10000,'4')
insert into HANGXUAT values ('HD01','VT02',100000,'5')
insert into HANGXUAT values ('HD02','VT02',10000,'4')
insert into HANGXUAT values ('HD02','VT01',200000,'7')

--BÀI 2

select MAHD, SUM(DONGIA* SLBAN)
from HANGXUAT
group by MAHD
ORDER BY SUM(SLBAN * DONGIA) Desc;
--BÀI 3
create function getthu(@ngay datetime)
	returns nvarchar(100)
as
begin
	declare @songaytrongtuan int;
	set @songaytrongtuan = DATEPART(WEEKDAY, @ngay);
	declare @thu nvarchar (100);

	if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu hai';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu ba';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu tu';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu nam';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu sau';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu bay';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'Chu nhat';
	end
	CREATE FUNCTION Cau3 (@mahd int(10))
RETURNS TABLE
AS
RETURN
    SELECT dbo.HDBAN.MAHD, NGAYXUAT, MAVT, DONGIA,SLBAN, dbo.getThu(NGAYXUAT) as N'Ngày Thứ'
    FROM dbo.HANGXUAT, db.HDBAN
    WHERE dbo.HDBAN.MAHD = dbo.HANGXUAT.MAHD AND dbo.HANGXUAT.MAHD = @mahd
    --test
    SELECT * FROM dbo.Cau3(2)
--Bài 4
CREATE PROCEDURE p4 
@thang int, @nam int 
AS
SELECT 
SUM(SLBAN * DONGIA)
FROM HANGXUAT HX
INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NGAYXUAT) = @THANG AND YEAR(HD.NGAYXUAT) = @NAM;