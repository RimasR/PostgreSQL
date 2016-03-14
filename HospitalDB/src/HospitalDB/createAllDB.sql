CREATE TABLE rira1874.Ligonine (
    Pavadinimas VARCHAR(50)   NOT NULL,
    Adresas     VARCHAR(50)   NOT NULL,
    Biudzetas   INT           NOT NULL,
    PRIMARY KEY (Pavadinimas)
);

CREATE TABLE rira1874.Gydytojas (
    AK VARCHAR(11) NOT NULL,
    Vardas VARCHAR(20) NOT NULL,
    Pavarde VARCHAR(20) NOT NULL,
    Kvalifikacija VARCHAR(30) NOT NULL,
    Atlyginimas INT NOT NULL CONSTRAINT MinimalusAtlyginimas CHECK (Atlyginimas >= 400),
    Ligonines_Pavadinimas VARCHAR(50),
    PRIMARY KEY (AK),
    FOREIGN KEY (Ligonines_Pavadinimas) REFERENCES rira1874.Ligonine ON DELETE SET NULL
);

CREATE TABLE rira1874.Pacientas(
    AK VARCHAR(11) NOT NULL,
    Vardas VARCHAR(20) NOT NULL,
    Pavarde VARCHAR(20) NOT NULL,
    Gimimo_Metai DATE NOT NULL,
    PRIMARY KEY (AK)
);

CREATE TABLE rira1874.Gydymai(
    Gydymo_Nr INT NOT NULL,
    Pradeta DATE NOT NULL,
    Baigta DATE,
    Skirti_Vaistai VARCHAR(20) NOT NULL,
    Gydytojo_AK VARCHAR(11) NOT NULL,
    Paciento_AK VARCHAR(11) NOT NULL,
    Diagnoze VARCHAR(50) NOT NULL,
    PRIMARY KEY (Gydymo_Nr),
    FOREIGN KEY (Gydytojo_AK) REFERENCES rira1874.Gydytojas,
    FOREIGN KEY (Paciento_AK) REFERENCES rira1874.Pacientas
);

CREATE INDEX Gydytojui       ON rira1874.Gydytojas(Vardas, Pavarde);
CREATE UNIQUE INDEX LigoninesAdresui ON rira1874.Ligonine(Adresas);

--Check if given date is right to insert

CREATE FUNCTION beforeToday() RETURNS "trigger" AS $$
	BEGIN
		IF NEW.Pradeta < CURRENT_DATE
			THEN RAISE EXCEPTION 'Neteisinga data - negali buti anksciau nei siandien!';
		END IF;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER checkBeginning
	BEFORE INSERT OR UPDATE
	ON rira1874.Gydymai
	FOR EACH ROW
	EXECUTE PROCEDURE beforeToday();


--Check if you can insert new doctor with given hospital budget

CREATE FUNCTION budgetExceeded() RETURNS "trigger" AS $$
    DECLARE
      budget INT;
      sumOfSalaries INT;
      newSalary INT;
    BEGIN
      SELECT SUM(Atlyginimas) INTO sumOfSalaries
      FROM rira1874.Gydytojas
      WHERE Ligonines_Pavadinimas = NEW.Ligonines_Pavadinimas;

      SELECT Biudzetas INTO budget
      FROM rira1874.Ligonine, rira1874.Gydytojas
      WHERE Pavadinimas = NEW.Ligonines_Pavadinimas;

      SELECT NEW.Atlyginimas INTO newSalary
      FROM rira1874.Gydytojas;

      IF sumOfSalaries + newSalary > budget
        THEN RAISE EXCEPTION 'Virsytas Ligonines biudzetas - naujo gydytojo priskirti negalima.';
      END IF;
      RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER checkBudget
	 BEFORE INSERT OR UPDATE ON rira1874.Gydytojas
   FOR EACH ROW EXECUTE PROCEDURE budgetExceeded();

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

--Ligonines
--                                      (Pavadinimas)                                       (Adresas)               (Biudzetas)

INSERT INTO rira1874.Ligonine VALUES ('Vilniaus universiteto vaiku ligonine',         'Santariskiu g. 7, Vilnius',  300000);
INSERT INTO rira1874.Ligonine VALUES ('Vilniaus universitetine Antakalnio ligonine',  'Antakalnio g. 124, Vilnius', 250000);
INSERT INTO rira1874.Ligonine VALUES ('Vilniaus miesto klinikine ligonine',           'Antakalnio g. 57, Vilnius',  150000);
INSERT INTO rira1874.Ligonine VALUES ('Respublikine Kauno Ligonine',                  'Hipodromo g. 13, Kaunas',    100000);

--Gydytojai
--                                          AK,          vardas,      pavarde,    Kvalifikacija,  atlyginimas,        Ligonines_Pavadinimas
INSERT INTO rira1874.Gydytojas VALUES ('35903208111',   'Petras',  'Petrauskas', 'Chirurgas',         2500, 'Vilniaus universiteto vaiku ligonine');
INSERT INTO rira1874.Gydytojas VALUES ('35123858222',   'Juozas',  'Juozulis',   'Terapeutas',        1000, 'Vilniaus universitetine Antakalnio ligonine');
INSERT INTO rira1874.Gydytojas VALUES ('35174708333',   'Jonas',   'Jonaitis',   'Traumatologas ',    2000, 'Vilniaus miesto klinikine ligonine');
INSERT INTO rira1874.Gydytojas VALUES ('35905858444',   'Jonas',   'Jonauskas',  'Urologas',          1500, 'Vilniaus universiteto vaiku ligonine');
INSERT INTO rira1874.Gydytojas VALUES ('35907777555',   'Mantas',  'Mantauskas', 'Seimos gydytojas ', 3000, 'Vilniaus miesto klinikine ligonine');
INSERT INTO rira1874.Gydytojas VALUES ('35903788666',   'Linas',   'Linauskas',  'Kardiologas',       4000, 'Respublikine Kauno Ligonine');
INSERT INTO rira1874.Gydytojas VALUES ('49607300001',   'Jurgita', 'Jurgitaite', 'Akusere',           2000, 'Vilniaus universitetine Antakalnio ligonine');

--Pacientai
--                                        ak,         vardas,       pavarde,          Gimimo_Metai
INSERT INTO rira1874.Pacientas VALUES ('35903209111', 'Simas',      'Simaitis',     '1995-08-22');
INSERT INTO rira1874.Pacientas VALUES ('35903209222', 'Tomas',      'Tomaitis',     '1996-07-14');
INSERT INTO rira1874.Pacientas VALUES ('35903209333', 'Zygimantas', 'Rinkevicius',  '1948-01-01');
INSERT INTO rira1874.Pacientas VALUES ('35903209444', 'Rimas',      'Simkevicius',  '1978-12-24');

--Gydymai
--                              Gydymo Nr. Pradeta    Baigta  Skirti Vaistai  Gydytojo Ak  Paciento AK  Diagnoze

INSERT INTO rira1874.Gydymai VALUES ('1', '2015-12-21', NULL, 'Cinnabsin',   '35123858222', '35903209111', 'Sloga');
INSERT INTO rira1874.Gydymai VALUES ('2', '2015-12-21', NULL, 'Optive Plus', '35905858444', '35903209222', 'Akiu pazeidimas');
INSERT INTO rira1874.Gydymai VALUES ('3', '2015-12-21', NULL, 'Ibuprom',     '49607300001', '35903209333', 'Galvos skausmas');
INSERT INTO rira1874.Gydymai VALUES ('4', '2015-12-21', NULL, 'APAP',        '35903208111', '35903209444', 'Galvos skausmas');
