CREATE TABLE Curso(
	id SERIAL,
	codigo TEXT NOT NULL,
	nome TEXT NOT NULL,
	instituicao TEXT NOT NULL,
	duracao SMALLINT, 
    ativo BOOLEAN NOT NULL
);

ALTER TABLE Curso ALTER COLUMN duracao SET DEFAULT 0;
ALTER TABLE Curso ADD PRIMARY KEY(id);

INSERT INTO Curso (codigo, nome, instituicao, duracao, ativo) values 
('2020IF', 'TADS', 'IFRN', 4, TRUE),
('TADS2023', 'TADS', 'UFRN', 3, TRUE),
('ENGE2000', 'ENGENHARIA', 'UFRN', 5, FALSE),
('AGRO16', 'AGRONOMIA', 'UFRN', 5, TRUE),
('ART20', 'ARTES', 'UFRN', 4, FALSE);

CREATE TABLE Aluno(
	id SERIAL PRIMARY KEY,
	nome TEXT,
	sobrenome TEXT, 
	data_nasciemnto DATE,
	endereco TEXT
);

ALTER TABLE Aluno RENAME data_nasciemnto TO data_nascimento;

INSERT INTO Aluno(nome, sobrenome, data_nascimento, endereco) values
('Joel','O.','2000-04-21','Rua x'),
('Joel','S.','2006-07-12','Ruua y'),
('Joel','O.S','2011-10-10','Rua w'),
('Joel','de Oliveira','2015-06-10','Rua j'),
('Joel','Santos','2001-01-01','Rua p'),
('Joel','de Oliveira Santos','1990-04-12','Rua k'),
('Joel','O. Santos','1615-02-21','Ruua l'),
('Joel','Oliveira. S','2050-08-01','Rua m'),
('Joel','de Oliveira S.','2005-04-06','Rua n'),
('Joel','de O. Santos','1997-12-07','Rua o');

ALTER TABLE Aluno ADD COLUMN curso INT;
ALTER TABLE Aluno ADD CONSTRAINT curso FOREIGN KEY (curso) REFERENCES Curso (id);

CREATE TABLE IF NOT EXISTS CursoAluno(
    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,
    ativo BOOLEAN NOT NULL,
    PRIMARY KEY(id_aluno,id_curso),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id),
    FOREIGN KEY (id_curso) REFERENCES Curso(id)
);

INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES
(1,2,TRUE),
(10,2,TRUE),
(4,2,TRUE),
(1,1,TRUE),
(3,4, FALSE),
(9,5,TRUE),
(1,3, FALSE),
(8,3, FALSE),
(8,2, TRUE),
(9,1, TRUE);
SELECT *FROM ALUNO;
SELECT * FROM Curso;
SELECT * FROM CursoAluno;

UPDATE Curso SET duracao=2475 WHERE nome='TADS';

UPDATE CursoAluno SET id_curso=4 WHERE id_curso=3;
DELETE FROM Curso WHERE nome = 'ENGENHARIA';

SELECT * FROM Aluno WHERE nome LIKE 'Joel';

SELECT nome FROM Aluno ; 