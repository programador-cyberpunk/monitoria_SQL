-- 1 criar trigger de lob para insercao de disco novo na tabela

CREATE TRIGGER trg_log_insercao_disco
AFTER INSERT ON disco FOR EACH ROW
BEGIN
 INSERT INTO log_insercao_disco (id_disco ,data_insercao,codigo_compra)
 VALUES (NEW.id, NOW(), NEW.codigo_compra)
 END;
 
 -- 2 trigger para registrar alterar o artista de um disco da tabela "log_alteracao_artista"
 
 CREATE TRIGGER log_alteracao_artista
 BEFORE UPDATE ON catalogo
 BEGIN  
  IF OLD.artista <> NEW.artista THEN
  INSERT INTO log_alteracoes_artista (id_catologo, data_alteracao, artista)
  VALUES (OLD.id, NOW(), OLD>artista, NEW.artista)
  END IF;
 END;
 
 -- 3 crie um trigger que impede a inserção de discos com data inferior a 1948
 CREATE TRIGGER trg_validacao_lancamento
 BEFORE INSERT ON catalogo
 FOR EACH ROW
 BEGIN
  IF NEW.lancamento < 1947 THEN
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ano de lancamento invalido",
  END IF;
  END;
  
  -- 4 crie um trigger que defina um padrao de contato que seria N/A caso
  -- o valor inserido esteja vazio ou seja nulo
  
  CREATE TRIGGER trg_contato_padrao_funcionario
  BEFORE INSERT ON funcionario
  FOR EACH ROW
BEGIN
    IF NEW.contato IS NULL OR NEW.contato = ' ' THEN
    SET NEW.contato = 'N/A'
    END IF;
END;

-- 5 crie um trigger que exclua um disco na tabela log_insercao_disco
CREATE TRIGGER trg_exclusao_log_isercao_disco
AFTER DELETE ON disco
FOR EACH ROW
BEGIN
 DELETE FROM log_insercoes_disco WHERE id_disco = OLD.id
 END;
 
 -- 6 crie um trigger que de para atualizar o catalogo em aplicaçoes futuras
 CREATE TRIGGER trg_atualiza_genero_catalogo
 BEFORE UPDATE ON catalogo
 FOR EACH ROW
  BEGIN
  IF OLD.genero <> NEW.genero THEN 
  -- isso e na vdd um placeholder para futuras atualizaçoes
END IF
END;

-- 7 crie duas tabelas, uma para armazenar a contagem de discos por artista
-- e um trigger para incrementar a cpontagem ao inserir um disco
CREATE TABLE IF NOT EXISTS contador_disco_artista(
 id_catalogo INT PRIMARY KEY,
 total_discos INT DEFAULT 0,
 FOREIGN KEY (id_catalogo) REFERENCES catalogo(id)
);
CREATE TRIGGER trg_incrementa_contador_disco
AFTER INSERT ON disco
FOR EACH ROW
 BEGIN
 INSERT INTO contador_disco_artista (id_catalogo, total_discos)
 VALUES (NEW.id_catalogo, 1)
  ON DUPLICATE KEY UPDATE total_discos = total_discos + 1;
  END;
  CREATE TRIGGER trg_decrementa_contador_disco
  AFTER DELETE ON disco
  FOR EACH ROW
  BEGIN
   UPDATE contador_discos_artista
   SET total_discos = total_discos - 1;
   WHERE id_catalogo = OLD.id_catalogo;
   END;
   
   -- 8 crie um trigger que impeça a insercao de dados ja cadastrados
   -- especificamente o email
   CREATE TRIGGER trg_valida_email_unico
   BEFORE INSERT ON cliente
   FOR EACH ROW
    BEGIN
    IF EXISTS(SELECT 1 FROM cliente WHERE email = NEW.email) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Email ja cadastrado";
       END;
       
       -- 9 crie uma tabela de log para registrar alteracoes no cargos de funcionarios e um trigger que insira esses registros
       CREATE TABLE IF NOT EXISTS log_altera_cargo(
        id INT PRIMARY KEY AUTO_INCREMENT,
        id_funcionario INT,
        data_alteracao DATETIME ,
        cargo_antigo VARCHAR(200),
        cargo_novo VARCHAR(200),
        FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
       );
       
       CREATE TRIGGER trg_log_altera_cargo
       BEFORE UPDATE ON funcionario
       FOR EACH ROW
        BEGIN
         IF OLD.cargo > NEW.cargo THEN
          INSERT INTO log_altera_cargo (id_funcionario, data_alteracao, cargo_antigo, cargo_novo)
          VALUES (OLD.id_funcionario, NOW(), OLD.cargo, NEW.cargo);
          END IF;
          END;
          
	-- 10 crie um trigger que formate o telefone informado pelo cliente por um padrao xx xxxxx-xxxx,considerando que tenha 11 digitos
     CREATE TRIGGER trg_formata_telefone_cliente
     BEFORE INSERT ON cliente
     FOR EACH ROW
      BEGIN
       IF NEW.telefone IS NOT NULL THEN
         SET NEW.telefone = CONCAT('(', SUBSTRING(NEW.telefone, 1, 2), ') ', SUBSTRING(NEW.telefone, 3, 5), '-', SUBSTRING(NEW.telefone, 8, 4));
	 END IF;
     END;
     
     -- 11 Crie um trigger que converta o campo 'titulo' para letras maiusculas ao inserir novos registros em 'catalogo'
   CREATE TRIGGER trg_uppercase_titulo
    BEFORE INSERT ON catalogo
    FOR EACH ROW
     BEGIN
      SET NEW.titulo = UPPER(NEW.titulo);
      END;
      
     -- 12 crie um trigger que impeça a exclusao de cliente que o email termina com o endereço "@gmail.com"
     CREATE TRIGGER trg_proteger_exclusao_cliente
     BEFORE DELETE ON cliente
      FOR EACH ROW
       BEGIN
        IF OLD.email LIKE '%@gmail.com' THEN
        SIGNAL SQLSTATE '450000' SET MESSAGE_TEXT = " Nao e permitido excluir esse endereco de email";
        END IF
        END;