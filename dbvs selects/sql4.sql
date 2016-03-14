CREATE TEMP TABLE IsleistosKnygos(Metai, Kiekis)

AS (SELECT Metai, COUNT(*)
    
    FROM Stud.Knyga
    
    GROUP BY Metai);



CREATE TEMP TABLE Vidurkis(Skaicius)

AS (SELECT AVG(Kiekis)
    
    FROM IsleistosKnygos);



SELECT IsleistosKnygos.Metai, COUNT(*)

FROM IsleistosKnygos, Vidurkis, Stud.Egzempliorius, Stud.Knyga

WHERE Kiekis > Skaicius
AND IsleistosKnygos.Metai = Knyga.Metai

AND Knyga.ISBN = Egzempliorius.ISBN

GROUP BY IsleistosKnygos.Metai