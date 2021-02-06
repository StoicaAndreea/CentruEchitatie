use Centru_echitatie
go

-- view cu instructorii, elevii si caii si data cursului
create view vw_curs_elev_cal_instructor as
SELECT cod_curs,e.nume as nume_elev,e.prenume as prenume_elev,i.nume as nume_instructor,c.nume as nume_cal,data_curs,ora_curs
FROM Cursuri cu,Elevi e,Instructori i,Cai c
WHERE cu.cod_instructor=i.cod_instructor AND 
	cu.cod_elev=e.cod_elev AND		
	cu.cod_cal=c.cod_cal;
go

select * from vw_curs_elev_cal_instructor;
go

create view vw_curs_elev_cal_instructor1 as
SELECT CU.cod_curs AS CodCurs,CU.data_curs, E.nume AS NumeElev,E.prenume AS PrenumeElev, 
C.nume AS NumeCal,I.nume AS NumeInstructor FROM Elevi E
INNER JOIN Cursuri CU ON E.cod_elev=CU.cod_elev
INNER JOIN Cai C on C.cod_cal=CU.cod_cal
INNER JOIN Instructori I on I.cod_instructor=CU.cod_instructor
Where data_curs<convert(date,getDate());

go

Insert into Cursuri(cod_elev,cod_instructor,cod_cal,data_curs,ora_curs)
Values(2,2,2,convert(date,getDate()),'11:11:11')
go
select * from vw_curs_elev_cal_instructor1;
go

go

create view vw_curs_elev_cal_instructor2 as
SELECT CU.cod_curs AS CodCurs,CU.data_curs, E.nume AS NumeElev,E.prenume AS PrenumeElev, 
C.nume AS NumeCal,I.nume AS NumeInstructor FROM Elevi E
INNER JOIN Cursuri CU ON E.cod_elev=CU.cod_elev
INNER JOIN Cai C on C.cod_cal=CU.cod_cal
INNER JOIN Instructori I on I.cod_instructor=CU.cod_instructor
Where data_curs=convert(date,getDate());
go
select * from vw_curs_elev_cal_instructor2;
go

--trigger insert
create trigger dbo.insert_Elevi
on dbo.Elevi
for insert
as
begin
	set nocount on;
	select nume,prenume,data_nasterii,cod_adresa from inserted;
	print 'INSERT'
	print convert(varchar, getdate(), 0)
	print 'tabel: Elevi';

end;
go
insert Elevi (nume,prenume,data_nasterii,cod_adresa,telefon) values
('Ionescu','Vlad','1989-12-02',3,'0458899151');
go

select * from Elevi;


go
--trigger delete
create trigger dbo.delete_Elevi
on dbo.Elevi
for delete
as
begin
	set nocount on;
	print 'DELETE'
	print convert(varchar, getdate(), 0)
	print 'tabel: Elevi';
end;
go

delete from Elevi
where prenume='Vlad';
go