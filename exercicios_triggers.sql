use bancodemo2

-- Definindo um delimitador diferente para evitar conflitos
DELIMITER $$

-- 1. Criar trigger de log para inserção de disco novo na tabela
CREATE TRIGGER trg_log_insercao_disco
AFTER INSERT ON disco
FOR EACH ROW
BEGIN
    INSERT INTO log_insercao_disco (id_disco, data_insercao, codigo_compra)
    VALUES (NEW.id, NOW(), NEW.codigo_compra);
END$$

-- 2. Trigger para registrar alteração do artista de um disco
CREATE TRIGGER log_alteracao_artista
BEFORE UPDATE ON catalogo
FOR EACH ROW
BEGIN
    IF OLD.artista <> NEW.artista THEN
        INSERT INTO log_alteracoes_artista (id_catalogo, data_alteracao, artista_antigo, artista_novo)
        VALUES (OLD.id, NOW(), OLD.artista, NEW.artista);
    END IF;
END$$

-- 3. Trigger que impede a inserção de discos com data inferior a 1948
CREATE TRIGGER trg_validacao_lancamento
BEFORE INSERT ON catalogo
FOR EACH ROW
BEGIN
    IF NEW.lancamento < 1948 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano de lançamento inválido';
    END IF;
END$$

-- 4. Trigger que define um padrão de contato como 'N/A' caso o valor inserido esteja vazio ou seja nulo
CREATE TRIGGER trg_contato_padrao_funcionario
BEFORE INSERT ON funcionario
FOR EACH ROW
BEGIN
    IF NEW.contato IS NULL OR TRIM(NEW.contato) = '' THEN
        SET NEW.contato = 'N/A';
    END IF;
END$$

-- 5. Trigger que exclui um disco na tabela log_insercao_disco
CREATE TRIGGER trg_exclusao_log_insercao_disco
AFTER DELETE ON disco
FOR EACH ROW
BEGIN
    DELETE FROM log_insercao_disco WHERE id_disco = OLD.id;
END$$

-- 6. Trigger para atualizar o catálogo em aplicações futuras
CREATE TRIGGER trg_atualiza_genero_catalogo
BEFORE UPDATE ON catalogo
FOR EACH ROW
BEGIN
IF OLD.genero <> NEW.genero THEN
        -- Placeholder para futuras atualizações
        -- Por exemplo: INSERT INTO log_alteracoes_genero (...)
END IF;
END$$

-- 7. Criar tabela para armazenar a contagem de discos por artista
CREATE TABLE IF NOT EXISTS contador_disco_artista (
    id_catalogo INT PRIMARY KEY,
    total_discos INT DEFAULT 0,
    FOREIGN KEY (id_catalogo) REFERENCES catalogo(id)
);

-- Trigger para incrementar a contagem ao inserir um disco
CREATE TRIGGER trg_incrementa_contador_disco
AFTER INSERT ON disco
FOR EACH ROW
BEGIN
    INSERT INTO contador_disco_artista (id_catalogo, total_discos)
    VALUES (NEW.id_catalogo, 1)
    ON DUPLICATE KEY UPDATE total_discos = total_discos + 1;
END$$

-- Trigger para decrementar a contagem ao deletar um disco
CREATE TRIGGER trg_decrementa_contador_disco
AFTER DELETE ON disco
FOR EACH ROW
BEGIN
    UPDATE contador_disco_artista
    SET total_discos = total_discos - 1
    WHERE id_catalogo = OLD.id_catalogo;
END$$

-- 8. Trigger que impede a inserção de dados já cadastrados (email)
CREATE TRIGGER trg_valida_email_unico
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM cliente WHERE email = NEW.email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email já cadastrado';
    END IF;
END$$

-- 9. Criar tabela de log para registrar alterações nos cargos de funcionários
CREATE TABLE IF NOT EXISTS log_altera_cargo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT,
    data_alteracao DATETIME,
    cargo_antigo VARCHAR(200),
    cargo_novo VARCHAR(200),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

-- Trigger que insere registros de alterações de cargo
CREATE TRIGGER trg_log_altera_cargo
BEFORE UPDATE ON funcionario
FOR EACH ROW
BEGIN
    IF OLD.cargo <> NEW.cargo THEN
        INSERT INTO log_altera_cargo (id_funcionario, data_alteracao, cargo_antigo, cargo_novo)
        VALUES (OLD.id_funcionario, NOW(), OLD.cargo, NEW.cargo);
    END IF;
END$$

