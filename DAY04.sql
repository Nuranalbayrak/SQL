--ALIASES
CREATE TABLE calisanlar3 (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar3 VALUES(123456789,'Ali Can', 'Istanbul');
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');
select * from calisanlar3;
--Eger iki sutunun verilerini birlestirmek istersek concet sembolunu kullaniriz. (||)
select calisan_id as id,calisan_isim || ' ' || calisan_dogdugu_sehir as calisan_bilgisi from calisanlar3;

--2. yol
select calisan_id as id, concat(calisan_isim,calisan_dogdugu_sehir) as calisan_bilgisi from calisanlar3;

--IS NUL CONDITIONS
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli')

--Name sutununda null olan degerleri listeleyim.
select * from insanlar;
select name from insanlar where name is  NULL;

-- Insanlar tablosunda sadece null olmayan degerleri listeleyiniz
select name from insanlar where name is not null;

--Insanlar tablosunda null deger almis verileri no name olara degistiriniz
update  insanlar 
set name='No Name'
WHERE name is null;
--ORDER BY KOMUTU
/*
tablolardaki verileri sirlamak icin ORDER BY komutu kullaniriz.
buyukten kucuge yada kucukten buyuge siralama yapabiliriz.
default olarak kucukten buyuge siralama yapar.
eger buyukten kucuge siralamak istersek ORDER BY komutundan sonra DESC komutunu kullaniriz.
*/
CREATE TABLE insanlar1
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar1 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar1 VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar1 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar1 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar1 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar1 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar1
--Insanlar tablosundaki datalari adres’e gore siralayin

select * from insanlar1 order by adres;

--Insanlar1 tablosundan ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar1 where isim='Mine' order by ssn;

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select * from insanlar1 where soyisim='Bulut' order by 2

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar1 order by ssn DESC

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM insanlar1 order by isim ASC,soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
SELECT isim,soyisim from insanlar1 order by length (soyisim)
/*
Eger sutun uzunluguna gore siralamak istersek length komutu kullanilir 
ve yine uzunlugu buyukten kucuge siralamak istersek sonuna DESC komutunu ekleriz.
*/
-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar1 ORDER BY LENGTH(isim||soyisim)
SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar1 ORDER BY LENGTH (isim)+LENGTH (soyisim)
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar1 ORDER BY LENGTH (isim)+LENGTH (soyisim)
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar1 ORDER BY LENGTH (concat(isim,soyisim))

--GROUP BY CLAUSE
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav
--Isme gore alinan toplam urunleri bulun 
select isim,sum (urun_miktar) from manav GROUP BY isim

--Isme gore alinan toplam urunleri bulun ve bu urunleri  buyukten kucuge siralayin.
select isim ,sum (urun_miktar) from manav group by isim order by isim DESC

-- Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi, count (isim) from manav
group by urun_adi


