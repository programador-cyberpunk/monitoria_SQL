CREATE DATABASE exemplo3;
USE exemplo3;

CREATE TABLE alunos(
 id INT AUTO_INCREMENT PRIMARY KEY,
 id_aluno INT,
 nota DECIMAL(4,2),
 FOREIGN KEY (id_aluno) REFERENCES aluno(id)
);

INSERT INTO alunos (id, nome) VALUES
(1 ,'Jao'),
(2, 'Katia'),
(3, 'Natan');

INSERT INTO notas (id_aluno, nota) VALUES
(1 ,8.5),
(1, 7.0),
(2, 9.0),
(3 ,8.0),
(2, 5.0),
(3, 6.0);

-- o CTE ai
WITH media_notas AS(
 SELECT id_aluno, AVG(nota) AS media
 FROM notas GROUP BY id_alunos
)
SELECT a.nome, m.media FROM alunos as
JOIN media_notas m ON a.id= m.id_aluno
WHERE m.media >=7;