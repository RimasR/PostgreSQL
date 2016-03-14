CREATE VIEW rira1874.Gydytojai AS
    SELECT AK, Vardas, Pavarde
    FROM rira1874.Gydytojas;

CREATE VIEW rira1874.Pacientai AS
    SELECT Vardas, Pavarde
    FROM rira1874.Pacientas;

CREATE VIEW rira1874.Biudzetai AS
    SELECT Pavadinimas AS LigoninesPavadinimas,
           Biudzetas,
           SUM(Atlyginimas) AS AtlyginimuSuma
    FROM rira1874.Gydytojas, rira1874.Ligonine
    WHERE(Ligonine.Pavadinimas = Gydytojas.Ligonines_Pavadinimas)
    GROUP BY LigoninesPavadinimas, Biudzetas;
