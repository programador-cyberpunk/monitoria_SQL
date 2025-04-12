-- Criação do banco de dados e uso
CREATE DATABASE BancoDemo2;
USE BancoDemo2;

-- Criação da tabela1
CREATE TABLE tabela1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    coluna1 VARCHAR(50) NOT NULL
);

-- Criação da tabela2 com chave estrangeira
CREATE TABLE tabela2 (
    id INT NOT NULL,
    coluna2 VARCHAR(50) NOT NULL,
    FOREIGN KEY (id) REFERENCES tabela1(id)
);

-- Criação da tabela projetos
CREATE TABLE projetos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    data DATE NOT NULL
);

-- Criação da tabela comentarios
CREATE TABLE comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    texto VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_projeto) REFERENCES projetos(id)
);

-- Criação da tabela likes_por_projeto (opcional, se necessário)
CREATE TABLE likes_por_projeto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    FOREIGN KEY (id_projeto) REFERENCES projetos(id)
);

-- Inserção de dados na tabela1
INSERT INTO tabela1 (coluna1) VALUES ('ValorA'), ('ValorB'), ('ValorC');

-- Inserção de dados na tabela2
INSERT INTO tabela2 (id, coluna2) VALUES (1, 'ValorA'), (2, 'ValorD'), (3, 'ValorB');

-- Inserção de dados na tabela projetos
INSERT INTO projetos (titulo, data) VALUES ('Projeto 1', '2023-01-01'), ('Projeto 2', '2023-01-02'), ('Projeto 3', '2023-01-03');

-- Inserção de dados na tabela comentarios
INSERT INTO comentarios (id_projeto, texto) VALUES (1, 'Comentário 1 para Projeto 1'), (1, 'Comentário 2 para Projeto 1'), (2, 'Comentário 1 para Projeto 2');

-- Primeira técnica: subquery como nova coluna
SELECT
    T.id,
    T.coluna1,
    (SELECT COUNT(C.id_projeto)
     FROM comentarios C
     WHERE C.id_projeto = T.id) AS Quantidade_Comentarios
FROM
    tabela1 T;

-- Segunda técnica: filtro de consulta usando EXISTS
SELECT
    P.id,
    P.titulo,
    P.data
FROM
    projetos P
WHERE
    EXISTS (
        SELECT C.id_projeto
        FROM comentarios C
        WHERE P.id = C.id_projeto
    );

-- Terceira técnica: filtrando projetos com mais de 2 comentários
SELECT
    F.titulo,
    F.Quantidade_Comentarios
FROM (
    SELECT
        P.id,
        P.titulo,
        (SELECT COUNT(C.id_projeto)
         FROM comentarios C
         WHERE C.id_projeto = P.id) AS Quantidade_Comentarios
    FROM
        projetos P
) AS F
WHERE
    F.Quantidade_Comentarios > 2;
