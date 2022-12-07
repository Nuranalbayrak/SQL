-----------------JOIN----------------
CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota'); 
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford'); 
INSERT INTO sirketler VALUES(103, 'Hyundai');
CREATE TABLE siparisler  (
siparis_id int,  sirket_id int,  siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17'); 
INSERT INTO siparisler VALUES(22, 102, '2020-04-18'); 
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');  
INSERT INTO siparisler VALUES(55,  105, '2020-04-21');

select * from sirketler
select * from siparisler

-- SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--       siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler inner join siparisler
on sirketler.sirket_id=siparisler.sirket_id

-------------LEFT JOIN-------------
-- SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--       siparis_tarihleri ile yeni bir tablo olusturun
/*
soruda istenilen fieldları alırken
ınner joinde sadece kesişimleri
left joinde 1. tablo + kesişimleri
right joinde 2. tablo + kesişimleri
*/
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler left join siparisler
on sirketler.sirket_id=siparisler.sirket_id

-- SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--       siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler RIGHT join siparisler
on sirketler.sirket_id=siparisler.sirket_id
-- SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--       siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler full join siparisler
on sirketler.sirket_id=siparisler.sirket_id
drop table personel cascade
CREATE TABLE personel  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);
select * from personel

--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
SELECT p1.isim AS personel_ismi, p2.isim AS yonetici_ismi
FROM personel p1 INNER JOIN personel p2
ON p1.yonetici_id = p2.id;
LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/
drop table musteriler

CREATE TABLE musteriler  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000); 

--SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
/*
LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
LIKE yerine ~~ sembollerini kullanabiliriz.
Eğer büyük küçük harf gözetmeksizin kullanmak istersek ~~* sembollerini kullanırız
*/
SELECT *
FROM musteriler
WHERE isim ILIKE 'A%';

--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir
from musteriler
where isim like '%e'

--SORU : Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir from musteriler where isim like  '%er%'
--SORU : Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * 
from musteriler
where isim like '_atma'
--SORU : Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazi
SELECT *
FROM musteriler  
WHERE isim LIKE '_a%';
--SORU : Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
select *
from musteriler
where isim like '__s%'
/*
	3) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
	veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
	(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
*/
CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  
Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3); 
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
select * from kelimeler
--SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran
--QUERY yazin
select * from kelimeler
where kelime ~ 'h[ai]t'
--SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini 
--yazdiran QUERY yazin
select * from kelimeler
where kelime ~ 'h[a-k]t'
--SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler
where kelime ~ '^[as]'
--SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler
where kelime ~ '[mf]$'
/*
UPPER – LOWER - INITCAP
Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
kucuk harf yazdirmak icin kullaniriz
*/
SELECT UPPER(kelime)
FROM kelimeler;

SELECT INITCAP(kelime)
FROM kelimeler;

SELECT LOWER(kelime) 
FROM kelimeler;


