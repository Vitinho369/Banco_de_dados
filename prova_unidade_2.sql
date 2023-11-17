-- 1. CRIE o banco de dados

CREATE TABLE IF NOT EXISTS Fornecedores(
    idFORNECEDOR int,
    NOME varchar(255),
    RUA varchar(255),
    CIDADE varchar(255),
    ESTADO char(2),
    PRIMARY KEY(idFORNECEDOR)
);

CREATE TABLE IF NOT EXISTS Categorias(
    idCATEGORIA int,
    NOME varchar(255),
    PRIMARY KEY(idCATEGORIA)
);

CREATE TABLE IF NOT EXISTS Produtos(
    idPRODUTO int,
    NOME varchar(255),
    QUANTIDADE int,
    PRECO float,
    idFORNECEDOR int,
    idCATEGORIA int,
    FOREIGN KEY (idFORNECEDOR) REFERENCES Fornecedores(idFORNECEDOR),
    FOREIGN KEY (idCATEGORIA) REFERENCES Categorias(idCATEGORIA),
    PRIMARY KEY(idPRODUTO)
);
INSERT INTO Fornecedores (idFORNECEDOR, NOME, RUA, CIDADE, ESTADO) VALUES
(1, 'Ajax SA', 'Rua Presidente Castelo Branco', 'Porto Alegre', 'RS'),
(2, 'Sansul SA', 'Av Brasil', 'Rio de Janeiro', 'RJ'),
(3, 'South Chairs', 'Rua do Moinho', 'Santa Maria', 'RS'),
(4, 'Elon Electro', 'Rua Apolo', 'São Paulo', 'SP'),
(5, 'Mike electro', 'Rua Pedro da Cunha', 'Curitiba', 'PR'),
(6, 'Lojinha do carioca', 'Av são joão', 'Natal', 'RN'),
(7, 'verdinha', 'Av joão galo', 'Campina Grande', 'PB');


INSERT INTO Categorias (idCATEGORIA, NOME) VALUES
(1, 'Super Luxo\r\n'),
(2, 'Importado'),
(3, 'Tecnologia'),
(4, 'Vintage'),
(5, 'Supremo');

INSERT INTO Produtos (idPRODUTO, NOME, QUANTIDADE, PRECO, idFORNECEDOR, idCATEGORIA) VALUES
(1, 'Cadeira azul', 30, 330, 5, 5),
(2, 'Cadeira vermelha', 50, 2365, 2, 1),
(3, 'Guarda-roupa Disney', 400, 829.5, 4, 1),
(4, 'Torradeira Azul', 20, 298, 3, 1),
(5, 'TV', 30, 3300.27, 2, 2),
(6, 'LAPTOP DA XUXA', 20, 50, 4, 3),
(7, 'CAIXA JBL', 12, 120, 5, 3);


-- 2. INSERIR dados de 2 produtos de categoria 3 e qualquer fornecedor

INSERT INTO Produtos (idPRODUTO, NOME, QUANTIDADE, PRECO, idFORNECEDOR, idCATEGORIA) VALUES
(8, 'Arduino', 100, 30, 4, 3),
(9, 'Raspberry Pi', 1, 300, 4, 3);

-- 3. INSERIR dados de 2 fornecedores distintas, sendo do Estado do RN e outro do estado da PB;

INSERT INTO Fornecedores (idFORNECEDOR, NOME, RUA, CIDADE, ESTADO) VALUES
(8, 'Vitinho Ltda', 'Rua Adjair Gonçalo da Rocha', 'Parnamirim', 'RN'),
(9, 'Arduino e tal', 'Avenida Itália', 'Campina Grande', 'PB');

-- 4. INSERIR dados de mais 1 categoria de nome Nacional

INSERT INTO Categorias (idCATEGORIA, NOME) VALUES
(6, 'Nacional');
SELECT * FROM Produtos;

-- 5. ATUALIZE a tabela produtos, aumentando o preço do produto cujo idPRODUTO é 4, para R$ 298.0

UPDATE Produtos SET PRECO= 298 WHERE idPRODUTO=4;

-- 6. RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado no RJ;

SELECT p.idPRODUTO, p.NOME AS NOMEPRODUTO, p.QUANTIDADE, p.PRECO, f.NOME AS NOMEFORNECEDOR FROM 
    (Produtos p JOIN Fornecedores f 
     ON p.idFORNECEDOR = f.idFORNECEDOR) WHERE ESTADO='RJ';
     
-- 7. RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado no RS;

