-- Questão 4.1

CREATE OR REPLACE FUNCTION verificar_medico_ativo()
RETURNS TRIGGER AS $$
BEGIN

    IF (SELECT status FROM medico WHERE id = NEW.id_medico) = 0 THEN
        RAISE EXCEPTION 'Médico inativo';
    END IF;


    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_verificar_medico_ativo
BEFORE INSERT ON nascimento
FOR EACH ROW
EXECUTE FUNCTION verificar_medico_ativo();


INSERT INTO nascimento (id_mae, id_medico, nome, data_nascimento, peso, altura) 
VALUES (1, 3, 'Ana', '2025-04-01', 3.2, 48);
