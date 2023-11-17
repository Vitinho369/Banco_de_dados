CREATE TABLE Curso(
	id SERIAL PRIMARY KEY,
	codigo INT NOT NULL,
	nome VARCHAR(40) NOT NULL,
	instituicao CHAR(20) NOT NULL,
	duracao INT DEFAULT 0
);

INSERT INTO Curso (codigo, nome, instituicao, duracao) VALUES
(100, 'Engenharia da computação', 'UFRN', 2),
(101, 'Engenharia da computação', 'USP', 1),
(102, 'TADS', 'UFRN', 6),
(103, 'BTI', 'UFRN', 9),
(102, 'Engenharia de Software', 'UFPE', 10);

CREATE TABLE Alunos(
	id SERIAL PRIMARY KEY,
	nome TEXT,
	sobrenome TEXT,
	data_nasc DATE,
	endereco TEXT
);

INSERT INTO Alunos (nome, sobrenome, data_nasc, endereco) VALUES
('Vitor', 'Silva', '04-07-2006', 'Rosa dos Ventos'),
('Taina', 'Silva', '04-07-2010', 'Rosa da Noite'),
('Jarlene', 'Silva', '04-07-2015', 'Rosa do Deserto'),
('Maria', 'Silva', '04-07-1980', 'Rosa'),
('José', 'Silva', '04-07-2000', 'Rosinha');

ALTER TABLE Alunos ADD curso INT REFERENCES Curso(id);

INSERT INTO Alunos (nome, sobrenome, data_nasc, endereco, curso) VALUES
('Joao', 'Pedro', '04-07-2001', 'Rua tal', 1),
('Joana', 'Maria', '01-07-2010', 'Bairro tal',3),
('Maria', 'Joana', '04-12-2015', 'Rua de natal',3),
('Josefina', 'Silva', '10-07-1980', 'Rua bonita',3),
('Luana', 'Maria', '01-02-2010', 'Rua grande',2);

SELECT nome FROM Curso;
SELECT DISTINCT(nome) FROM Curso;
SELECT * FROM Curso WHERE duracao > 6;
SELECT nome, sobrenome FROM Alunos;
SELECT nome,sobrenome FROM Alunos WHERE curso IS NULL;
SELECT a.nome, a.sobrenome FROM 
	(Alunos a JOIN Curso c
	ON a.curso = c.id)
	WHERE c.nome = 'TADS' AND c.instituicao = 'UFRN';