SELECT p.idPRODUTO, p.NOME AS NOMEPRODUTO, p.QUANTIDADE, p.PRECO, f.NOME AS NOMEFORNECEDOR FROM 
    (Produtos p JOIN Fornecedores f 
     ON p.idFORNECEDOR = f.idFORNECEDOR) WHERE ESTADO='RS';
     
-- 8. RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado em SP;

SELECT p.idPRODUTO, p.NOME AS NOMEPRODUTO, p.QUANTIDADE, p.PRECO, f.NOME AS NOMEFORNECEDOR FROM 
    (Produtos p JOIN Fornecedores f 
     ON p.idFORNECEDOR = f.idFORNECEDOR) WHERE ESTADO='SP';
     
-- 9. RECUPERE da tabela produtos e fornecedores o nome do produto mais caro e o nome do fornecedor
-- deste produto; 

SELECT p.NOME AS NOMEPRODUTO, f.NOME AS NOMEFORNECEDOR 
 FROM (Produtos p  JOIN Fornecedores f 
     ON p.idFORNECEDOR = f.idFORNECEDOR)
	 	WHERE p.PRECO = (SELECT MAX(p.PRECO) 
			FROM (Produtos p  JOIN Fornecedores f 
			 ON p.idFORNECEDOR = f.idFORNECEDOR));
    	
--  10. ATUALIZE a tabela fornecedores, alterando a cidade para Parnamirim, o estado para RN e a Rua para Abel
-- Cabral, do Fornecedor cujo nome é Elon Electro;

UPDATE Fornecedores SET RUA= 'Rua para Abel Cabral', CIDADE='Parnamirim', ESTADO='RN' WHERE NOME = 'Elon Electro' ;

-- 11. ATUALIZE a tabela produtos, alterando o preço dos produtos em 10% de aumento, cujo fornecedor seja
-- Sansul SA.

UPDATE Produtos
     SET PRECO =  PRECO+(PRECO *0.1)
     WHERE idFORNECEDOR = (SELECT f.idFORNECEDOR FROM Fornecedores f 
         WHERE f.NOME = 'Sansul SA');
		 
-- 12. ATUALIZE a tabela produtos, alterando o preço dos produtos em 10% de diminuição, cujo fornecedor seja
-- Mike electro e a categoria seja Supremo.

UPDATE Produtos
     SET PRECO =  PRECO - (PRECO *0.1) 
     WHERE idFORNECEDOR = (SELECT f.idFORNECEDOR FROM 
           ((Produtos p JOIN Categorias c
           ON p.idCATEGORIA = c.idCATEGORIA) JOIN Fornecedores f
           ON f.idFORNECEDOR = p.idFORNECEDOR)
         WHERE f.NOME = 'Mike electro' AND c.NOME = 'Supremo');
     
--  13. RECUPERE da tabela produtos, todos os produtos que tenham o preço entre 8 e 2.000, ordenados a
-- partir do maior preço.

SELECT * FROM Produtos WHERE PRECO BETWEEN 8 AND 2000; 

-- 14. RECUPERE da tabela produtos, todos os produtos que tenham o preço entre maior que 2.000, ordenados
-- a partir do menor preço.

SELECT * FROM Produtos WHERE PRECO > 2000 ORDER BY PRECO;

-- 15. RECUPERE da tabela fornecedor, o nome de todos os fornecedores que iniciam com a letra A.
SELECT * FROM Fornecedores WHERE NOME LIKE 'A%';
 
-- 16. RECUPERE da tabela fornecedor, o nome de todos os fornecedores que contenham a letra S.
SELECT * FROM Fornecedores WHERE NOME LIKE '%S%';

-- 17. ATUALIZE a tabela produtos, aumentando em 15% a quantidade de produtos que tenham o preço
-- inferior a 300.

UPDATE PRODUTOS SET QUANTIDADE = (QUANTIDADE *0.15)+QUANTIDADE WHERE PRECO < 300;

-- 18. APAGUE da tabela produtos todas os produtos da categoria 5;

DELETE FROM PRODUTOS WHERE idCATEGORIA=5;

-- 19. RECUPERE da tabela fornecedores, todos os registros cadastrados;

SELECT * FROM Fornecedores;

-- 20. RECUPERE da tabela produtos, o nome dos produtos que iniciam com a letra T e tenham o preço acima
-- de 400. 

SELECT NOME FROM Produtos WHERE NOME LIKE 'T%' AND PRECO > 400;

-- 21. APAGUE a tabela produtos;

DROP TABLE Produtos;