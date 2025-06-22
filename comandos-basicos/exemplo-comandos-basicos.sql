
-- Comandos de consulta e manipulação de dados
USE exemplo2;

SELECT nome, idade FROM cliente WHERE cidade = 'São Paulo';

INSERT INTO produtos (codigo_compra, nome, preco, categoria) VALUES (1, 'Laptop', 1200, 'Eletrônicos');

UPDATE funcionarios SET salario = salario * 1.1 WHERE cargo = 'Gerente';

DELETE FROM pedidos WHERE estado = 'Cancelado';

SELECT DISTINCT categoria FROM produtos;

ALTER TABLE produtos ADD COLUMN data_cadastro DATE;

SELECT DISTINCT categoria FROM produtos;