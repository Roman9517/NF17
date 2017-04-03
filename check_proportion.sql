CREATE FUNCTION check_proportion() RETURNS trigger AS $check_proportion$ 
	DECLARE
		prop integer;
    BEGIN
   		prop :=0;
		SELECT SUM (proportion) 
		FROM assembler 
		into prop
		where assembler.nom=NEW.nom 
		and assembler.annee_vin=NEW.annee_vin;
		IF ((prop + NEW.proportion) > 100) THEN RETURN NULL;
		ELSE RETURN NEW;
		END IF;
    END;
    
	$check_proportion$ LANGUAGE plpgsql;


CREATE TRIGGER check_proportion BEFORE INSERT ON assembler
    FOR EACH ROW EXECUTE PROCEDURE check_proportion();