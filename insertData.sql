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

INSERT INTO rira1874.Gydymai VALUES ('1', '2015-12-08', NULL, 'Cinnabsin',   '35123858222', '35903209111', 'Sloga');
INSERT INTO rira1874.Gydymai VALUES ('2', '2015-12-08', NULL, 'Optive Plus', '35905858444', '35903209222', 'Akiu pazeidimas');
INSERT INTO rira1874.Gydymai VALUES ('3', '2015-12-08', NULL, 'Ibuprom',     '49607300001', '35903209333', 'Galvos skausmas');
INSERT INTO rira1874.Gydymai VALUES ('4', '2015-12-08', NULL, 'APAP',        '35903208111', '35903209444', 'Galvos skausmas');
