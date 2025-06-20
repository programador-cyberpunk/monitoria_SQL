CREATE DATABASE exemplo;
USE exemplo;

CREATE TABLE cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200),
idade INT (2),
email VARCHAR(200),
telefone VARCHAR(15),
cidade VARCHAR(200)
);

CREATE TABLE produtos(
id INT,
codigo_compra INT,
nome VARCHAR(200),
preco INT,
categoria VARCHAR(200)
);

CREATE TABLE pedidos(
 id INT,
 codigo_rastreio VARCHAR(200),
 cpf INT (11),
 email VARCHAR(200),
 codigo_cliente VARCHAR(200),
 estado VARCHAR(200)
);

ALTER TABLE pedidos ADD COLUMN estado VARCHAR(200);

INSERT INTO funcionarios (nome, cargo, contato) VALUES
('Carlos Silva', 'Gerente', '1198765-4321'),
('Ana Paula', 'Vendedora', '1198765-1234'),
('Roberto Santos', 'Atendente', '1198765-5678');

CREATE TABLE funcionarios(
id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200),
cargo VARCHAR(200),
contato VARCHAR(200)
); 
