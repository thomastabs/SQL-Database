CREATE OR REPLACE FUNCTION check_employee_age()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.bdate > CURRENT_DATE - INTERVAL '18 years' THEN
        RAISE EXCEPTION 'O empregado deve ter pelo menos 18 anos de idade.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_workplace_type()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.address IN (SELECT address FROM office) AND NEW.address IN (SELECT address FROM warehouse)) OR
       (NEW.address NOT IN (SELECT address FROM office) AND NEW.address NOT IN (SELECT address FROM warehouse)) THEN
        RAISE EXCEPTION 'Um Workplace deve ser obrigatoriamente um Office ou Warehouse, mas não pode ser ambos.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_order_contains()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM contains
        WHERE order_num = NEW.order_no
    ) THEN
        RAISE EXCEPTION 'Uma Order deve figurar obrigatoriamente em Contains.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER employee_age_trigger
BEFORE INSERT OR UPDATE ON employee
FOR EACH ROW
EXECUTE FUNCTION check_employee_age();

CREATE TRIGGER workplace_type_trigger
BEFORE INSERT OR UPDATE ON workplace
FOR EACH ROW
EXECUTE FUNCTION check_workplace_type();

CREATE TRIGGER order_contains_trigger
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION check_order_contains();