--GROUP BY
CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel

--SORU :ISME GORE TOPLAM MAASLARI BULALIM
select isim, sum(maas) from personel
group by isim

--Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
select sirket,count(* ) from personel where maas>5000 group by sirket;
 -----HAVING
 /*
 having komutu yalnizca group by komutu ile kullanilir. eger gruplamadan sonra bir
 sart varsa having komutu kullanilir.
 where kullanimi ile ayni mantikla calisir.
 */
-- 1) Her sirketin MIN maaslarini eger 4000’den buyukse goster
SELECT sirket, min(maas) from personel group by sirket having min(maas)>4000
 
-- 2) Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi
-- ve toplam maasi gosteren sorgu yaziniz
select isim, sum(maas) from personel group by isim having sum(maas)>10000
-- Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
select sehir,count(isim)as personel_sayisi from personel 
group by  sehir
having count(isim)>1

-- 4) Eger bir sehirde alinan MAX maas 5000’den dusukse
-- sehir ismini ve MAX maasi veren sorgu yaziniz

select sehir, max(maas) from personel 
group by sehir
having max(maas)<5000

-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz
select isim,maas from personel where maas>5000
union
select sehir,maas from personel where maas>4000
-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
select isim, maas from personel where isim='Mehmet Ozturk'
union
select sehir, maas from personel where sehir='Istanbul'
order by maas;
drop table  if exists personel
CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id));
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel
select * from personel_bilgi
-- id’si 123456789 olan personelin    Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin
SELECT sehir as sehir_ve_tel ,maas as maas_ve_cocuk_sayisi from personel where id=123456789
union
select tel,cocuk_sayisi from personel_bilgi where id=123456789 

/*UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir, 
Ayni kayit birden fazla olursa, sadece bir tanesini alir. 
UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.*/

--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
select isim,maas from personel where maas<5000
union all
select isim,maas from personel where maas<5000
 
-- Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
-- Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
select id from personel where sehir in('Istanbul','Ankara')
intersect
select id from personel_bilgi where cocuk_sayisi in(2,3) 
 
-- 1) Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin
-- 2) Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
-- 3) Iki sorguyu INTERSECT ile birlestirin
SELECT id FROM personel
WHERE maas NOT BETWEEN 4800 and 5000
INTERSECT
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3)
-- Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
select isim from personel where sirket='Honda'
intersect
select isim from personel where sirket='Ford'
intersect
select isim from personel where sirket='Tofas'
--EXCEPT(MINUS) KULLANIMI
/*
iki sorgulama harici bir sorgulama istenirse Except komutu kullanilir.
*/
--5000’den az maas alip Honda’da calismayanlari yazdirin
select * from personel

select isim, sirket from personel where maas<5000
except
select isim,sirket from personel where sirket='Honda'
 
 