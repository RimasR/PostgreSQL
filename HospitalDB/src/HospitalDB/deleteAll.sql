DROP TRIGGER checkBeginning ON rira1874.Gydymai;
DROP FUNCTION beforeToday();
DROP TRIGGER checkBudget ON rira1874.Gydytojas;
DROP FUNCTION budgetExceeded();
DROP VIEW rira1874.Gydytojai;
DROP VIEW rira1874.Pacientai;
DROP VIEW rira1874.Biudzetai;
DROP INDEX rira1874.Gydytojui;
DROP INDEX rira1874.LigoninesAdresui;
DROP TABLE rira1874.Gydymai CASCADE;
DROP TABLE rira1874.Pacientas CASCADE;
DROP TABLE rira1874.Gydytojas CASCADE;
DROP TABLE rira1874.Ligonine CASCADE;

