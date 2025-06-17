create database exemplo;
use exemplo;

SELECT nome, idade FROM clientes WHERE cidade = 'São Paulo';

INSERT INTO produtos (nome, preço) VALUES ('Laptop', 1200);

UPDATE funcionarios SET salario = salario *1.1 WHERE cargo=’Gerente’;

DELETE FROM pedidos WHERE status = ‘Cancelado’;

CREATE TABLE cliente(
 id INT PRIMARY KEY,
nome VARCHAR(50),
email VARCHAR(50),
idade INT
);

ALTER TABLE produtos ADD COLUMN data_cadastro DATE;

SELECT DISTINCT categoria FROM produtos;