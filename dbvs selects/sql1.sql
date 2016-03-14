SELECT nr, paimta, grazinti 
FROM Stud.Egzempliorius
WHERE paimta < CURRENT_DATE - 3
ORDER BY nr ASC;