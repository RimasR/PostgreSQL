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
