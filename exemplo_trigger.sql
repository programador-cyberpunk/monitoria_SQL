USE bancodemo2;

-- Trigger para registrar inserções na tabela disco
DELIMITER //
CREATE TRIGGER trg_after_insert_disco
AFTER INSERT ON disco
FOR EACH ROW
BEGIN
    INSERT INTO log_insercoes_disco (id_disco, data_insercao, codigo_compra)
    VALUES (NEW.id, NOW(), NEW.codigo_compra);
END;
//
DELIMITER ;

-- Trigger para registrar alterações no nome do artista
DELIMITER //
CREATE TRIGGER trg_after_update_artista
AFTER UPDATE ON catalogo
FOR EACH ROW
BEGIN
    IF OLD.artista <> NEW.artista THEN
        INSERT INTO log_alteracoes_artista (id_catalogo, data_alteracao, artista_antigo, artista_novo)
        VALUES (NEW.id, NOW(), OLD.artista, NEW.artista);
    END IF;
END;
//
DELIMITER ;

-- Trigger para impedir a exclusão de um cliente
DELIMITER //
CREATE TRIGGER trg_before_delete_cliente
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    DECLARE num_compras INT DEFAULT 0;

    -- Exemplo: descomente e ajuste essa linha caso haja uma tabela compras
    -- SELECT COUNT(*) INTO num_compras FROM compras WHERE id_cliente = OLD.id_cliente;

    IF num_compras > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir um cliente que possui compras.';
    END IF;
END;
//
DELIMITER ;

