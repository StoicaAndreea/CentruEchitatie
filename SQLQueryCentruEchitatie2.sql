--inserare valori pentru tabelul adrese

INSERT INTO Adrese(tara,judet,localitate,strada,numar,scara,apartament)
VALUES ('Romania','Mures','Sighisoara','Noua','13','b','11')
INSERT INTO Adrese(tara,judet,localitate,strada,numar)
VALUES ('Romania','Brasov','Brasov','Panseute','13')
INSERT INTO Adrese(tara,judet,localitate,strada,numar,scara,apartament)
VALUES ('Romania','Cluj','Gherla','Mierlei','1','c','1')
INSERT INTO Adrese(tara,judet,localitate,strada,numar)
VALUES ('Romania','Sibiu','Dumbraveni','Crisan','13')
INSERT INTO Adrese(tara,judet,localitate,strada,numar,scara,apartament)
VALUES ('Romania','Mures','Sighisoara','Noua','13','b','11')
INSERT INTO Adrese(tara,judet,localitate,strada,numar)
VALUES ('Romania','Suceava','Radauti','Cristea','12')
INSERT INTO Adrese(tara,judet,localitate,strada,numar,scara,apartament)
VALUES ('Romania','Alba','Alba-Iulia','Florilor','10','a','21')

--inserare valori pentru tabelul cai +>>>>>>>data e an/luna/zi
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Amadeus', 'Lipitan','maro','2010/05/05')
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Sabrina', 'Andalusian','alb','2010/10/13')
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Emese', 'Greu Olandez','negru','2015/10/20')
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Frodo', 'Shire','alb','2011/11/13')
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Helen', 'Lusitano','nisipiu','2019/7/13')
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Segei', 'Lusitano','nisipiu','2019/7/13')
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Segei', NULL,'nisipiu','2019/7/13')

--inserare valori pentru tabelul echipamente
INSERT INTO Echipamente(marime, culoare, producator,cod_cal)
VALUES('XL','negru','Fouganza',2)
INSERT INTO Echipamente(marime, culoare, producator,cod_cal)
VALUES('L','alb','Fouganza',4)
INSERT INTO Echipamente(marime, culoare, producator,cod_cal)
VALUES('XXL','maro','Fouganza',5)
INSERT INTO Echipamente(marime, culoare, producator,cod_cal)
VALUES('XL','alb','Fouganza',2)
INSERT INTO Echipamente(marime, culoare, producator,cod_cal)
VALUES('M','negru','Setzi',6)
INSERT INTO Echipamente(marime, culoare, producator,cod_cal)
VALUES('S','roz','Setzi',7)
INSERT INTO Echipamente(marime, culoare, producator,cod_cal)
VALUES('S','akbastru','Setzi',8)

--inserare valori pentru tabelul elevi
INSERT INTO Elevi(nume,prenume,data_nasterii,telefon,cod_adresa)
VALUES('Stoica','Andreea','2001/05/31', '0770890840',5)
INSERT INTO Elevi(nume,prenume,data_nasterii,telefon,cod_adresa)
VALUES('Sturze','Andreea','2000/04/16', '0760872580',3)
INSERT INTO Elevi(nume,prenume,data_nasterii,telefon,cod_adresa)
VALUES('Tanasa','Teona','2000/11/25', '0770890840',4)
INSERT INTO Elevi(nume,prenume,data_nasterii,telefon,cod_adresa)
VALUES('Minuta','Aurelius','1998', '0721562560',2)
INSERT INTO Elevi(nume,prenume,data_nasterii,telefon,cod_adresa)
VALUES('Stoica','Timeea','2004/07/22', '0770890841',5)
INSERT INTO Elevi(nume,prenume,data_nasterii,telefon,cod_adresa)
VALUES('Stoica','Ciprian','2006/09/22', '0770890842',5)

--inserare valori pentru tabelul instructori
INSERT INTO Instructori(nume,prenume,data_nasterii,telefon,cod_adresa,stare_sanatate,salariu)
VALUES('Siminiuc','Catalin','1974/05/11', '0770890841',6,'sanatos',1800.25)
INSERT INTO Instructori(nume,prenume,data_nasterii,telefon,cod_adresa,stare_sanatate,salariu)
VALUES('Balogh','Norbi','2000/06/06', '0770890882',6,'sanatos',800.25)
INSERT INTO Instructori(nume,prenume,data_nasterii,telefon,cod_adresa,stare_sanatate,salariu)
VALUES('Calinescu','Iancu','1980/08/06', '0770890333',2,'sold dislocat',2000.25)


--inserare valori in tabelul legitimatii
INSERT INTO Legitimatii(numar,data_emitere,data_expirare,cod_instructor,unitate_emitenta)
VALUES('s4568','2015/04/25','2021/04/25',1,'UIER')
INSERT INTO Legitimatii(numar,data_emitere,data_expirare,cod_instructor,unitate_emitenta)
VALUES('a2545','2019/03/25','2022/03/25',2,'UIER')
INSERT INTO Legitimatii(numar,data_emitere,data_expirare,cod_instructor,unitate_emitenta)
VALUES('b2578','2013/05/05','2021/05/05',3,'UIEA')

--inserare valori in tabelul cursuri
INSERT INTO Cursuri(cod_elev,cod_instructor,cod_cal,data_curs,ora_curs)
VALUES(1,1,2,'5/11/2020','12:00:00')
INSERT INTO Cursuri(cod_elev,cod_instructor,cod_cal,data_curs,ora_curs)
VALUES(1,1,2,'6/11/2020','12:00:00')
INSERT INTO Cursuri(cod_elev,cod_instructor,cod_cal,data_curs,ora_curs)
VALUES(2,2,2,'5/11/2020','13:00:00')

--STERG CAII CARE AU RASA NULL
DELETE FROM Cai
WHERE rasa IS NULL
--sterg echipamentele cu producator=fouganza
Delete from Echipamente
Where producator='Fouganza'
--STERG CAII CARE AU numele Emele sau Balala sau rasa se termina in "ian"
DELETE FROM Cai
WHERE nume in ('Emese','Blala') or rasa like '%ian'

--modific adresa instructorului care are adresa actuala 6 si prenumele norbi
UPDATE Instructori set cod_adresa=7
where cod_adresa=6 and prenume='norbi' 

--adaug doi cai
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Sabrina', 'Andalusian','alb','2010/10/13')
INSERT INTO Cai(nume,rasa,culoare,data_nastere)
VALUES('Emese', 'Greu Olandez','negru','2015/10/20')

--modific salariul oamenilor cu salar mai mic de 1000 sau mai mare de 1900
UPDATE Instructori set salariu=1100
where salariu<=1000 or salariu > 1900
--modific o greseala de inserare: "akbastru"=>albastru
UPDATE Echipamente SET culoare='albastru' WHERE culoare like 'a_bastru' and producator not in ('Fouganza','Sportex')


SELECT * FROM Cai;
SELECT * FROM Adrese;
SELECT * FROM Cursuri;
SELECT * FROM Echipamente;
SELECT * FROM Elevi;
SELECT * FROM Instructori;
SELECT * FROM Legitimatii;