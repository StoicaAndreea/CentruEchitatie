CREATE DATABASE Centru_echitatie
USE Centru_echitatie
--relatie 1-M
--ADRESE-INSTRUCTORI SI ADRESE-ELEVI
CREATE TABLE Adrese(
cod_adresa INT PRIMARY KEY IDENTITY (1,1),
tara VARCHAR(10) NOT NULL,
judet VARCHAR(10) NOT NULL,
localitate VARCHAR(10) NOT NULL,
strada VARCHAR(10) NOT NULL,
numar VARCHAR(5) NOT NULL,
scara VARCHAR(5),
apartament VARCHAR(5)
);

CREATE TABLE Instructori(
cod_instructor INT PRIMARY KEY IDENTITY (1,1),
nume VARCHAR(50) NOT NULL,
prenume VARCHAR(50) NOT NULL,
data_nasterii DATE NOT NULL,
stare_sanatate VARCHAR(50),
salariu FLOAT,
telefon VARCHAR(20),
cod_adresa INT 
CONSTRAINT fk_instructori FOREIGN KEY (cod_adresa) REFERENCES Adrese(cod_adresa)
);

CREATE TABLE Elevi(
cod_elev INT PRIMARY KEY IDENTITY (1,1),
nume VARCHAR(50) NOT NULL,
prenume VARCHAR(50) NOT NULL,
data_nasterii DATE NOT NULL,
telefon VARCHAR(20),
cod_adresa INT ,
CONSTRAINT fk_elevi FOREIGN KEY(cod_adresa) REFERENCES Adrese(cod_adresa)
);

--relatie 1-1
--INSTRUCTORI-LEGITIMATII
CREATE TABLE Legitimatii(
cod_legitimatie INT PRIMARY KEY IDENTITY(1,1),
numar VARCHAR(5) NOT NULL,
data_emitere DATE NOT NULL,
data_expirare DATE,
cod_instructor INT,
CONSTRAINT fk_legitimatii FOREIGN KEY(cod_instructor) REFERENCES Instructori(cod_instructor),
CONSTRAINT uq_legitimatii UNIQUE (cod_instructor) 
);
--relatie 1-m
--CAI-ECHIPAMENTE
CREATE TABLE Cai(
cod_cal INT PRIMARY KEY IDENTITY(1,1),
nume VARCHAR(50) NOT NULL,
rasa VARCHAR(50),
culoare VARCHAR(50),
data_nastere DATE NOT NULL
);
CREATE TABLE Echipamente(
cod_echipament INT PRIMARY KEY IDENTITY(1,1),
marime VARCHAR(3),
culoare VARCHAR(10),
producator VARCHAR(50),
cod_cal INT,
CONSTRAINT fk_echipamente FOREIGN KEY(cod_cal) REFERENCES Cai(cod_cal)
);
--relatie m-n
--elevi-instructori, elevi-cai, cai-instructori => cursuri
CREATE TABLE Cursuri(
cod_curs INT PRIMARY KEY IDENTITY(1,1),
cod_elev INT,
cod_instructor INT,
cod_cal INT,
data_curs DATE NOT NULL,
ora_curs TIME NOT NULL,
CONSTRAINT fk_cursuri_elevi FOREIGN KEY(cod_elev) REFERENCES Elevi(cod_elev),
CONSTRAINT fk_cursuri_instructori FOREIGN KEY(cod_instructor) REFERENCES Instructori(cod_instructor),
CONSTRAINT fk_cursuri_cai FOREIGN KEY(cod_cal) REFERENCES Cai(cod_cal)
);
ALTER TABLE Cursuri
ALTER COLUMN cod_elev INT NOT NULL;
ALTER TABLE Cursuri
ALTER COLUMN cod_instructor INT NOT NULL;
ALTER TABLE Cursuri
ALTER COLUMN cod_cal INT NOT NULL;

ALTER TABLE Instructori
ADD unitate_emitenta VARCHAR(30);

-- default constraint for adrese
ALTER TABLE Adrese
ADD CONSTRAINT d_sc_Adrese DEFAULT '-' FOR scara
ALTER TABLE Adrese
ADD CONSTRAINT d_ap_Adrese DEFAUlT '-' FOR apartament

--check constraint for instructori
ALTER TABLE Instructori
ADD CONSTRAINT ck_Instructori CHECK(salariu>500)

alter table Instructori
drop column unitate_emitenta
alter table Legitimatii
add unitate_emitenta VARCHAR(50);