CREATE DATABASE exemplo2;
USE exemplo2;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE cliente(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200),
    idade INT,
    email VARCHAR(200),
    telefone VARCHAR(15),
    cidade VARCHAR(200)
);

CREATE TABLE produtos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_compra INT,
    nome VARCHAR(200),
    preco INT,
    categoria VARCHAR(200)
);

CREATE TABLE pedidos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_rastreio VARCHAR(200),
    cpf INT(11),
    email VARCHAR(200),
    codigo_cliente INT,
    estado VARCHAR(200)
);

CREATE TABLE funcionarios(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200),
    cargo VARCHAR(200),
    contato VARCHAR(200),
    salario DECIMAL(10, 2)
); 

-- Inserindo dados na tabela funcionarios
INSERT INTO funcionarios (nome, cargo, contato, salario) VALUES
('Carlos Silva', 'Gerente', '1198765-4321', 5000.00),
('Ana Paula', 'Vendedora', '1198765-1234', 3000.00),
('Roberto Santos', 'Atendente', '1198765-5678', 2500.00);

