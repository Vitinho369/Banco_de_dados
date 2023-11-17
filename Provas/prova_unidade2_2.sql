-- Dupla: Vitor Carvalho Silva e João Vitor Gomes Vieira
-- 1. Criar as tabelas do banco de dados.

CREATE TABLE IF NOT EXISTS Fazenda(
	id_Fazenda SERIAL,
	nome_fazenda TEXT,
	area_total REAL,
	PRIMARY KEY(id_Fazenda)
);

CREATE TABLE IF NOT EXISTS Cultura(
	id_cultura SERIAL,
	nome_cultura TEXT,
	tipo TEXT,
	estacao TEXT,
	PRIMARY KEY(id_cultura)
);

CREATE TABLE IF NOT EXISTS FazendaCultura(
	id_FazendaCultura SERIAL,
	id_Fazenda INT,
	id_Cultura INT,
	PRIMARY KEY(id_FazendaCultura),
	FOREIGN KEY(id_Fazenda) REFERENCES Fazenda(id_Fazenda),
	FOREIGN KEY(id_Cultura) REFERENCES Cultura(id_cultura)
);

CREATE TABLE IF NOT EXISTS Colheita(
	id_Colheita SERIAL,
	data DATE,
	quantidade INT,
	id_Fazenda INT,
	id_cultura INT,
	PRIMARY KEY(id_Colheita),
	FOREIGN KEY(id_Fazenda) REFERENCES Fazenda(id_Fazenda),
	FOREIGN KEY(id_cultura) REFERENCES Cultura(id_cultura)
);

-- 2. Criar 6 registros na tabela Fazenda, sendo dois, respectivamente com o nome
-- ‘Fazenda Feliz’ e ‘Fazenda Triste’ .

INSERT INTO Fazenda (nome_fazenda, area_total) VALUES
('Fazenda Feliz', 100),
('Fazenda Triste', 50),
('Fazenda Raivosa', 200),
('Fazenda Linda', 5000),
('Fazenda Legal', 400),
('Fazenda Chata', 170);

-- 3. Criar 8 registros na tabela Cultura sendo 4 frutas (Banana, Laranja, Melancia,
-- Caju), 4 hortaliças (Alface, Espinafre, Couve, Chuchu), o tipo fruta deve ter
-- estação Verão e tipo hortaliça Inverno.

INSERT INTO Cultura (nome_cultura,tipo,estacao) VALUES
('Banana', 'frutas', 'Verão'),
('Laranja', 'frutas', 'Verão'),
('Melancia', 'frutas', 'Verão'),
('Caju', 'frutas', 'Verão'),
('Alface', 'hortaliças', 'Inverno'),
('Espinafre', 'hortaliças', 'Inverno'),
('Couve', 'hortaliças', 'Inverno'),
('Chuchu', 'hortaliças', 'Inverno');

-- 4. Criar 6 registros na tabela Colheita, sendo 2 Registros para Fazenda Triste e 2
-- Registro para a Fazenda Feliz.

INSERT INTO Colheita (data, quantidade,id_Fazenda,id_cultura) VALUES
('17-11-2023', 20, 1,1),
('10-11-2023', 50, 1,2),
('01-07-2022', 70, 2,3),
('02-08-2025', 70, 2,4),
('01-07-2022', 70, 3,5),
('02-08-2025', 70, 4,6);

INSERT INTO FazendaCultura(id_Fazenda, id_cultura) VALUES
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(4,6);

-- 5. Atualize as datas da colheita da Fazenda Feliz para respectivamente 18/11/2023
-- e 25/12/2023

UPDATE Colheita SET data = '18-11-2023'
WHERE (id_fazenda IN 
	(SELECT f.id_fazenda FROM Fazenda f
	 JOIN FazendaCultura fc 
	 ON f.id_fazenda = fc.id_fazenda JOIN
	 Cultura c ON fc.id_cultura = c.id_cultura
	WHERE f.nome_fazenda = 'Fazenda Feliz' AND c.nome_cultura = 'Banana')
AND id_cultura IN
	(SELECT c.id_cultura FROM Fazenda f
	 JOIN FazendaCultura fc 
	 ON f.id_fazenda = fc.id_fazenda JOIN
	 Cultura c ON fc.id_cultura = c.id_cultura
	WHERE f.nome_fazenda = 'Fazenda Feliz' AND c.nome_cultura = 'Banana')
	  );
	  
	 
UPDATE Colheita SET data = '25-12-2023'
WHERE (id_fazenda IN 
	(SELECT f.id_fazenda FROM Fazenda f
	 JOIN FazendaCultura fc 
	 ON f.id_fazenda = fc.id_fazenda JOIN
	 Cultura c ON fc.id_cultura = c.id_cultura
	WHERE f.nome_fazenda = 'Fazenda Feliz' AND c.nome_cultura = 'Laranja')
AND id_cultura IN
	(SELECT c.id_cultura FROM Fazenda f
	 JOIN FazendaCultura fc 
	 ON f.id_fazenda = fc.id_fazenda JOIN
	 Cultura c ON fc.id_cultura = c.id_cultura
	WHERE f.nome_fazenda = 'Fazenda Feliz' AND c.nome_cultura = 'Laranja')
	  );
-- 6. Listar o nome da fazenda, a data da colheita e a quantidade colhida para todas
-- as colheitas

SELECT f.nome_fazenda, c.data, c.quantidade FROM 
	(Fazenda f JOIN Colheita c
	ON f.id_fazenda = c.id_fazenda);
	
-- 	7. Obter o nome da cultura, a data da colheita e a quantidade colhida para todas
-- as colheitas.

