DROP TRIGGER IF EXISTS ri_1 ON employee;
DROP TRIGGER IF EXISTS ri_4 ON workplace;
DROP TRIGGER IF EXISTS ri_5 ON orders;

CREATE OR REPLACE FUNCTION ri_1_proc()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.bdate > CURRENT_DATE - INTERVAL '18 years' THEN
        RAISE EXCEPTION 'O empregado deve ter pelo menos 18 anos de idade.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ri_4_proc()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.address IN (SELECT address FROM office) AND NEW.address IN (SELECT address FROM warehouse)) OR
       (NEW.address NOT IN (SELECT address FROM office) AND NEW.address NOT IN (SELECT address FROM warehouse)) THEN
        RAISE EXCEPTION 'Um Workplace deve ser obrigatoriamente um Office ou Warehouse, mas não pode ser ambos.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ri_5_proc()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM contains
        WHERE order_num = NEW.order_num
    ) THEN
        RAISE EXCEPTION 'Uma Order deve figurar obrigatoriamente em Contains.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ri_1
BEFORE INSERT OR UPDATE ON employee
FOR EACH ROW EXECUTE PROCEDURE ri_1_proc();

CREATE TRIGGER ri_4
BEFORE INSERT OR UPDATE ON workplace
FOR EACH ROW EXECUTE PROCEDURE ri_4_proc();

CREATE TRIGGER ri_5
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW EXECUTE PROCEDURE ri_5_proc();