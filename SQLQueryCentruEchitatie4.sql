Use Centru_echitatie
go
SELECT * FROM Adrese
SELECT * FROM Cai
SELECT * FROM Cursuri
SELECT * FROM Echipamente
SELECT * FROM Elevi
SELECT * FROM Instructori
SELECT * FROM Legitimatii


--adaugare cu validare elevi

GO
CREATE FUNCTION validareElevi(@nume VARCHAR(50),@prenume VARCHAR(50),@data_nasterii DATE,@telefon vARCHAR(20) ,@cod_adresa INT)
RETURNS VARCHAR(500) AS
BEGIN
	DECLARE @mesaj VARCHAR(500);
	SET @mesaj='0';
	if(@nume like '%[0123456789!?()*#]%' ) SET @mesaj=@mesaj+', CARACTERE NEACCEPTATE IN NUME';
	if (@prenume like '%[0123456789!?()*#]%' ) SET @mesaj=@mesaj+', CARACTERE NEACCEPTATE IN PRENUME';
	if(@data_nasterii > GETDATE() ) SET @mesaj=@mesaj+', DATA INCORECTA';
	if(NOT EXISTS ( SELECT cod_adresa FROM Adrese WHERE cod_adresa=@cod_adresa)) SET @mesaj=@mesaj+', ADRESA NU EXISTA';
RETURN @MESAJ
END
go

CREATE PROCEDURE adaugaElev @nume VARCHAR(50),@prenume VARCHAR(50),@data_nasterii DATE,@telefon VARCHAR(20) ,@cod_adresa INT
AS
BEGIN
	DECLARE @mesaj Varchar(500)
	SET @mesaj = dbo.validareElevi(@nume,@prenume,@data_nasterii ,@telefon,@cod_adresa);
	IF(len(@mesaj)>1)
		BEGIN
			RAISERROR(@mesaj,11,1)
		END
	ELSE 
		BEGIN
			INSERT INTO Elevi(nume,prenume,data_nasterii ,telefon,cod_adresa) VALUES(@nume,@prenume,@data_nasterii ,@telefon,@cod_adresa)
			PRINT 'S-A INSERAT UN ELEV NOU'
		END
END

EXEC adaugaElev 'Stoica','Rucsana','08/07/1976','0770895785',5;

--de testat
EXEC adaugaElev 'Stoica#','1Rucsana','08/07/1976','0770895785',20;
EXEC adaugaElev 'Stoica','Partenie','08/07/1976','0770895795',5;


--adaugare cu validare instrucotri
go
CREATE FUNCTION validareInstructori(@nume VARCHAR(50),@prenume VARCHAR(50),@data_nasterii DATE,@stare_sanatate VARCHAR(50), @salariu FLOAT, @telefon vARCHAR(20) ,@cod_adresa INT)
RETURNS VARCHAR(500) AS
BEGIN
	DECLARE @mesaj VARCHAR(500);
	SET @mesaj='0';
	if(@nume like '%[0123456789!?()*#]%' ) SET @mesaj=@mesaj+', CARACTERE NEACCEPTATE IN NUME';
	if (@prenume like '%[0123456789!?()*#]%' ) SET @mesaj=@mesaj+', CARACTERE NEACCEPTATE IN PRENUME';
	if(@data_nasterii > GETDATE() ) SET @mesaj=@mesaj+', DATA INCORECTA';
	if(NOT EXISTS ( SELECT cod_adresa FROM Adrese WHERE cod_adresa=@cod_adresa)) SET @mesaj=@mesaj+', ADRESA NU EXISTA';
	if (@salariu <=0) SET @mesaj=@mesaj +', SALARIU PREA MIC';
RETURN @MESAJ
END
go

CREATE PROCEDURE adaugaInstructor @nume VARCHAR(50),@prenume VARCHAR(50),@data_nasterii DATE,@stare_sanatate Varchar(50), @salariu FLOAT, @telefon VARCHAR(20) ,@cod_adresa INT
AS
BEGIN
	DECLARE @mesaj Varchar(500)
	SET @mesaj = dbo.validareInstructori(@nume,@prenume,@data_nasterii,@stare_sanatate,@salariu,@telefon,@cod_adresa);
	IF(len(@mesaj)>1)
		BEGIN
			RAISERROR(@mesaj,11,1)
		END
	ELSE 
		BEGIN
			INSERT INTO Instructori(nume,prenume,data_nasterii,stare_sanatate,salariu ,telefon,cod_adresa) VALUES(@nume,@prenume,@data_nasterii,@stare_sanatate,@salariu ,@telefon,@cod_adresa)
			PRINT 'S-A INSERAT UN INSTRUCTOR NOU'
		END
END

