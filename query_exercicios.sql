use bancodemo2;

-- 1 liste todos os discos lançados depois de 2000
SELECT titulo FROM catalogo
WHERE lancamento < 2000;

-- 2 encontre o artista que lançou o album mais recente
SELECT artista FROM catalogo
WHERE lancamento = (SELECT MAX(lancamento) FROM catalogo);

-- 3 devolta uma lista com os clientes com o mesmo telefone que o funcionario 'ANA PAULA'.
SELECT nome FROM cliente
WHERE telefone = (SELECT contato FROM funcionario WHERE nome = 'Ana Paula');

-- 4 encontre todos os discos que o codigo de compra comece com 'C0'
SELECT codigo_compra FROM disco
WHERE codigo_compra LIKE 'C0%';

-- 5 devolva uma lista de artistas que tem mais de um disco no catalogo
SELECT artista FROM catalogo
GROUP BY artista HAVING COUNT(*) >1;

-- 6 liste funcionarios que tenham um contato que termine com '4321'
SELECT nome FROM funcionario
WHERE contato LIKE '%4321';

-- 7 encontre o disco mais antigo do catalogo
SELECT disco FROM catalogo
WHERE lancamento = (SELECT MIN(lancamento) FROM catalogo);

-- 8 encontre todos os discos de artistas que tambem sao clientes
SELECT DISTINCT c.artista 
FROM catalogo c 
WHERE c.artista IN (SELECT nome FROM cliente);

-- 9 Encontrar o número total de discos lançados por cada artista.
SELECT artista, COUNT(*) AS total_discos 
FROM catalogo 
GROUP BY artista;

-- 10 Encontrar todos os discos de artistas que também são clientes.
SELECT DISTINCT c.artista 
FROM catalogo c 
WHERE c.artista IN (SELECT nome FROM cliente);

-- 11 liste os clientes que tem numeros de telefone diferente dos funcionarios
SELECT nome FROM cliente
WHERE telefone NOT IN (SELECT contato FROM funcionario);

-- 12 liste os artistas que lançaram discos antes de 1990
SELECT artista FROM catalogo
WHERE lancameto < 1990;

-- 13 encontre a quantidade de discos por genero
SELECT genero, COUNT(*) AS total_discos
FROM catalogo GROUP BY genero;

-- 14 liste os disco que tenha um codigo de compra que nao esta presente na tabela "log de insrcoes" 
SELECT codigo_compra FROM disco
WHERE codigo_compra NOT IN (SELECT codigo_compra FROM log_insercoes_disco);

-- 15 liste o artista que teve a maior mudança de nome registrada na tabela "log de alterações"
SELECT artista_novo FROM log_alteracoes_artista
WHERE id = (SELECT MAX(id) FROM log_alteracoes_artista);

-- 16 liste os discos inseridos na tabela "log de insercoes"
SELECT d.codigo_compra FROM disco d
WHERE d.id IN (SELECT id_disco FROM log_insercoes_disco);