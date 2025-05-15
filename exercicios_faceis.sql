/* fonte:https://learnsql.com.br/blog/10-exercicios-praticos-de-sql-para-iniciantes-com-solucoes/*
/*Exercício 1: Seleção de todas as colunas de uma tabela
Exercício: Selecionar todos os dados da tabela distribution_companies.

Solução:*/
 use exercicios;
 
SELECT *
FROM distribuicao;
/*Explicação da solução: Selecione os dados usando a instrução SELECT.
Para selecionar todas as colunas, use um asterisco (*).
A tabela da qual os dados são selecionados é especificada na cláusula FROM.*/



/*Exercício 2: Seleção de algumas colunas em uma tabela
Exercício: Para cada filme, selecione o título do filme, a classificação IMDb e o ano em que o filme foi lançado.

Solução:*/
SELECT
  filme_titulo,
  imdb_nota,
  ano_lancamento
FROM filmes;

/*Explicação da solução: 
Liste todas as colunas necessárias ( filme_titulo, imdb_nota e ano_lancamento) na declaração SELECT, separadas por vírgula.
 Faça referência à tabela movies na cláusula FROM.*/
 
/* Exercício 3: Seleção de algumas colunas e filtragem de dados numéricos em WHERE
Exercício: Selecione as colunas filme_titulo e bilheteria na tabela filmes. Mostre somente os filmes com ganhos acima de US$ 300 milhões.

Solução:*/
SELECT
  filme_titulo,
  bilheteria
FROM filmes
WHERE lucro > 300;
/*Explicação da solução: Liste as colunas em SELECT e faça referência à tabela em FROM. 
Use uma cláusula WHERE para filtrar os dados - 
escreva a coluna bilheteria e use o operador "maior que" (>) para mostrar somente os valores acima de US$ 300 milhões.*/

/*Exercício 4: Seleção de algumas colunas e filtragem de dados de texto em WHERE
Exercício: Selecione as colunas filme_titulo, imdb_nota e ano_lancamento da tabela filmes.
 Mostre os filmes que têm a palavra "Godfather" no título.
Solução:*/

SELECT
 filme_titulo,
  imdb_nota,
  ano_lancamento
FROM filmes
WHERE filme_titulo LIKE '%Godfather%';

/*Explicação da solução: Liste as colunas em SELECT e faça referência à tabela na cláusula FROM. 
Use uma cláusula WHERE para filtrar os dados. 
Depois de escrever o nome da coluna, use o operador lógico LIKE para procurar "Godfather" no título do filme, escrito entre aspas simples.
Para localizar a palavra em qualquer lugar do título do filme, coloque o caractere coringa (%) antes e depois da palavra.*/

/*Exercício 5: Seleção de algumas colunas e filtragem de dados usando duas condições em WHERE
Exercício: Selecione as colunas filme_titulo, imdb_nota e ano_lancamento da tabela filmes. 
Mostre os filmes que foram lançados antes de 2001 e que tiveram uma classificação acima de 9.

Solução:*/

SELECT
 filme_titulo,
  imdb_nota,
  ano_lancamento
FROM filmes
WHERE ano_lancamento < 2001 AND imdb_nota > 9;

/*Explicação da solução: Liste as colunas em SELECT e faça referência à tabela em FROM.
Defina a primeira condição de que o ano de lançamento seja anterior a 2001 usando o operador "less than" (<).
Para adicionar outra condição, use o operador lógico AND.
Use a mesma lógica da primeira condição, desta vez usando o operador "maior que" com a coluna imdb_nota*/

/*Exercício 6: Filtragem de dados usando WHERE e classificando o resultado
Exercício: Selecione as colunas filme_titulo, imdb_nota e ano_lancamento da tabela movies. Mostre os filmes lançados depois de 1991.
 Classifique a saída pelo ano de lançamento em ordem crescente.
Solução:*/

SELECT
 filme_titulo,
  imdb_nota,
  ano_lancamento
FROM filmes
WHERE ano_lancamento > 1991
ORDER BY ano_lancamento ASC;

