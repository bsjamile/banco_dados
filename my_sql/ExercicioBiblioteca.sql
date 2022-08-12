CREATE DATABASE LIVRARIA;

USE LIVRARIA; /* PODE UTILIZAR O SHOW DATABASES; PARA VER A QUAIS DATABASES EXISTEM*/

CREATE TABLE LIVROS(
	LIVRO VARCHAR (100),
	AUTOR VARCHAR(100),
	SEXO CHAR(1),
	PAGINAS INT(5),
	EDITORA VARCHAR(30),
	VALOR FLOAT(10,2), 
	UF CHAR(2),
	ANO INT(4)
);

SHOW TABLES; /* MOSTRA AS TABELAS DO BANCO */

INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO) 
VALUES('Cavaleiro Real', 'Ana Claudia',	'F',465, 'Atlas',	49.9,'RJ',2009);
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO) 
VALUES('SQL para leigos','João Nunes','M',450,'Addison',98,'SP',2018);
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO) 
VALUES('Receitas Caseiras','Celia Tavares','F',210,'Atlas',45,'RJ',2008);	
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO)  
VALUES('Pessoas Efetivas','Eduardo Santos','M',390,'Beta',78.99,'RJ',2018);	
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO) 
VALUES('Habitos Saudáveis','Eduardo Santos','M',630,'Beta',150.98,'RJ',2019);	
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO) 
VALUES('A Casa Marrom','Hermes Macedo','M',250,'Bubba',60,'MG',2016);		
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO) 
VALUES('Estacio Querido','Geraldo Francisco','M',310,'Insignia',100,'ES',2015);
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO)  
VALUES('Pra sempre amigas','Leda Silva','F',510,'Insignia',78.98,'ES',2011);
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO)  
VALUES('Copas Inesqueciveis','Marco Alcantara','M',200,'Larson',130.98,'RS',2018);
	
INSERT INTO LIVROS(LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO)  
VALUES('O poder da mente','Clara Mafra','F',120,'Continental',56.58,'SP',2017);	
	
SELECT LIVRO, AUTOR, SEXO, PAGINAS, EDITORA, VALOR, UF, ANO FROM LIVROS;

SELECT LIVRO, EDITORA FROM LIVROS;

SELECT LIVRO, UF FROM LIVROS
WHERE SEXO = 'M';

SELECT LIVRO, PAGINAS FROM LIVROS
WHERE SEXO = 'F';

SELECT LIVRO, VALOR FROM LIVROS
WHERE UF = 'SP';

SELECT AUTOR FROM LIVROS 
WHERE SEXO = 'M' AND (UF = 'SP' OR UF = 'RJ');

/* OPERADORES LÓGICOS 
OR - PARA QUE A SAIDA DA QUERY SEJA VERDADEIRA, BASTA QUE APENAS UMA CONDICAO SEJA VERDADEIRA
END - PARA QUE A SAIDA DA QUERY SEJA VERDADE, TODAS AS CONDICOES PRECISAM SER VERDADEIRAS
*/

/* OR - OU */

SHOW DATABASES;

USE PROJETO;

SELECT * FROM CLIENTE;

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'M' OR ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'F' OR ENDERECO LIKE '%ESTACIO';

/* AND - E */

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'M' AND ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'F' AND ENDERECO LIKE '%ESTACIO';

/* COUNT(*), GROUP BY, PERFORMANCE COM OPERADORES LOGICOS */

/* CONTANDO OS RESGISTROS DE UMA TABELA */

SELECT COUNT(*) FROM CLIENTE;

SELECT SEXO, COUNT(*)
FROM CLIENTE; /*  SOMAM, SUMARIZAM, TRAZ O RESULTADO EM UMA LINHA SÓ  E DESCONSIDERA A CLASSIFICACAO POR SEXO*/

/* OPERADOR GROUP BY */

SELECT SEXO, COUNT(*)
FROM CLIENTE
GROUP BY SEXO; /* SOMA E CLASSIFICA DIREITINHO A QUANTIDADE DE CADA SEXO */

/* PERFORMANCE EM OPERADORES LOGICOS */

/* 1 MILHAO DE REGISTROS

SITUACAO - TRATANDO COM OU / OR
70% MULHERES = SEXO = F (MAIOR A PROBABILIDADE, MELHORA A PERFORMANCE)
30% MORA NO RJ*/

SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE SEXO = 'F' (VEM PRIMEIRO PQ A PROBABILIDADE É MAIOR)
OR ENDERECO = '%RIO DE JANEIRO%';

/*
--------

SITUACAO - TRATANDO COM E / AND
30% MORA NO RJ
70% MULHERES = SEXO = F*/

SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE ENDERECO LIKE '%RIO DE JANEIRO%' (MENOR A PROBABILIDADE, MELHORA A PERFORMANCE)
AND SEXO = 'F';


/* FILTRANDO VALORES NULOS */
/* IS NULL IS NOT NULL*/

SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE SEXO = 'F';

SELECT NOME, EMAIL
FROM CLIENTE
WHERE EMAIL IS NULL;

SELECT NOME, EMAIL
FROM CLIENTE
WHERE EMAIL IS NOT NULL;

/* UTILIZANDO O UPDATE PARA ATUALIZAR VALORES */
/* SEMPRE UTILIZAR UM SELECT ANTES DE UM UPDATE PARA VALIDAR AS INFORMACOES ATUALIZADAS */

SELECT NOME, EMAIL
FROM CLIENTE;

/* WHERE - VAI SER O SEU MELHOR AMIGO DA VIDA
PRA VIDA INTEIRA */

UPDATE CLIENTE
SET EMAIL = 'LILIAN@IG.COM.BR'
WHERE NOME = 'LILIAN';

SELECT NOME, EMAIL FROM CLIENTE
WHERE NOME = 'LILIAN';

UPDATE CLIENTE
SET EMAIL = 'JORGE@IG.COM.BR'
WHERE NOME = 'JORGE';

SELECT NOME, EMAIL FROM CLIENTE
WHERE NOME = 'JORGE';

UPDATE CLIENTE
SET EMAIL = 'CELIA@IG.COM.BR'
WHERE NOME = 'CELIA';

SELECT NOME, EMAIL FROM CLIENTE
WHERE NOME = 'CELIA';

UPDATE CLIENTE
SET EMAIL = 'ANA@IG.COM.BR'
WHERE NOME = 'ANA';

SELECT NOME, EMAIL FROM CLIENTE
WHERE NOME = 'ANA';

UPDATE CLIENTE
SET EMAIL = 'CARLA@IG.COM.BR'
WHERE NOME = 'CARLA';

SELECT NOME, EMAIL FROM CLIENTE
WHERE NOME = 'CARLA';

UPDATE CLIENTE
SET EMAIL = 'JOAO@IG.COM.BR'
WHERE NOME = 'JOAO';

SELECT NOME, EMAIL FROM CLIENTE
WHERE NOME = 'JOAO';

/* PODEMOS VOLTAR ATRAS DE UMA OPERACAO QUE FAZEMOS NO BANCO DE DADOS COM COMMIT E ROLLBACK */