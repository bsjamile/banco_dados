/* CONECTANDO A UM BANCO */

USE EMPRESA
GO

/* CRIACAO DE TABELA*/

CREATE TABLE ALUNO(
	IDALUNO INT PRIMARY KEY IDENTITY,
	NOME VARCHAR(30) NOT NULL,
	SEXO CHAR(1) NOT NULL,
	NASCIMENTO DATE NOT NULL,
	EMAIL VARCHAR(30) UNIQUE
)
GO

/* CONSTAINTS */

ALTER TABLE ALUNO
ADD CONSTRAINT CK_SEXO CHECK (SEXO IN('M','F'))
GO

/* 1 X 1 */

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY IDENTITY(100,10),
	BAIRRO VARCHAR(30),
	UF CHAR(2) NOT NULL
	CHECK (UF IN('RJ','SP','MG')),
	ID_ALUNO INT UNIQUE
)
GO

/* CRIANDO A FK */

ALTER TABLE ENDERECO
ADD CONSTRAINT FK_ENDERECO_ALUNO
FOREIGN KEY(ID_ALUNO)
REFERENCES ALUNO(IDALUNO)
GO

/* COMANDO DE DESCRICAO */

/* DESC, SHOW CREATE TABLE NO SQL SERVER � FEITO 
COM PROCEDURES JA CRIADAS E ARMAZENADAS NO SISTEMA*/  

/* DESC NO MYSQL*/
SP_COLUMNS ALUNO
GO

SP_HELP ALUNO
GO

/* INSERINDO DADOS */

INSERT INTO ALUNO VALUES('ANDRE','M','1981/12/09','ANDRE@IG.COM')
INSERT INTO ALUNO VALUES('ANA','F','1978/03/09','ANA@IG.COM')
INSERT INTO ALUNO VALUES('RUI','M','1965/07/09','RUI@IG.COM')
INSERT INTO ALUNO VALUES('JOAO','M','2002/11/09','JOAO@IG.COM')
GO

SELECT * FROM ALUNO
GO

/* ENDERECO */

INSERT INTO ENDERECO VALUES('FLAMENGO', 'RJ', 1)
INSERT INTO ENDERECO VALUES('MORUMBI', 'SP', 2)
INSERT INTO ENDERECO VALUES('CENTRO', 'MG', 3)
INSERT INTO ENDERECO VALUES('CENTRO', 'SP', 4)
GO

/* CRIANDO A TABELA TELEFONES */

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY IDENTITY,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_ALUNO INT,
	CHECK (TIPO IN('RES','COM','CEL'))
)
GO

INSERT INTO TELEFONE VALUES('CEL','7899889',1)
INSERT INTO TELEFONE VALUES('RES','4325444',1)
INSERT INTO TELEFONE VALUES('COM','4354354',2)
INSERT INTO TELEFONE VALUES('CEL','2344556',2)
GO

SELECT * FROM ALUNO
GO

/* PEGAR DATA ATUAL */

SELECT GETDATE() AS 'DATA E HORA'
GO

/* CLAUSULA AMBIGUA */

SELECT A.NOME, T.TIPO, T.NUMERO, E.BAIRRO, E.UF
FROM ALUNO A
INNER JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO;
GO

SELECT A.NOME, T.TIPO, T.NUMERO, E.BAIRRO, E.UF
FROM ALUNO A
LEFT JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO;
GO

/* IFNULL */

SELECT A.NOME, 
	   ISNULL(T.TIPO, '---') AS 'TIPO', 
	   ISNULL(T.NUMERO, '---') AS 'TELEFONE', 
	   E.BAIRRO, 
	   E.UF
FROM ALUNO A
LEFT JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO;
GO

/* DATAS */

SELECT * FROM ALUNO
GO

SELECT NOME, NASCIMENTO
FROM ALUNO
GO

/* DATEDIFF - CALCULA A DIFEREN�A ENTRE 2 DATAS 
FUNCAO GETDATE() TRAZ DIA E HORA
*/

USE EMPRESA
GO
SELECT NOME, GETDATE() AS 'DIA_HORA' FROM ALUNO
GO

/* 1 PASSO */

SELECT NOME, DATEDIFF(DAY,NASCIMENTO, GETDATE()) AS 'DIF DATAS' FROM ALUNO
GO

/* 2 PASSO */

SELECT NOME, DATEDIFF(DAY,NASCIMENTO, GETDATE()) AS 'IDADE' FROM ALUNO
GO

/* 3 PASSO - RETORNO EM INTEIRO + OPERACAO MATEMATICA */

SELECT NOME, (DATEDIFF(DAY,NASCIMENTO, GETDATE())/365) AS 'IDADE' FROM ALUNO
GO


SELECT NOME, (DATEDIFF(MONTH,NASCIMENTO, GETDATE())/12) AS 'IDADE' FROM ALUNO
GO

SELECT NOME, DATEDIFF(YEAR,NASCIMENTO, GETDATE()) AS 'IDADE' FROM ALUNO
GO

/* DATENAME - TRAZ O NOME DA PARTE DA DATA EM QUESTAO - STRING*/

SELECT NOME, DATENAME(MONTH, NASCIMENTO)
FROM ALUNO
GO

SELECT NOME, DATENAME(YEAR, NASCIMENTO)
FROM ALUNO
GO

SELECT NOME, DATENAME(WEEKDAY, NASCIMENTO)
FROM ALUNO
GO

/* DATEPART - POREM O RETORNO � UM INTEIRO */

USE EMPRESA
GO

SELECT NOME, DATEPART(MONTH,NASCIMENTO), DATENAME(MONTH,NASCIMENTO)
FROM ALUNO
GO

/* DATEADD - RETORNA UMA DATA SOMANDO A OUTRA DATA */

SELECT NASCIMENTO, DATEADD(YEAR,30,NASCIMENTO) FROM ALUNO
GO

SELECT DATEADD(YEAR,10,GETDATE()) AS 'DATA + 10'
GO

SELECT 1 + '1' AS 'SOMA'
GO

/* O SQL FOR�A A CONVERSAO DE STRING PARA NUMERICO 
	MAS NAO O CONTRARIO 
*/

SELECT 'CURSO DE BANCO DE DADOS' + '1' AS 'SOMA DE STRING'
GO

/*
FUNCOES DE CONVERSAO DE DADOS
*/

SELECT CAST('1' AS INT) + CAST('1' AS INT) AS 'SOMA'
GO

/* CONVERSAO E CONCATENACAO */

SELECT NOME,
NASCIMENTO
FROM ALUNO;
GO

/* O SQL TENTA CONVERTER A / PARA INT*/
SELECT NOME,
CAST(DAY(NASCIMENTO) AS VARCHAR) + 
'/' + CAST(MONTH(NASCIMENTO) AS VARCHAR) + 
'/' + CAST(YEAR(NASCIMENTO) AS varchar)
AS 'NASCIMENTO'
FROM ALUNO
GO

/* CHARINDEX - RETORNA UM INTEIRO 
   CONTAGEM DEFAULT - INICIA EM 01
*/

SELECT NOME,CHARINDEX('A',NOME) AS INDICE
FROM ALUNO
GO