SELECT c.nome_cultura, cO.data, cO.quantidade FROM
	(Colheita cO JOIN Cultura c 
	 ON cO.id_cultura = c.id_cultura);
	 
-- 	 8. Listar todas as colheitas agrupadas por fazenda, incluindo informações sobre a
-- data da colheita, quantidade colhida, nome da fazenda e nome da cultura.

SELECT cO.data, cO.quantidade, f.nome_fazenda, c.nome_cultura FROM
	Fazenda f, Colheita cO, Cultura c
	WHERE f.id_fazenda = cO.id_fazenda AND
	c.id_cultura = cO.id_cultura
	GROUP BY cO.data, cO.quantidade, f.nome_fazenda, c.nome_cultura;
	
-- 	9. Retornar todas as colheitas agrupadas por fazenda e tipo de cultura
SELECT cO.id_colheita, cO.data, cO.quantidade, cO.id_fazenda, cO.id_cultura,f.nome_fazenda, c.tipo FROM
	Fazenda f, Colheita cO, Cultura c
	WHERE f.id_fazenda = cO.id_fazenda AND
	c.id_cultura = cO.id_cultura
	GROUP BY f.nome_fazenda, c.tipo, cO.id_colheita, cO.data, cO.quantidade, cO.id_fazenda, cO.id_cultura;
	
-- 	10. Retornar todas as colheitas ordenadas pela data da colheita exibindo o nome
-- da cultura e da fazenda.

SELECT cO.data, c.nome_cultura, f.nome_fazenda FROM
	Fazenda f, Colheita cO, Cultura c
	WHERE f.id_fazenda = cO.id_fazenda AND
	c.id_cultura = cO.id_cultura
	GROUP BY cO.data, c.nome_cultura, f.nome_fazenda
	ORDER BY cO.data;
	
-- 	11. Retornar a colheita com a maior quantidade.
UPDATE Colheita SET quantidade = 700
WHERE id_fazenda IN 
	(SELECT f.id_fazenda FROM Fazenda f
	 JOIN FazendaCultura fc 
	 ON f.id_fazenda = fc.id_fazenda JOIN
	 Cultura c ON fc.id_cultura = c.id_cultura
	WHERE f.nome_fazenda = 'Fazenda Linda' AND c.nome_cultura = 'Espinafre');
	
SELECT cO.quantidade, f.nome_fazenda, c.nome_cultura FROM
	Fazenda f
	 JOIN FazendaCultura fc 
	 ON f.id_fazenda = fc.id_fazenda JOIN
	 Cultura c ON fc.id_cultura = c.id_cultura
	 JOIN Colheita Co ON Co.id_fazenda = f.id_fazenda AND
	 cO.id_cultura = c.id_cultura
	WHERE cO.quantidade IN 
	(SELECT MAX(quantidade) 
	 FROM Colheita);
	 
-- 	 12. Retornar a quantidade de colheitas por fazenda.
SELECT SUM(cO.quantidade) AS qtd_colheita, f.nome_fazenda AS fazenda FROM
	Colheita cO, Fazenda f
	WHERE cO.id_fazenda = f.id_fazenda
	GROUP BY f.id_fazenda, f.nome_fazenda;
	
-- 	13. Retorne às informações detalhadas sobre a "Fazenda Feliz", incluindo o nome
-- da fazenda, sua area, as culturas que estão sendo cultivadas e as
-- informações de colheita associadas a essas culturas.

SELECT f.nome_fazenda, f.area_total, c.nome_cultura, cO.data, cO.quantidade, c.tipo, c.estacao FROM
	(Fazenda f JOIN Colheita cO
	ON f.id_fazenda = cO.id_fazenda)
	JOIN Cultura c ON cO.id_cultura = c.id_cultura
	WHERE f.nome_fazenda = 'Fazenda Feliz';
	
-- 	14. Listar as colheitas realizadas durante a estação de ‘Verão’. Agrupe os
-- resultados por Estação, nome da fazenda e nome da cultura, exibindo a
-- quantidade total colhida para cada combinação. Ordene os resultados pelo
-- nome da fazenda e nome da cultura.

SELECT c.estacao, f.nome_fazenda, c.nome_cultura, cO.quantidade FROM
	Colheita cO, Cultura c, Fazenda f
	WHERE cO.id_cultura = c.id_cultura AND
	cO.id_fazenda = f.id_fazenda AND  c.estacao = 'Verão'
	GROUP BY c.estacao, f.nome_fazenda, c.nome_cultura, cO.quantidade
	ORDER BY f.nome_fazenda, c.nome_cultura;
	
-- 	15. Listar as fazendas que têm mais culturas e colheitas, ordenadas pela data
-- colheita e quantidade.
		
INSERT INTO Colheita (data, quantidade,id_Fazenda,id_cultura) VALUES
('17-11-2023', 80, 1,1),
('10-11-2023', 90, 1,2),
('01-07-2022', 100, 1,3);

INSERT INTO FazendaCultura(id_Fazenda, id_cultura) VALUES
(1,1),
(1,2),
(1,3);	
		

	SELECT f.nome_fazenda, cO.data, COUNT(cO.quantidade), COUNT(DISTINCT cO.id_cultura), COUNT (DISTINCT f.id_fazenda) FROM
	(Colheita cO JOIN Fazenda f
	ON cO.id_fazenda = f.id_fazenda JOIN
	Cultura c ON c.id_cultura = cO.id_cultura
	JOIN FazendaCultura fc ON f.id_fazenda = fc.id_fazenda)
	GROUP BY f.nome_fazenda, cO.data, cO.quantidade, f.id_fazenda, fc.id_fazenda
	ORDER BY cO.data, COUNT(cO.quantidade) DESC;