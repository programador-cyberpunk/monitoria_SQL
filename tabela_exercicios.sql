create database exercicios;
 use exercicios;
 
 -- Criação da tabela empresas
CREATE TABLE empresas (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

-- Inserção dos dados na tabela empresas
INSERT INTO empresas (id, nome) VALUES
(1, 'Columbia'),
(2, 'Paramount'),
(3, 'Warner Bros'),
(4, 'United Artists'),
(5, 'Universal'),
(6, 'New Line'),
(7, 'Miramax'),
(8, 'Produzioni Europee'),
(9, 'Buena Vista'),
(10, 'StudioCanal');

-- Criação da tabela filmes
CREATE TABLE filmes (
    id INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    nota DECIMAL(3, 1) NOT NULL,
    ano INT NOT NULL,
    orcamento DECIMAL(10, 2) NOT NULL,
    bilheteira DECIMAL(10, 2) NOT NULL,
    empresa_id INT,
    idioma VARCHAR(255),
    FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

-- Inserção dos dados na tabela filmes
INSERT INTO filmes (id, titulo, nota, ano, orcamento, bilheteira, empresa_id, idioma) VALUES
(1, 'Um Sonho de Liberdade', 9.2, 1994, 25.00, 73.30, 1, 'Inglês'),
(2, 'O Poderoso Chefão', 9.2, 1972, 7.20, 291.00, 2, 'Inglês'),
(3, 'O Cavaleiro das Trevas', 9.0, 2008, 185.00, 1006.00, 3, 'Inglês'),
(4, 'O Poderoso Chefão Parte II', 9.0, 1974, 13.00, 93.00, 2, 'Inglês, Siciliano'),
(5, '12 Homens e uma Sentença', 9.0, 1957, 0.34, 2.00, 4, 'Inglês'),
(6, 'A Lista de Schindler', 8.9, 1993, 22.00, 322.20, 5, 'Inglês, Alemão, Yiddish'),
(7, 'O Senhor dos Anéis: O Retorno do Rei', 8.9, 2003, 94.00, 1146.00, 6, 'Inglês'),
(8, 'Pulp Fiction', 8.8, 1994, 8.50, 213.90, 7, 'Inglês'),
(9, 'O Senhor dos Anéis: A Sociedade do Anel', 8.8, 2001, 93.00, 898.20, 6, 'Inglês'),
(10, 'Três Homens em Conflito', 8.8, 1966, 1.20, 38.90, NULL, NULL);