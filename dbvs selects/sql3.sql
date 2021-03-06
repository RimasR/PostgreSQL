SELECT
  LEFT(Stud.Knyga.Pavadinimas, 1) AS first_letter,  
  COUNT(Stud.Egzempliorius.isbn) AS total, 
  COUNT(DISTINCT Stud.Knyga.Pavadinimas) as books 
FROM Stud.Knyga, Stud.Egzempliorius
WHERE Stud.Knyga.isbn = Stud.Egzempliorius.isbn
GROUP BY first_letter
HAVING COUNT(Stud.Egzempliorius.isbn) > 4;
