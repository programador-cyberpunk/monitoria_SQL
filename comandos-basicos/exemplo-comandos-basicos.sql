use bancodemo2;

SELECT nome, idade FROM cliente WHERE cidade = 'São Paulo';

INSERT INTO produtos (nome, preco) VALUES ('Laptop', 1200);

UPDATE funcionarios SET salario = salario *1.1 WHERE cargo= 'Gerente';

DELETE FROM pedidos WHERE estado = ‘Cancelado’;

ALTER TABLE produtos ADD COLUMN data_cadastro DATE;

SELECT DISTINCT categoria FROM produtos;