/*Explicação da solução: Liste as colunas em SELECT e faça referência à tabela em FROM.
Filtre os dados com WHERE aplicando o operador "maior que" à coluna ano_lancamento.
Para classificar os dados, use uma cláusula ORDER BY e escreva o nome da coluna pela qual você deseja classificar.
O tipo de classificação é especificado escrevendo ASC (ascendente) ou DESC (descendente).
Se o tipo for omitido, a saída será classificada em ordem crescente por padrão.*/

/*Exercício 7: Agrupamento de dados em uma coluna
Exercício: Mostre a contagem de filmes por cada categoria de idioma.
Solução:*/

SELECT
  language,
  COUNT(*) AS numero_filmes
FROM filmes
GROUP BY language;

/*Explicação da solução: Selecione a coluna language na tabela movies.
Para contar o número de filmes, use a função de agregação COUNT().
Use o asterisco (*) para contar as linhas, o que equivale à contagem de filmes.
Para dar um nome a essa coluna, use a palavra-chave AS seguida do nome desejado.
Para mostrar a contagem por idioma, você precisa agrupar os dados por ele, portanto, escreva a coluna language na cláusula GROUP BY.*/

/*Exercício 8: Agrupamento de dados por várias colunas
Exercício: Mostrar a contagem de filmes por ano de lançamento e idioma.
Classifique os resultados pela data de lançamento em ordem crescente.
Solução:*/

SELECT
  ano_lancamento,
  language,
  COUNT(*) AS numero_filmes
FROM filmes
GROUP BY ano_lancamento, language
ORDER BY ano_lancamento ASC;

/*Explicação da solução: Liste as colunas year_released e language da tabela movies em SELECT.
Use COUNT(*) para contar o número de filmes e dê um nome a essa coluna usando a palavra-chave AS.
Especifique as colunas pelas quais você deseja agrupar na cláusula GROUP BY.
Separe cada nome de coluna com uma vírgula. Classifique a saída usando ORDER BY com a coluna year_released e a palavra-chave ASC.*/

/*Exercício 9: Filtragem de dados após o agrupamento
Exercício: Mostre os idiomas falados e o orçamento médio dos filmes por categoria de idioma.
Mostre somente os idiomas com um orçamento médio acima de US$ 50 milhões.
Solução:*/

SELECT
  language,
  AVG(lucro) AS bilheteria
FROM filmes
GROUP BY language
HAVING AVG(lucro) > 50;

/*Explicação da solução: Selecione a coluna language na tabela movies.
Para calcular o orçamento médio, use a função de agregação AVG() com a coluna lucro entre parênteses.
Nomeie a coluna na saída usando a palavra-chave AS. Agrupe os dados por classificação usando GROUP BY.
Para filtrar os dados após o agrupamento, use uma cláusula HAVING.
Nela, use a mesma construção AVG() que em SELECT e defina os valores como sendo acima de 50 usando o operador "maior que".*/

/*Exercício 10: Seleção de colunas de duas tabelas
Exercício: Mostrar títulos de filmes da tabela moviescada um com o nome de sua empresa de distribuição.
Solução:*/

SELECT
  filme_titulo,
  nome_estudio
FROM estudio dc
JOIN movies m
ON dc.id = m.estudio_id;

/*Explicação da solução: Liste as colunas movie_title e company_name em SELECT.
Na cláusula FROM, faça referência à tabela estudio.
Dê a ela um alias dc para encurtar seu nome e usá-lo posteriormente.
A palavra-chave AS é omitida aqui; você pode usá-la se desejar.
Para acessar os dados da outra tabela, use JOIN (também pode ser escrita como INNER JOIN) e escreva o nome da tabela depois dela.
Dê também um alias a essa tabela.
A união usada aqui é um tipo de união interna; ela retorna somente as linhas que correspondem à condição de união especificada na cláusula ON. As tabelas são unidas quando a coluna id da tabela distribution_companies é igual à coluna distribution_company_id da tabela movies.
Para especificar qual coluna é de qual tabela, use o alias correspondente de cada tabela.*/