EXEC adaugaInstructor'Stoica','Claudiu','01/05/1974','reumatida',3004.5,'0770895786',5;
--de testat
EXEC adaugaInstructor'Stoica#','1Rucsana','08/07/2021','reumatida',-3004.5,'0770895785',20;
EXEC adaugaInstructor'Vasiu','Andreea','01/05/1994','apt',3000.5,'0770895786',5;


go
drop function validareInstructori
go
drop procedure adaugaInstructor


--adaugare cu validare cai
GO
CREATE FUNCTION validareCai(@nume VARCHAR(50),@rasa VARCHAR(50),@culoare VARCHAR(50),@data_nasterii DATE)
RETURNS VARCHAR(500) AS
BEGIN
	DECLARE @mesaj VARCHAR(500);
	SET @mesaj='0';
	if(@nume like '%[0123456789!?()*#]%' ) SET @mesaj=@mesaj+', CARACTERE NEACCEPTATE IN NUME';
	if (@rasa like '%[0123456789!?()*#]%' ) SET @mesaj=@mesaj+', CARACTERE NEACCEPTATE IN RASA';
	if (@culoare like '%[0123456789!?()*#]%' ) SET @mesaj=@mesaj+', CARACTERE NEACCEPTATE IN CULOARE';
	if(@data_nasterii > GETDATE() ) SET @mesaj=@mesaj+', DATA INCORECTA';
RETURN @MESAJ
END
go

CREATE PROCEDURE adaugaCal @nume VARCHAR(50),@rasa VARCHAR(50),@culoare VARCHAR(50),@data_nasterii DATE
AS
BEGIN
	DECLARE @mesaj Varchar(500)
	SET @mesaj = dbo.validareCai(@nume,@rasa,@culoare,@data_nasterii);
	IF(len(@mesaj)>1)
		BEGIN
			RAISERROR(@mesaj,11,1)
		END
	ELSE 
		BEGIN
			INSERT INTO Cai(nume,rasa,culoare,data_nastere) VALUES(@nume,@rasa,@culoare,@data_nasterii)
			PRINT 'S-A INSERAT UN CAL NOU'
		END
END

Go
exec adaugaCal 'Lino','Paso-Fino','negru','05/31/2009'

--de testat
exec adaugaCal 'Lino11','Paso-Fino','negru','05/31/2022'
exec adaugaCal 'Mia','Paso-Fino','alb','05/31/2009'

--adaugare cu validare cursuri
GO
CREATE FUNCTION validareCursuri (@cod_elev INT,@cod_instructor INT, @cod_cal INT, @data_curs DATE,@ora_curs TIME)
RETURNS VARCHAR(500) AS
BEGIN
	DECLARE @mesaj VARCHAR(500);
	SET @mesaj='0';
	if(NOT EXISTS ( SELECT cod_elev FROM Elevi WHERE cod_elev=@cod_elev)) SET @mesaj=@mesaj+' ,NU EXISTA ACEST ELEV';
	if(NOT EXISTS ( SELECT @cod_instructor FROM Instructori WHERE cod_instructor=@cod_instructor)) SET @mesaj=@mesaj+' ,NU EXISTA ACEST INSTRUCTOR';
	if(NOT EXISTS ( SELECT @cod_cal FROM Cai WHERE cod_cal=@cod_cal)) SET @mesaj=@mesaj+' ,NU EXISTA ACEST CAL';
	if(@data_curs < convert(date,GETDATE()) ) SET @mesaj=@mesaj+', DATA INCORECTA';
	ELSE
	if(@data_curs = GETDATE() AND @ora_curs < CONVERT(TIME, GETDATE())) SET @mesaj=@mesaj+', ORA INCORECTA';
	--aici nu imi merge partea cu time
RETURN @mesaj
END
go 

CREATE PROCEDURE adaugaCurs @cod_elev INT,@cod_instructor INT, @cod_cal INT, @data_curs DATE,@ora_curs TIME
AS
BEGIN
	DECLARE @mesaj Varchar(500)
	SET @mesaj = dbo.validareCursuri(@cod_elev,@cod_instructor, @cod_cal, @data_curs,@ora_curs);
	IF(len(@mesaj)>1)
		BEGIN
			RAISERROR(@mesaj,11,1)
		END
	ELSE 
		BEGIN
			INSERT INTO Cursuri(cod_elev,cod_instructor, cod_cal, data_curs,ora_curs) VALUES(@cod_elev,@cod_instructor, @cod_cal, @data_curs,@ora_curs)
			PRINT 'S-A INSERAT UN CURS NOU'
		END
END
go
EXEC adaugaCurs 1,1,2,'05/05/2021','12:00:00'
--de testat
EXEC adaugaCurs 1,1,3,'12/17/2020','9:00:00'
EXEC adaugaCurs 1,1,2,'05/05/2022','9:00:00'
