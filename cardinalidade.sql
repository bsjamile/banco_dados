/* PRIMEIRA FORMA NORMAL */

 /* COLUNAS = CAMPOS, LINHAS = REGISTROS
 
 1 - TODO CAMPO VETORIZADO (ELEMENTOS DA MESMA FAMILIA) SE TORNARA OUTRA TABELA = NESSE EXEMPLO, O TELEFONE
 
 [AMARELO, AZUL, LARANJA, VERDE] -> CORES
 [KA, FIESTA, UNO, CIVIC] -> CARROS
 
 2 - TODO CAMPO MULTIVALORADO SE TORNARA OUTRA TABELA
 QUANDO O CAMPO FOR DIVISIVEL (ELEMENTOS DE FAMILIA DIFERENTE) = NESSE EXEMPLO, O ENDERECO
 
 3 - TODA TABELA NECESSITA DE PELO MENOS UM CAMPO QUE IDENTIFIQUE 
 TODO O REGISTRO COMO SENDO UNICO.
 ISSO É O QUE CHAMAMOS DE PRIMARY KEY
 
 */
 
 /* CARDINALIDADE */
 
 /* QUEM DEFINE A CARDINALIDADE É A REGRA DE NEGÓCIOS */

/* 

 PRIMEIRO ALGORISMO - OBRIGATORIEDADE
 0 - NAO OBRIGATÓRIO
 N - OBRIGATÓRIO
 
 SEGUNDO ALGORISMO - CARDINALIDADE
 1 - MAXIMO DE UM
 N - MAIS DE UM
 
 LÊ-SE DE ACORDO COM O SEGUNDO ALGORISMO 
 1,1 = 1 PRA 1
 1,N = 1 PRA MUITOS
 
 */
 
 CREATE DATABASE COMERCIO;
 
 USE COMERCIO;
 
 SHOW DATABASES;
 
 CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL, /*O ENUM SO EXISTE NO MYSQL*/
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE 
 );
 
 --UNIQUE = AQUI O UNIQUE DEFINE O RELACIONAMENTO 1 X 1
 
 CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
 );
 
 CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES', 'COM', 'CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
 );
 
 DROP TABLE CLIENTE;
 
 /* 
	ENDERECO - OBRIGATORIO
	CADASTRO DE SOMENTE UM.
	
	TELEFONE - NAO OBRIGATORIO
	CADASTRO DE MAIS DE UM (OPCIONAL)
 */
 
 /* FOREIGN KEY */
 
 /*
	CHAVE ESTRANGEIRA É A CHAVE PRIMARIA DE UMA TABELA
	QUE VAI ATÉ A OUTRA TABELA PARA FAZER REFERENCIA ENTRE
	REGISTROS
 */
 
/* TABELA MAIS FRACA OU MAIS FORTE DEPENDE DA REGRA DE NEGOCIO */
	
/* EM RELACIONAMENTO 1 X 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA */

/* EM RELACIONAMENTO 1 X N A CHAVE ESTRANGEIRA FICARA SEMPRE NA CARDINAALIDADE N */

/* CONSTRAINT = REGRA */

DESC CLIENTE;

/* NO CASO DO MYSQL PRECISA INDICAR COM NULL AINDA QUE O ID SEJA AUTOINCREMENTADO*/

INSERT INTO CLIENTE VALUES(NULL,'JOAO', 'M','JOAO@IG.COM','012.345.678-90');

DELETE FROM CLIENTE WHERE NOME = 'JOAO';

SELECT * FROM CLIENTE;

INSERT INTO CLIENTE VALUES(NULL,'CARLOS', 'M','CARLOS@IG.COM','455878781');
INSERT INTO CLIENTE VALUES(NULL,'ANA', 'F','ANA@IG.COM','65654564654');
INSERT INTO CLIENTE VALUES(NULL,'CLARA', 'F',NULL,'200651651');
INSERT INTO CLIENTE VALUES(NULL,'JORGE', 'M','JORGE@IG.COM','8489798494');
INSERT INTO CLIENTE VALUES(NULL,'CELIA', 'F','CELIA@IG.COM','54098798740');


