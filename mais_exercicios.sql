use bancodemo2;
/* tava sem ideia,me da um desconto*/

/*EXERCICIO 1 - Liste todos os artistas e seu total de discos lançados(ou inseridos no bandco)*/
SELECT artista, COUNT(*) AS total_discos
FROM catalogo
GROUP BY artista;

/*EXERCICIO 2 - Encontre os artistas que lançaram discos após 2010 e que têm mais de 2 discos no catálogo.*/
SELECT artista
FROM catalogo
WHERE lancamento > 2010
GROUP BY artista
HAVING COUNT(*) >2;

/*EXERCICIO 3 - Encontre o artista que tem o maior número de discos e liste o título
do disco mais recente desse artista.*/
SELECT c.artista, c.titulo
FROM catalogo c WHERE c.artista = (
 SELECT artista
 FROM catalogo
 GROUP BY artista
 ORDER BY COUNT(*) DESC
 LIMIT 1)
 ORDER BY c.lancamento DESC
 LIMIT 1;
 
 /*EXERCICIO 4 - Liste os títulos dos discos e os nomes dos artistas, ordenados pelo ano de lançamento.*/
SELECT titulo, artista 
FROM catalogo 
ORDER BY lancamento;

/*EXERCICIO 5 - Liste todos os funcionários que não têm um contato registrado e que ocupam cargos diferentes*/
SELECT *
FROM funcionario
WHERE (contato IS NULL OR contato = "") AND cargo <> gerente;

/*EXERCICIO 6 - encontre todos os discos que não têm um código de compra associado e liste o título e o artista.*/
SELECT c.titulo, c.artista
FROM catalogo c
LEFT JOIN disco d ON c.id = d.id_catalogo
WHERE c.codigo_compra IS NULL;

/*EXERCICIO 7  - Liste os clientes que têm um e-mail que contém 'gmail' e que também têm um telefone que começa com '9'*/
SELECT * FROM
cliente WHERE email LIKE "%gmail%" AND telefone LIKE "%9";

/*EXERCICIO 8 - Encontre o ano de lançamento do disco mais antigo e liste todos os artistas que lançaram discos nesse ano.*/
SELECT artista
FROM catalogo
WHERE lancamento = ( SELECT MIN(lancamento)
 FROM catalogo 
);
/*EXERCICIO 9 -Liste todos os artistas e o ano de lançamento do seu disco mais recente. */
SELECT artista, MAX(lancamento) AS ano_mais_recente
FROM catalogo
GROUP BY artista;

/*EXERCICIO 10 - Encontre todos os artistas que têm discos lançados entre 1995 e 2005 e que têm mais de 1 disco.*/
SELECT artista
FROM catalogo
WHERE lancamento BETWEEN 1995 AND 2005
GROUP BY artista
HAVING COUNT(*) > 1;

/*EXERCICIO 11 - Liste todos os funcionários e o número total de discos
 que cada um pode ter vendido (supondo que cada disco vendido é associado a um funcionário)*/
SELECT f.nome, COUNT(d.id) AS total_discos_vendidos
FROM funcionario f
LEFT JOIN disco d ON f.id = id_funcionaio
GROUP BY f.id;

/*EXERCICIO 12 - Encontre todos os discos que têm um código de compra que começa com
'A' e que foram lançados após 2015*/
SELECT c.titulo, c.artista
FROM catalogo c
JOIN disco d ON c.id = d.id_catalogo
WHERE codigo_compra LIKE "%A%" AND lancamento > 2015;

/*EXERCICIO 13 - Liste os artistas que têm discos lançados antes de 2000 e que
 também têm discos lançados após 2010.*/
SELECT DISTINCT artista
FROM catalogo
WHERE artista IN (
SELECT artista
FROM catalogo WHERE lancamento < 2000)
AND artista IN (
SELECT artista 
    FROM catalogo 
    WHERE lancamento > 2010
);
/*EXERCICIO 14 - Encontre o número total de discos e o número total de artistas no catálogo.*/
SELECT
(SELECT COUNT(*) FROM catalogo) AS total_discos,
(SELECT COUNT(DISTINCT artista) FROM catalogo) AS total_artistas;

/*EXERCICIO 15 -Liste todos os clientes que não têm nenhum disco associado
(supondo que a tabela disco tem um campo id_cliente que relaciona o disco ao cliente que o comprou).
 */
 
 SELECT c.nome 
FROM cliente c 
LEFT JOIN disco d ON c.id = d.id_cliente 
WHERE d.id IS NULL;