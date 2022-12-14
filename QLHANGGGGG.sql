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
CREATE FUNCTION getThu(@ngay datetime)
	RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @songaytrongtuan int;
	set @songaytrongtuan = DATEPART (WEEKDAY,@ngay);
	DECLARE @thu NVARCHAR(100);
	
	if (@songaytrongtuan = 0)
	BEGIN
		SET @thu = N'Thứ hai';
	END
	if (@songaytrongtuan = 0)
	BEGIN
		SET @thu = N'Thứ ba';
	END
	if (@songaytrongtuan = 0)
	BEGIN
		SET @thu = N'Thứ tư';
	END
	if (@songaytrongtuan = 0)
	BEGIN
		SET @thu = N'Thứ năm';
	END
	if (@songaytrongtuan = 0)
	BEGIN
		SET @thu = N'Thứ sáu';
	END
	if (@songaytrongtuan = 0)
	BEGIN
		SET @thu = N'Thứ bảy';
	END
	if (@songaytrongtuan = 0)
	BEGIN
		SET @thu = N'Chủ nhật';
	END
	RETURN @thu;
end
CREATE FUNCTION ham (
    @MAHD nvarchar(10)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        dbo.HDBAN.MAHD,NGAYXUAT,MAVT,DONGIA,SLBAN, dbo.getThu(NgayXuat) as 'Ngay Thu' 
    FROM dbo.HANGXUAT,dbo.HDBAN
    WHERE dbo.HDBAN.MAHD=dbo.HANGXUAT.MAHD AND dbo.HANGXUAT.MAHD = @MAHD

select*from dbo.ham (2)
--Bài 4
CREATE PROCEDURE p4 
@thang int, @nam int 
AS
SELECT 
SUM(SLBAN * DONGIA)
FROM HANGXUAT HX
INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NGAYXUAT) = @THANG AND YEAR(HD.NGAYXUAT) = @NAM;
