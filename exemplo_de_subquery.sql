
CREATE DATABASE BancoDemo;
USE BancoDemo;


CREATE TABLE tabela1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    coluna1 VARCHAR(50) NOT NULL
);


CREATE TABLE tabela2 (
    id INT NOT NULL,
    coluna2 VARCHAR(50) NOT NULL,
    FOREIGN KEY (id) REFERENCES tabela1(id)
);


INSERT INTO tabela1 (coluna1) VALUES ('ValorA'), ('ValorB'), ('ValorC');


INSERT INTO tabela2 (id, coluna2) VALUES (1, 'ValorA'), (2, 'ValorD'), (3, 'ValorB');


/* essa eh a primeira tecnica, usar a subquery como uma nova coluna*/
SELECT
    *
FROM
    tabela1 AS T
WHERE
    coluna1 IN
    (
        SELECT
            coluna2
        FROM
            tabela2 AS T2
        WHERE
            T.id = T2.id
    );
    
    SELECT
    P.titulo,
    (SELECT
        COUNT(C.id_projeto)
      FROM
        comentarios C
      WHERE
        C.id_projeto = P.id ) AS Quantidade_Comentarios
FROM
    projetos P
GROUP BY
    P.id;
    
    SELECT
    P.titulo,
    (SELECT
        COUNT(C.id_projeto)
    FROM
        comentarios C
    WHERE
        C.id_projeto = P.id ) AS Quantidade_Comentarios,
        (SELECT
            COUNT(LP.id_projeto)
        FROM
            likes_por_projeto LP
        WHERE
            LP.id_projeto = P.id ) AS Quantidade_Likes
FROM
    projetos P
GROUP BY
    P.id;
    /* segunda, usar filtro de consulta, usando comandos de comparação e a palavra reservada IN e EXISTS*/

SELECT
    P.id,
    P.titulo,
    P.data
FROM
    projetos P
WHERE
    P.id IN
    (
        SELECT
            C.id_projeto
        FROM
            comentarios C
        WHERE
            P.id = C.id_projeto
    );
    /* ainda fazendo a consulta,mas agora vendo se ja existe o elemento na tabela*/
    SELECT
    P.id,
    P.titulo,
    P.data
FROM
    projetos P
WHERE
    EXISTS
    (
        SELECT
            C.id_projeto
        FROM
            comentarios C
        WHERE
            P.id = C.id_projeto
    );
    
    /* usando de um metodo logico agora*/
    SELECT
    P.titulo,
    P.data
FROM
    projetos P
WHERE
    P.id = (SELECT
      MAX(LP.id_projeto)
    FROM
      likes_por_projeto LP);
      
      /* terceiro modo, usando a tabela fonte de dados para a consulta principal*/
      
      SELECT
    P.id,
    P.titulo,
    (SELECT
        COUNT(C.id_projeto)
    FROM
        comentarios C
    WHERE
        C.id_projeto = P.id ) AS Quantidade_Comentarios
FROM
    projetos P;
  /* usando como base de dados a query acima, no caso para caçar a quantidade 
  comentarios maiores que 2*/  
    SELECT
    F.titulo,
    F.Quantidade_Comentarios
FROM
    (SELECT
        P.id,
        P.titulo,
        (SELECT
            COUNT(C.id_projeto)
        FROM
            comentarios C
        WHERE
            C.id_projeto = P.id ) AS Quantidade_Comentarios
FROM
    projetos P
) as F
WHERE
    F.Quantidade_Comentarios > 2;
