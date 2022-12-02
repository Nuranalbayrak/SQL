--DDL -DATA DEFINITIAN LANG.
--CREATE -TABLO OLUSTURMA
create table ogrenciler
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,--ondalikli sayilar kullanilir(double gibi)
kayit_tarih date		
--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
create table ogrenci_notlari
as
select isim,soyisim,not_ort from ogrenciler;
--DML -DATA MANIPILATION LANG.
--INSERT (DATABASE'E VERI EKLEME)	
INSERT INTO ogrenciler values('1234567','nuran','albayrak',85.5,now());
INSERT INTO ogrenciler values('1234567','nuran','albayrak',85.5,'2020-12-11');
--bir tabloya parcali veri ekleemek	
insert into ogrenciler(isim,soyisim) values ('nuran','albayrak');	

--DQL -DATA QUERY LANG.	
--SELECT	
SELECT * FROM ogrenciler;	