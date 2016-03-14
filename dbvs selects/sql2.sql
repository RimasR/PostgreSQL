SELECT DISTINCT vardas, pavarde
FROM Stud.Autorius, Stud.Egzempliorius 
WHERE Stud.Egzempliorius.paimta IS NOT NULL 
AND Stud.Autorius.isbn = Stud.Egzempliorius.isbn 
AND Stud.Autorius.pavarde LIKE '%yte';