-- 10. Trigger que formata o telefone informado pelo cliente para o padrão (xx) xxxxx-xxxx
CREATE TRIGGER trg_formata_telefone_cliente
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    IF NEW.telefone IS NOT NULL AND LENGTH(NEW.telefone) = 11 THEN
        SET NEW.telefone = CONCAT('(', SUBSTRING(NEW.telefone, 1, 2), ') ', SUBSTRING(NEW.telefone, 3, 5), '-', SUBSTRING(NEW.telefone, 8, 4));
    END IF;
END$$

-- 11. Trigger que converte o campo 'titulo' para letras maiúsculas ao inserir novos registros em 'catalogo'
CREATE TRIGGER trg_uppercase_titulo
BEFORE INSERT ON catalogo
FOR EACH ROW
BEGIN
    SET NEW.titulo = UPPER(NEW.titulo);
END$$

-- 12. Trigger que impede a exclusão de cliente cujo email termina com '@gmail.com'
CREATE TRIGGER trg_proteger_exclusao_cliente
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    IF OLD.email LIKE '%@gmail.com' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido excluir este endereço de email';
    END IF;
END$$

-- Restaurando o delimitador padrão

-- 13 crie um trigger que insira a data de inserçao na tabela log_insercoes_disco sempe que um disco fo atualizado
CREATE TRIGGER  trg_log_atualiza_disco
AFTER UPDATE ON disco
FOR EACH ROW
 BEGIN
   INSERT INTO log_insercoes_disco (id_disco, data_insercao, codigo_compra)
    VALUES (NEW.id, NOW(), NEW.codigo_compra);
    END$$
    
   -- 14 crie um trigger que garanta que não exista um artista com valor vazio ou nulo
   CREATE TRIGGER trg_valida_artista_nao_vazio
   BEFORE INSERT ON catalogo
   FOR EACH ROW
    BEGIN
    IF TRIM(NEW.artista) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do artista não pode ser vazio';
    END IF;
    END$$
    
    -- 15 crie um trigger que formate o nome do cliente para letras maiusculas quando novos registros sao inseridos na tabela cliente
    CREATE TRIGGER trg_letramaiuscula_nome_cliente
    BEFORE INSERT ON cliente
    FOR EACH ROW
     BEGIN
     SET NEW.nome = UPER(NEW.nome);
     END$$

 -- 16 crie uma tabela log para que registrar a exclusao de clientes e um trigger que registre nessa tabela que registre a exclusao
 CREATE TABLE excluidos(
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_cliente INT,
  data_exclusao DATETIME,
  nome_cliente VARCHAR(200),
   FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
 );
  CREATE TRIGGER trg_log_exclusao
  AFTER DELETE ON cliente
  FOR EACH ROW
   BEGIN
    INSERT INTO log_exclusao_cliente (id_cliente, data_exclusao, nome_cliente)
    VALUES (OLD.id_cliente, NOW(), OLD.nome);
END$$

-- 17 crie um tigger que impeça a inserão de um codigo de barras duplicado
 CREATE TRIGGER trg_codigo_duplicado
 BEFORE INSERT ON disco
  FOR EACH ROW
   BEGIN
      IF EXISTS (SELECT 1 FROM disco WHERE codigo_compra = NEW.codigo_compra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código de compra já cadastrado';
    END IF;
    END $$
    
 -- 18 crie um trigger que atualiza a data de um disco para a data atual sempre que o um disco for alterado
  CREATE TRIGGER trg_data_atualiza
  BEFORE UPDATE ON catalogo
  FOR EACH ROW
   BEGIN
     IF OLD.titulo <> NEW.titulo THEN
        SET NEW.lancamento = YEAR(NOW());
    END IF;
END$$

-- 19 crie uma tabela que registre o contato dos funcionarios e um trigger que insira um registro nela sempre que for atualizado

CREATE TABLE log_alteracao_contato_funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT,
    data_alteracao DATETIME,
    contato_antigo VARCHAR(200),
    contato_novo VARCHAR(200),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TRIGGER trg_log_alteracao_contato
BEFORE UPDATE ON funcionario
FOR EACH ROW
BEGIN
    IF OLD.contato <> NEW.contato THEN
        INSERT INTO log_alteracao_contato_funcionario (id_funcionario, data_alteracao, contato_antigo, contato_novo)
        VALUES (OLD.id_funcionario, NOW(), OLD.contato, NEW.contato);
    END IF;
END$$
-- 20 crie um trigger que impeça a inserçao de um ano de lançamento negativao
CREATE TRIGGER trg_ano_nao_negativo
BEFORE INSERT ON catalogo
 FOR EACH ROW
  BEGIN
  IF NEW.lancamento < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ano de lançemento invalido";
      END IF;
  END$$;    
DELIMITER ;