+-----------+--------+------+---------------+----------------+
| IDCLIENTE | NOME   | SEXO | EMAIL         | CPF            |
+-----------+--------+------+---------------+----------------+
|         2 | JOAO   | M    | JOAO@IG.COM   | 012.345.678-90 |
|         3 | ANA    | F    | ANA@IG.COM    | 65654564654    |
|         4 | CLARA  | F    | NULL          | 200651651      |
|         5 | JORGE  | M    | JORGE@IG.COM  | 8489798494     |
|         6 | CELIA  | F    | CELIA@IG.COM  | 54098798740    |
|         7 | CARLOS | M    | CARLOS@IG.COM | 455878781      |
+-----------+--------+------+---------------+----------------+

/* O BANCO NAO CONTROLA A OBRIGATORIEDADE */

DESC ENDERECO;

INSERT INTO ENDERECO VALUES(NULL,'RUA ANTONIO SA', 'CENTRO', 'B. HORIZONTE','MG',4);
INSERT INTO ENDERECO VALUES(NULL,'RUA CAPITAO HERMES', 'CENTRO', 'RIO DE JANEIRO','RJ',2);
INSERT INTO ENDERECO VALUES(NULL,'RUA PRES VARGAS', 'JARDINS', 'SAO PAULO','SP',3);
INSERT INTO ENDERECO VALUES(NULL,'RUA ALFANDEGA', 'ESTACIO', 'RIO DE JANEIRO','RJ',7);
INSERT INTO ENDERECO VALUES(NULL,'RUA DO OUVIDOR', 'FLAMENGO', 'RIO DE JANEIRO','RJ',6);
INSERT INTO ENDERECO VALUES(NULL,'RUA URUGUAIANA', 'CENTRO', 'VITORIA','ES',5);


INSERT INTO ENDERECO VALUES(NULL,'RUA ALFANDEGA', 'CENTRO', 'SAO PAULO','SP',5);

SELECT * FROM ENDERECO;

/* EM RELACIONAMENO 1 X 1 A FK NAO SE REPETE (UNIQUE) */

DESC TELEFONE;

/* NOS OUTROS BANCOS DE DADOS NAO PRECISAMOS COLOCAR NULL NO CAMPO DE ID AUTONCREMENTAVEL*/

INSERT INTO TELEFONE VALUES(NULL,'CEL','789787987',5);

SELECT * FROM TELEFONE;

