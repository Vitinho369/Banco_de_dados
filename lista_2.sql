-- 1. Crie uma tabela chamada Curso que tenha os seguintes atributos: codigo, nome,
-- instituicao, duracao, ativo.
-- a. A tabela deve ter uma chave primária chamada id.
-- b. Se não for especificada a duração, deve ser atribuído o valor 0 a ela.
-- c. Codigo, nome e instituicao são atributos obrigatórios.

CREATE TABLE Curso(
	id SERIAL,
	codigo TEXT NOT NULL,
	nome TEXT NOT NULL,
	instituicao TEXT NOT NULL,
	duracao SMALLINT DEFAULT 0, 
    ativo BOOLEAN NOT NULL,
	PRIMARY KEY(id)
);
-- 2. Inserir 5 cursos no banco de dados.
-- a. Inserir 2 cursos com o mesmo nome, mas de instituições diferentes.
-- b. Inserir um curso com o nome TADS e instituicao UFRN.
-- c. Inserir um curso com o nome Engenharia de Computação

INSERT INTO Curso (codigo, nome, instituicao, duracao, ativo) values 
('2020IF', 'TADS', 'IFRN', 4, TRUE),
('TADS2023', 'TADS', 'UFRN', 3, TRUE),
('ENGE2000', 'Engenharia de Computação', 'UFRN', 5, FALSE),
('AGRO16', 'AGRONOMIA', 'UFRN', 5, TRUE),
('ART20', 'ARTES', 'UFRN', 4, FALSE);

-- 3. Crie uma tabela chamada Aluno que tenha os seguintes atributos: nome,
-- sobrenome, data de nascimento, endereco.
-- a. A tabela deve ter uma chave primária chamada i

CREATE TABLE Aluno(
	id SERIAL PRIMARY KEY,
	nome TEXT,
	sobrenome TEXT, 
	data_nasciemnto DATE,
	endereco TEXT
);

ALTER TABLE Aluno RENAME data_nasciemnto TO data_nascimento;
-- 4. Inserir 10 alunos no banco de dados.
-- a. Criar alguns alunos com o nome similar, por exemplo: Carla, Carla F., Carla F.
-- Curvelo, carla
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

-- 5. Crie uma tabela chamada CursoAluno que tenha os seguintes atributos: id_aluno,
-- id_curso, ativo
-- a. Id_aluno, id_curso são chaves primárias e estrangeiras
-- b. 3 dos alunos devem estar cursando o curso TADS da instituição UFRN

CREATE TABLE IF NOT EXISTS CursoAluno(
    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,
    ativo BOOLEAN NOT NULL,
    PRIMARY KEY(id_aluno,id_curso),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id),
    FOREIGN KEY (id_curso) REFERENCES Curso(id)
);
-- 6. Inserir 10 elementos na tabela CursoAluno.
-- a. Alguns alunos devem estar cursando mais de um curso
-- b. Alguns alunos devem ter cursos inativos
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

-- 7. Altere a duração do curso TADS para 2475.
UPDATE Curso SET duracao=2475 WHERE nome='TADS';

-- 8. Deletar o curso com o nome Engenharia de Computação.
DELETE FROM Curso WHERE nome = 'ENGENHARIA';

-- 9. Buscar todos os alunos com nome Carla (considerando alterações do nome) - usar o
-- LIKE
-- 	a. Desconsiderar minúsculo e maiúsculo

SELECT * FROM Aluno WHERE UPPER(nome) LIKE '%JOEL%';
-- 10. Selecionar os nomes dos alunos que estão cursando mais de um curso ativo

SELECT a.id, a.nome FROM 
	((Aluno a JOIN CursoAluno cA
	ON a.id = cA.id_aluno) JOIN Curso c
	ON c.id = cA.id_curso)
	WHERE cA.ativo = TRUE
	GROUP BY a.id
	HAVING COUNT(*)>2; 
	
-- 	11. Selecionar o valor médio de duração dos cursos da instituição de ensino
SELECT AVG(c.duracao),c.instituicao FROM 
	Curso c
	GROUP BY c.instituicao;

-- 12. Selecionar os cursos com menor e maior duração

SELECT nome, duracao FROM Curso WHERE duracao IN
(SELECT MAX(c.duracao) FROM Curso c);

SELECT nome, duracao FROM Curso WHERE duracao IN
(SELECT MIN(c.duracao) FROM Curso c);

-- 13. Selecionar a quantidade total de cursos ativos na instituição
SELECT COUNT(*), instituicao FROM Curso WHERE ativo = true
GROUP BY instituicao;

-- 14. Selecionar a quantidade de alunos ativos inscritos por curso
SELECT COUNT(*),id_curso FROM CursoAluno WHERE 
ativo = TRUE GROUP BY id_curso;

-- 15. Selecionar os cursos que têm mais do que dois alunos inscritos
SELECT * FROM Curso 
