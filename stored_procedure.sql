use bancodemo2;

GO
CREATE PROCEDURE pesquisa
 @campoBusca VARCHAR(20) AS
 SELECT codigo ,descricao FROM tabela
 WHERE descricao = @campoBusca
 
 EXECUTE pesquisa
 DROP PROCEDURE pesquisa