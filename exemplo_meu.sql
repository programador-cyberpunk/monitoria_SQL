use bancodemo2;

CREATE TABLE catalogo(
id INT PRIMARY KEY AUTO_INCREMENT,
artista VARCHAR(200),
genero VARCHAR(200),
titulo VARCHAR(200),
lancamento INT
 );
 
 CREATE TABLE disco(
 id INT PRIMARY KEY AUTO_INCREMENT,
 id_catalogo INT,
 codigo_compra VARCHAR(300),
  FOREIGN KEY (id_catalogo) REFERENCES Catalogo(id)
);

CREATE TABLE funcionario(
id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200),
cargo VARCHAR(200),
contato VARCHAR(200)
);

CREATE TABLE cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200),
email VARCHAR(200),
telefone VARCHAR(15)
);

INSERT INTO catalogo (artista, genero, titulo, lancamento) VALUES
('Nirvana', 'Rock', 'Nevermind', 1991),
('Queen', 'Rock', 'A Night at the Opera', 1975),
('Adele', 'Pop', '21', 2011),
('Taylor Swift', 'Pop', '1989', 2014),
('Eminem', 'Rap', 'The Marshall Mathers LP', 2000),
('Kendrick Lamar', 'Rap', 'To Pimp a Butterfly', 2015),
('The Beatles', 'Rock', 'Abbey Road', 1969),
('Beyoncé', 'Pop', 'Lemonade', 2016),
('Drake', 'Rap', 'Take Care', 2011),
('Linkin Park', 'Rock', 'Hybrid Theory', 2000);

INSERT INTO disco (id_catalogo, codigo_compra) VALUES
(1, 'C001'),
(2, 'C002'),
(3, 'C003'),
(4, 'C004'),
(5, 'C005'),
(6, 'C006'),
(7, 'C007'),
(8, 'C008'),
(9, 'C009'),
(10, 'C010');

INSERT INTO funcionario (nome, cargo, contato) VALUES
('Carlos Silva', 'Gerente', '1198765-4321'),
('Ana Paula', 'Vendedora', '1198765-1234'),
('Roberto Santos', 'Atendente', '1198765-5678');

INSERT INTO cliente (nome, email, telefone) VALUES
('Juliana Oliveira', 'juliana@gmail.com', '1198765-4321'),
('Fernando Costa', 'fernando@yahoo.com', '1198765-8765'),
('Mariana Lima', 'mariana@hotmail.com', '1198765-3456'),
('Lucas Pereira', 'lucas@gmail.com', '1198765-6543');