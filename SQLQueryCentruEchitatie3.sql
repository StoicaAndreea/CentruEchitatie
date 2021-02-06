--interogare utilizand union
SELECT nume,prenume from Elevi
UNION ALL
SELECT nume,prenume from Instructori;

--interogare cu operatorul inner join
SELECT CU.cod_curs AS CodCurs,CU.data_curs, E.nume AS NumeElev,E.prenume AS PrenumeElev, C.nume AS NumeCal,I.nume AS NumeInstructor FROM Elevi E
INNER JOIN Cursuri CU ON E.cod_elev=CU.cod_elev
INNER JOIN Cai C on C.cod_cal=CU.cod_cal
INNER JOIN Instructori I on I.cod_instructor=CU.cod_instructor;

--interogare full join si un distinct
SELECT Distinct C.nume AS NumeCal, E.producator, E.marime from Cai C
FULL JOIN  Echipamente E ON E.cod_cal=C.cod_Cal;

--interogare right join si un distinct
SELECT Distinct C.nume AS NumeCal, E.producator, E.marime from Cai C
RIGHT JOIN  Echipamente E ON E.cod_cal=C.cod_Cal;

--DOAR O VERIFICARE FULL JOIN
SELECT CU.cod_curs AS CodCurs,CU.data_curs, E.nume AS NumeElev,E.prenume AS PrenumeElev, C.nume AS NumeCal,I.nume AS NumeInstructor FROM Elevi E
FULL JOIN Cursuri CU ON E.cod_elev=CU.cod_elev
FULL JOIN Cai C on C.cod_cal=CU.cod_cal
FULL JOIN Instructori I on I.cod_instructor=CU.cod_instructor;

--3 INTEROGARI CU CLAUZA GROUP BY
SELECT nume,salariu from Instructori WHERE prenume='Norbi' or prenume='Catalin' and not salariu<500 
GROUP BY salariu,nume;

SELECT producator,Count(cod_cal) AS numarEchipamenteCal from Echipamente WHERE producator='Setzi' or producator='Fouganza' and not marime='XXL' 
GROUP BY producator;

SELECT CU.data_curs, MAX(I.salariu) AS SalariuMaxAlInstructorilor from Instructori I
INNER JOIN Cursuri CU ON I.cod_instructor=CU.cod_instructor
GROUP BY CU.data_curs

SELECT CU.data_curs, MIN(I.salariu) AS SalariuMinAlInstructorilor from Instructori I
INNER JOIN Cursuri CU ON I.cod_instructor=CU.cod_instructor
GROUP BY CU.data_curs

SELECT A.localitate,Count(E.cod_adresa) catiLocuiesc from Elevi E
Right join Adrese A ON E.cod_adresa=A.cod_adresa
GROUP BY A.localitate
HAVING Count(E.cod_adresa)>0;
