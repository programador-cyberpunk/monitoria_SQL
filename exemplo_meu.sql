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
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200),
cargo VARCHAR(200),
contato VARCHAR(200)
);

CREATE TABLE cliente(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200),
email VARCHAR(200),
telefone VARCHAR(15)
);
