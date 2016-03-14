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