INSERT INTO TELEFONE VALUES(NULL,'CEL','789787987',5);
INSERT INTO TELEFONE VALUES(NULL,'RES','545451211',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','989898989',2);
INSERT INTO TELEFONE VALUES(NULL,'COM','554555455',2);
INSERT INTO TELEFONE VALUES(NULL,'RES','878787211',3);
INSERT INTO TELEFONE VALUES(NULL,'CEL','121212055',2);
INSERT INTO TELEFONE VALUES(NULL,'CEL','598989889',3);
INSERT INTO TELEFONE VALUES(NULL,'COM','212250540',2);
INSERT INTO TELEFONE VALUES(NULL,'RES','787875421',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','545878785',5);

/* SELECAO, PROJECAO E JUNCAO */

/* PROJECAO -> É TUDO QUE VOCE QUER VER NA TELA */

SELECT NOW() AS DATA_ATUAL;

SELECT 2 + 2 AS SOMA;

SELECT 2 + 2 AS SOMA, NOME AS NAME, NOW() AS DATA_E_HORA
FROM CLIENTE;

/* SELECAO -> É UM SUBCONJUNTO DO CONJUNTO TOTAL DE REGISTROS DE UMA TABELA
A CLAUSULA DE SELECAO É O WHERE
*/

SELECT NOME, SEXO, EMAIL /* PROJECAO */
FROM CLIENTE /* ORIGEM */
WHERE SEXO = 'F'; /* SELECAO */

SELECT NUMERO, TIPO /* PROJECAO */
FROM TELEFONE /* ORIGEM */
WHERE TIPO = 'CEL'; /* SELECAO */

/* NO ORACLE É OBRIGATÓRIO A TER ORIGEM. ENTAO O SELECT NOW(); NÃO FUNCIONA, POR EXEMPLO */

/* NO MYSQL É GARANTIDO TER A SELECAO */

/* NO ORACLE SEMPRE TERÁ A PROJECAO E A ORIGEM */

/* JUNCAO -> JOIN */

SELECT NOME, EMAIL, IDCLIENTE
FROM CLIENTE;

SELECT ID_CLIENTE, BAIRRO, CIDADE
FROM ENDERECO;

+--------+---------------+-----------+
| NOME   | EMAIL         | IDCLIENTE |
+--------+---------------+-----------+
| JOAO   | JOAO@IG.COM   |         2 |
| ANA    | ANA@IG.COM    |         3 |
| CLARA  | NULL          |         4 |
| JORGE  | JORGE@IG.COM  |         5 |
| CELIA  | CELIA@IG.COM  |         6 |
| CARLOS | CARLOS@IG.COM |         7 |
+--------+---------------+-----------+

+------------+----------+----------------+
| ID_CLIENTE | BAIRRO   | CIDADE         |
+------------+----------+----------------+
|          4 | CENTRO   | B. HORIZONTE   |
|          2 | CENTRO   | RIO DE JANEIRO |
|          3 | JARDINS  | SAO PAULO      |
|          7 | ESTACIO  | RIO DE JANEIRO |
|          6 | FLAMENGO | RIO DE JANEIRO |
|          5 | CENTRO   | VITORIA        |
+------------+----------+----------------+

/* NOME, SEXO, BAIRRO, CIDADE */

/* NAO USAR O WHERE PARA JOIN */

SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJECAO */
FROM CLIENTE, ENDERECO /* ORIGEM */
WHERE IDCLIENTE = ID_CLIENTE; /* JUNCAO */

+--------+------+----------+----------------+
| NOME   | SEXO | BAIRRO   | CIDADE         |
+--------+------+----------+----------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO |
| ANA    | F    | JARDINS  | SAO PAULO      |
| CLARA  | F    | CENTRO   | B. HORIZONTE   |
| JORGE  | M    | CENTRO   | VITORIA        |
| CELIA  | F    | FLAMENGO | RIO DE JANEIRO |
| CARLOS | M    | ESTACIO  | RIO DE JANEIRO |
+--------+------+----------+----------------+

/* WHERE = SELECAO */

/* NAO USAR O WHERE PARA JOIN */

SELECT NOME, SEXO, BAIRRO, CIDADE
FROM CLIENTE, ENDERECO 
WHERE IDCLIENTE = ID_CLIENTE
AND SEXO = 'F';

+-------+------+----------+----------------+
| NOME  | SEXO | BAIRRO   | CIDADE         |
+-------+------+----------+----------------+
| ANA   | F    | JARDINS  | SAO PAULO      |
| CLARA | F    | CENTRO   | B. HORIZONTE   |
| CELIA | F    | FLAMENGO | RIO DE JANEIRO |
+-------+------+----------+----------------+

/* WHERE IDCLIENTE = ID_CLIENTE
AND SEXO = 'F'; -> TABELA VERDADE */

SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJECAO */
FROM CLIENTE /* ORIGEM */
	INNER JOIN ENDERECO /* JUNCAO */
	ON IDCLIENTE = ID_CLIENTE
WHERE SEXO = 'F'; /* SELECAO */

/* NOME, SEXO, EMAIL, TIPO, NUMERO */

SELECT NOME, SEXO, EMAIL, TIPO, NUMERO /* SELECAO */
FROM CLIENTE /* ORIGEM */
INNER JOIN TELEFONE /* JUNCAO*/
ON IDCLIENTE = ID_CLIENTE;

/* NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO */

SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE, TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

/* VOCE PODE JUNTAR QUANTAS TABELAS PRECISAR. O USO DA CLAUSULA JOIN É IRRESTRITO, 
LOGICAMENTE DEPENDENDO DO PROCESSAMENTO */

+-------+------+---------+----------------+------+-----------+
| NOME  | SEXO | BAIRRO  | CIDADE         | TIPO | NUMERO    |
+-------+------+---------+----------------+------+-----------+
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | CEL  | 989898989 |
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | COM  | 554555455 |
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | CEL  | 121212055 |
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | COM  | 212250540 |
| ANA   | F    | JARDINS | SAO PAULO      | RES  | 878787211 |
| ANA   | F    | JARDINS | SAO PAULO      | CEL  | 598989889 |
| JORGE | M    | CENTRO  | VITORIA        | CEL  | 789787987 |
| JORGE | M    | CENTRO  | VITORIA        | CEL  | 789787987 |
| JORGE | M    | CENTRO  | VITORIA        | RES  | 545451211 |
| JORGE | M    | CENTRO  | VITORIA        | RES  | 787875421 |
| JORGE | M    | CENTRO  | VITORIA        | CEL  | 545878785 |
+-------+------+---------+----------------+------+-----------+

/* O USO DE APELIDOS OU NOMES DAS TABELAS PARA PONTEIRAMENTO AUMENTA A PERFORMANCE */

SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+-------+------+---------+----------------+------+-----------+
| NOME  | SEXO | BAIRRO  | CIDADE         | TIPO | NUMERO    |
+-------+------+---------+----------------+------+-----------+
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | CEL  | 989898989 |
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | COM  | 554555455 |
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | CEL  | 121212055 |
| JOAO  | M    | CENTRO  | RIO DE JANEIRO | COM  | 212250540 |
| ANA   | F    | JARDINS | SAO PAULO      | RES  | 878787211 |
| ANA   | F    | JARDINS | SAO PAULO      | CEL  | 598989889 |
| JORGE | M    | CENTRO  | VITORIA        | CEL  | 789787987 |
| JORGE | M    | CENTRO  | VITORIA        | CEL  | 789787987 |
| JORGE | M    | CENTRO  | VITORIA        | RES  | 545451211 |
| JORGE | M    | CENTRO  | VITORIA        | RES  | 787875421 |
| JORGE | M    | CENTRO  | VITORIA        | CEL  | 545878785 |
+-------+------+---------+----------------+------+-----------+

/* 
	SQL É UMA LINGUAGEM DE 4ª GERACAO = É MUITO PARECIDA COM A LINGUAGEM HUMANA

	DML - DATA MANIPULATION LANGUAGE = MANIPULACAO DOS DADOS = IUD
		INSERT
		UPDATE
		DELETE
*/
	
/* INSERT */

INSERT INTO CLIENTE VALUES(NULL, 'PAULA','M', NULL, '77437493');
INSERT INTO ENDERECO VALUES(NULL, 'RUA JOAQUIM SILVA', 'ALVORADA', 'NITEROI','RJ',8);

SELECT * FROM CLIENTE;

/* FILTROS */

SELECT * FROM CLIENTE
WHERE SEXO = 'M';

/* UPDATE */

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 8;

UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 8;

/* DELETE */

INSERT INTO CLIENTE VALUES(NULL, 'XXXX','M', NULL, 'XXXXXXXX');

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 9;

DELETE FROM CLIENTE
WHERE IDCLIENTE = 9;

/*
	DDL - DATA DEFINITION LANGUAGE = DEFINICAO DOS DADOS = TIPAGEM DOS DADOS = CAD
	TUDO FEITO EM RELACAO A UMA TABELA QUE DIZ RESPEITO AO TIPO, ELE É O PADRAO DE DDL
		CREATE
		ALTER
		DROP
*/

/* CREATE */
/* O AUTO_INCREMENT SÓ EXISTE NO MYSQL */

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10,2) NOT NULL
);

