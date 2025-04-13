use exercicios;
/*exercicio1
Liste os títulos dos filmes cujo orçamento é superior à média de todos os orçamentos.*/

SELECT titulo
FROM filmes
WHERE orcamento > (SELECT AVG(orcamento) FROM filmes);
/*Explicação: A subconsulta (SELECT AVG(orcamento) FROM filmes) calcula a média do orçamento de todos os filmes.
A consulta principal seleciona os títulos dos filmes cujo orçamento é maior que essa média.*/

/*exercicio2
Liste os nomes das empresas que têm pelo menos um filme com bilheteira acima da média.*/

SELECT DISTINCT e.nome
FROM empresas e
WHERE e.id IN (
    SELECT f.empresa_id
    FROM filmes f
    WHERE f.bilheteira > (SELECT AVG(bilheteira) FROM filmes)
);
/*Explicação: A subconsulta interna calcula a média da bilheteira.
A subconsulta do meio seleciona os IDs das empresas que têm filmes com bilheteira acima dessa média.
A consulta principal retorna os nomes dessas empresas.*/


/*Exercício 3: Filmes com Nota Acima da Média
Pergunta: Liste os títulos dos filmes que têm uma nota superior à média das notas.*/

SELECT titulo
FROM filmes
WHERE nota > (SELECT AVG(nota) FROM filmes);

/*Explicação: A subconsulta calcula a média das notas dos filmes.
A consulta principal seleciona os títulos dos filmes cuja nota é maior que essa média*/

/*Exercício 4: Empresas com Mais de 2 Filmes
Pergunta: Liste os nomes das empresas que têm mais de 2 filmes na tabela.*/

SELECT e.nome
FROM empresas e
WHERE e.id IN (
    SELECT f.empresa_id
    FROM filmes f
    GROUP BY f.empresa_id
    HAVING COUNT(*) > 2
);
/*Explicação: A subconsulta conta quantos filmes cada empresa tem e filtra aquelas com mais de 2 filmes.
A consulta principal retorna os nomes dessas empresas.*/

/*Exercício 5: Filmes com Bilheteira Acima da Média da Empresa
Pergunta: Liste os títulos dos filmes cuja bilheteira é superior à média de bilheteira da empresa correspondente.*/

SELECT f.titulo
FROM filmes f
WHERE f.bilheteira > (
    SELECT AVG(bilheteira)
    FROM filmes
    WHERE empresa_id = f.empresa_id
);
/*Explicação: A subconsulta calcula a média da bilheteira para a empresa do filme atual.
A consulta principal seleciona os títulos dos filmes cuja bilheteira é maior que essa média.*/

/*Exercício 6: Filmes com Orçamento Acima da Média de Seu Ano
Pergunta: Liste os títulos dos filmes cujo orçamento é superior à média dos orçamentos dos filmes lançados no mesmo ano.*/

SELECT f.titulo
FROM filmes f
WHERE f.orcamento > (
    SELECT AVG(orçamento)
    FROM filmes
    WHERE ano = f.ano
);
/*Explicação: A subconsulta calcula a média do orçamento dos filmes do mesmo ano.
A consulta principal seleciona os títulos dos filmes cujo orçamento é maior que essa média.*/

/*Exercício 7: Empresas com Filmes em Vários Idiomas
Pergunta: Liste os nomes das empresas que têm filmes em mais de um idioma.*/

SELECT e.nome
FROM empresas e
WHERE e.id IN (
    SELECT f.empresa_id
    FROM filmes f
    WHERE f.id IN (
        SELECT f1.id
        FROM filmes f1
        GROUP BY f1.empresa_id, f1.id
        HAVING COUNT(DISTINCT f1.idioma) > 1
    )
);
/*Explicação: A subconsulta interna conta os idiomas distintos dos filmes de cada empresa.
A consulta principal retorna os nomes das empresas que têm filmes em mais de um idioma.*/

/*Exercício 8: Filmes com Bilheteira Acima da Média de Todos os Filmes
Pergunta: Liste os títulos dos filmes que têm bilheteira acima da média de todos os filmes.*/

SELECT titulo
FROM filmes
WHERE bilheteira > (SELECT AVG(bilheteira) FROM filmes);

/*Explicação: A subconsulta calcula a média da bilheteira de todos os filmes.
A consulta principal seleciona os títulos dos filmes cuja bilheteira é maior que essa média.*/

/*Exercício 9: Empresas com Filmes Lançados Após um Ano Específico
Pergunta: Liste os nomes das empresas que têm pelo menos um filme lançado após 2000.*/

SELECT DISTINCT e.nome
FROM empresas e
WHERE e.id IN (
    SELECT f.empresa_id
    FROM filmes f
    WHERE f.ano > 2000
);
/*Explicação: A subconsulta seleciona os IDs das empresas que têm filmes lançados após 2000.
A consulta principal retorna os nomes dessas empresas.*/

/*Exercício 10: Filmes com Nota Acima da Média de Sua Empresa
Pergunta: Liste os títulos dos filmes cuja nota é superior à média das notas dos filmes da mesma empresa.*/

SELECT f.titulo
FROM filmes f
WHERE f.nota > (
    SELECT AVG(nota)
    FROM filmes
    WHERE empresa_id = f.empresa_id
);
/*Explicação: A subconsulta calcula a média das notas dos filmes da empresa correspondente ao filme atual.
A consulta principal seleciona os títulos dos filmes cuja nota é maior que essa média.*/