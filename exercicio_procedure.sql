use bancodemo2;

-- 1 crie um procedimento para inserir um disco na tabela
DELIMITER //
 CREATE PROCEDURE InserirDisco(
 IN p_id_catalogo INT,
 IN p_codigo_compra VARCHAR(300)
 )
  BEGIN 
   INSERT INTO disco (id_catalogo, codigo_compra) VALUES (p_id_catalogo, p_id_compra);
   INSERT INTO log_insercoes_disco(id_disco, data_insercao, codigo_compra) VALUES (LAST_INSERT_ID(), NOW(), p_codigo_compra);
 END
 
 CALL InserirDisco(1, 'CO11');
 DELIMITER ;
 
 -- 2 crie um procedimento para atualizar um artisco no banco
 DELIMITER //
  CREATE PROCEDURE AtualizaArtista(
  IN p_id_catalogo INT,
  IN p_artista_novo VARCHAR(200)
  )
   BEGIN
    DECLARE v_artista_artigo VARCHAR(200);
    SELECT artista INTO v_artista_antigo FROM catalogo WHERE id = p_id_catalogo;
    UPDATE catalogo SET artista = p_artista_novo WHERE id = p_id_catalogo;
     INSERT INTO log_alteracoes_artista (id_catalogo, data_alteracao, artista_antigo, artista_novo)
     VALUES (p_id_catalogo, NOW(), v_artista_antigo, p_artista_novo);
     
    CALL AtualizarArtista(1, 'Nirvana Atualizado'); 
   END //
   DELIMITER ;
   
   -- 3 crie um procedimento que busque o disco pelo artista
   
   DELIMITER //
   CREATE PROCEDURE BuscaDiscoArtista(
   IN p_artista VARCHAR(200)
   )
    BEGIN
     SELECT * FROM disco d
      JOIN catalogo c ON d.id_catalogo = c.id WHERE c.artista = p_artista;
       -- cez ainda vao ver join e inner join
       CALL BuscarDiscoPorArtista('Nirvana');
       END //
       DELIMITER ;
       
       -- 4 crie um procedimento que conte discos por genero
       DELIMITER //
        CREATE PROCEDURE ContaPorGenero()
         BEGIN
          SELECT genero, COUNT(*) AS total_discos FROM catalogo
          GROUP BY genero;
          CALL ContarDiscosPorGenero();
         END //
         DELIMITER ;
         
      -- 5   faça um procedimento que busque um funcionario pelo cargo
      DELIMITER //
       CREATE PROCEDURE BuscaFuncCargo(
        IN p_cargo VARCHAR(200)
       )
	   BEGIN
        SELECT * FROM funcionario WHERE cargo = p_cargo;
        CALL BuscarFuncionarioPorCargo('Vendedora');
        END //
        DELIMITER ;
        
        -- 6 crie um procedimento que busque os clientes pelo telefone
      DELIMITER //
       CREATE PROCEDURE BuscaCLienteTelefone(
        IN p_telefone VARCHAR(15)
       )
       BEGIN
        SELECT * FROM cliente WHere telefone = p_telefone;
        END //
        CALL BuscarClientePorTelefone('1198765-4321');
        DELIMITER ;
        
        -- 7 use um procedimento para listar discos por lancamento
        DELIMITER //
        CREATE PROCEDURE ListaDiscoLancamento(
         IN p_ano INT
        )
        BEGIN
         SELECT * FROM catalogo WHERE lancamento = p_ano;
         CALL ListarDiscosPorLancamento(2011);
         END //
         DELIMITER ;
         
         -- 8  Crie um procedimento que remova um disco
         DELIMITER //
         CREATE PROCEDURE removeDisco(
         IN p_id_disco INT
         )
         BEGIN 
          DELETE FROM disco WHERE id = p_id_disco;
          CALL RemoverDisco(1);
          END //
          DELIMITER ;
          
          -- 9 crie um procedimento que atualiza o contato do funcionario
          DELIMITER //
          CREATE PROCEDURE AtualizaContatoFunc(
           IN p_id_funcionario INT,
           IN p_novo_contato VARCHAR(200)
          )
           BEGIN 
            UPDATE funcionario SET contato = p_novo_contato WHERE id_funcionario = p_id_funcionario;
            CALL AtualizaContatoFunc(1, '1199999-9999');
            END //
            DELIMITER ;
            
           -- 10 crie um procedimento que  busque um cliente por email
           DELIMITER //
           CREATE PROCEDURE BuscaClienteEmail(
           IN p_email VARCHAR(200)
           )
           BEGIN 
           SELECT * FROM cliente WHERE email =p_email;
           CALL BuscaClienteEmail('juliana@gmail.com');
           END //
           DELIMITER ;
           
           -- 11 Crie um procedimento que lista os funcionarios]
           DELIMITER //
           CREATE PROCEDURE ListaFuncionario()
            BEGIN
            SELECT * FROM funcionario ORDER BY nome;
            CALL ListaFuncionario();
            END //
            DELIMITER ;
            
            -- 12 crie um procedimento que busque um digito pelo codigo de compra
            DELIMITER //
             CREATE PROCEDURE BuscaCodigo(
              IN p_codigo_compra VARCHAR(200)
             )
             BEGIN
              SELECT * FROM disco WHERE codigo_compra = p_codigo_compra;
              CALL BuscaCodigo('C001');
              END //
              DELIMITER ;
              
              -- 13 crie uma procedure que conte clientes pelo dominio do email
              DELIMITER //
               CREATE PROCEDURE ClienteDominioEmail(
               IN p_dominio VARCHAR(100)
               )
               BEGIN
                 SELECT COUNT(*) AS total_clientes FROM cliente
                 WHERE email LIKE CONCAT('%', p_dominio);
                 CALL ClienteDominioEmal('@gmail');
                 END //
                 DELiMITER ;
                 
				-- 14 crie uma procedure que que liste discos e artistas
                DELIMITER //
                 CREATE PROCEDURE ListarDiscosArtista()
                  BEGIN
                   SELECT d.*, c.artista FROM disco d
                   JOIN catalogo c ON d.id_catalogo = c.id;
                   CALL ListarDiscosArtista('Nevermind', 'Nirvana');
                   END //
                   DELIMITER ;
                   
				-- 15 crie um procedimento que busque um disco por titulo
                DELIMITER //
                CREATE PROCEDURE BuscaDiscoTitulo(
                 IN p_titulo VARCHAR(200) )
                  BEGIN
                  SELECT * FROM catalogo WHERE titulo = p_titulo;
                  CALL BuscaDiscoTitulo();
                  END //
                  DELIMITER ;
                  
                  -- 16 crie um procedimento que atualize o genero do disco
                  DELIMITER //
                  CREATE PROCEDURE MudaGenero(
                   IN p_id_disco INT, IN p_novo_genero VARCHAR(200) )
                   BEGIN
                    UPDATE catalogo SET genero = p_novo_genero;
                    CALL MudaGenero();
                    END //
                    DELIMITER ;
                    
                 -- 17 crie um procedimento que liste discos por artistas e genero  
                    DELIMITER //
                    CREATE PROCEDURE ListaDiscosArtistaGenero(
                     IN p_artista VARCHAR(200),
                     IN p_genero VARCHAR(200)
                    )
                    BEGIN
                     SELECT * FROM disco d
                     JOIN catalogo c ON d.id_catalogo = c.id 
                     WHERE c.artista = p_artista AND c.genero;
                     CALL ListaDiscosArtistaGenero();
                     END //
                     DELIMITER ;
                     
                   -- 18 crie um procedimento que conte discos por artista
                   DELIMITER //
                   CREATE PROCEDURE ContaDiscoPorArtista()
                    BEGIN
                     SELECT c.artista, COUNT(d.id) AS total_discos 
                     FROM catalogo c LEFT JOIN disco d ON c.id = d.id_catalogo
                     GROUP BY c.artista;
                     CALL ContaDiscoPorArtista();
                     END //
                     DELIMITER ;
                     
                     -- 19 crie um procedimento que busque o funcionaio por nome
                     DELIMITER //
                      CREATE PROCEDURE BuscaFuncionarioNome(
                       IN p_nome VACHAR(200)
                      )
                       BEGIN
                        SELECT * FROM funcionario WHERE nome LIKE CONCAT('%', p_nome, '%');
                        CALL BuscaNomeFuncionario();
                        END //
                        DELIMITER ;
                        
                      -- 20  crie um procedimento que liste clientes e seus telefones
                       DELIMITER //
                       CREATE PROCEDURE ListaClienteTelefone()
                        BEGIN
                         SELECT nome, telefone FROM cliente;
                         CALL ListaClienteTelefone();
                         END //
                         DELIMITER ;