/* ALTER TABLE */

/* ALTERANDO O NOME DE UMA COLUNA - CHANGE */

/* CHANGE = MUDA O NOME E O TIPO */
ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | YES  |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* MODIFY */

/* CHANGE E MODIFY FAZEM A MESMA COISA*/

/* ALTERANDO O TIPO */

ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;

/* O MAIS SEGURO É UTILIZAR O CHANGE PARA ALTERAR O NOME DA COLUNA
E O MODIFY PARA ALTERAR TIPO */

/* ADICIONA COLUNAS */

/* SE ESQUECER DE CRIAR UMA TABELA, POR EXEMPLO, NAO É PARA ALERAR LOKAMENTE COM ALTER TABLE
E SIM DROPAR, DELETAR E CRIAR NOVAMENTE = MAIS PROFISSIONAL */

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

DESC PRODUTO;

/* O MYSQL É UM DOS UNICOS BANCOS QUE DEIXA VC ALTERAR A ORDEM DAS COLUNAS AO ADICIONAR UMA NOVA COLUNA*/

/*

	DCL - DATA CONTROL LANGUAGE = CONTROLE DE ACESSO DOS DADOS

	TCL - TRANSACTION CONTROL LANGUAGE = CONTROLE DE TRANSACAO = ATOMICIDADE DO BANCO
*/



