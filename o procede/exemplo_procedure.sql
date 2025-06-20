DELIMITER //
-- procedure local
CREATE PROCEDURE InserirDiscoLocal(
    IN p_id_catalogo INT,
    IN p_codigo_compra VARCHAR(300)
)
BEGIN
    DECLARE v_id INT;

    -- Inserir disco e capturar o ID gerado
    INSERT INTO disco (id_catalogo, codigo_compra) 
    VALUES (p_id_catalogo, p_codigo_compra);
    
    SET v_id = LAST_INSERT_ID();
    
    SELECT v_id AS id_disco_inserido;
END //

DELIMITER ;

DELIMITER //

-- procedure temporario
CREATE PROCEDURE RelatorioTemporario()
BEGIN
    CREATE TEMPORARY TABLE temp_disco AS
    SELECT c.artista, c.titulo, d.codigo_compra 
    FROM catalogo c
    JOIN disco d ON c.id = d.id_catalogo;

    SELECT * FROM temp_disco;
END //

DELIMITER ;

DELIMITER //

-- procedimento de sistema
CREATE PROCEDURE VerificarStatusBanco()
BEGIN
    SELECT DATABASE() AS banco_atual, 
           @@version AS versao_banco, 
           @@hostname AS hostname;
END //

DELIMITER ;

DELIMITER //

-- procedure remoto
CREATE PROCEDURE ChamarProcedimentoRemoto()
BEGIN
    CALL servidor_remoto.OutroBanco.RemoverDisco(1);
END //

DELIMITER ;

DELIMITER //

-- procedure extendido 
CREATE PROCEDURE RelatorioDiscosEstendido(
    IN p_artista VARCHAR(200) DEFAULT NULL
)
BEGIN
    IF p_artista IS NULL THEN
        SELECT c.artista, c.titulo, d.codigo_compra 
        FROM catalogo c
        JOIN disco d ON c.id = d.id_catalogo;
    ELSE
        SELECT c.artista, c.titulo, d.codigo_compra 
        FROM catalogo c
        JOIN disco d ON c.id = d.id_catalogo
        WHERE c.artista = p_artista;
    END IF;
END //

DELIMITER ;

CALL InserirDiscoLocal(1, 'C012');
CALL RelatorioTemporario();
CALL VerificarStatusBanco();
CALL ChamarProcedimentoRemoto();
CALL RelatorioDiscosEstendido('Nirvana');