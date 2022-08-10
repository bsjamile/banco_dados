/* TRIGGER = GATILHO = DISPARA */
/* DAR ALERTA, FAZER BACK UP, FAZER AUDITORIA */

/* ESTRUTURA DE UMA TRIGGER */

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON TABELA
FOR EACH ROW (PARA CADA LINHA)
BEGIN -> INICIO

	QUALQUER COMENDO SQL

END -> FIM

CREATE DATABASE AULA40;

USE AULA40;

CREATE TABLE USUARIO(
	IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30),
	SENHA VARCHAR(100)
);

/* TABELA BACKUP */ 
/* TODA VEZ QUE APAGAR ALGUM REGISTRO DA TABELA DE USUARIO
   QUERO QUE ELE SEJA BACKUPEADO PARA QUALQUER PROBLEMA,
   SER POSSIVEL VOLTAR COM ESSE USUARIO PARA A TABELA */

/* HÁ A POSSIBILIDADE DE DISPARAR A TRIGGER EM 6 MOMENTOS
ANTES E DEPOIS - INSERT
ANTES E DEPOIS - UPDATE
ANTES E DEPOIS - DELETE 

MAS NAO É POSSIVEL COLOCAR DUAS TRIGERRS 
OLHANDO PRA MESMA TABELA DISPARANDO NO MESMO MOMENTO
EXEMPLO: NAO É POSSÍVEL COLOCAR 2 TRIGGERS PARA DISPARAR ANTES DO DELETE OLHANDO PRA TABELA USUARIO
*/

CREATE TABLE BKP_USUARIO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDUSUARIO INT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30)
);

DELIMITER $

CREATE TRIGGER BACKUP_USER
BEFORE DELETE ON USUARIO
FOR EACH ROW
BEGIN 

	INSERT INTO BKP_USUARIO VALUES
	(NULL,OLD.IDUSUARIO,OLD.NOME,OLD.LOGIN);

END
$

DELIMITER ;

INSERT INTO USUARIO VALUES(NULL,'ANDRADE','ANDRADE2009','HEXACAMPEAO');

SELECT * FROM USUARIO WHERE IDUSUARIO = 1;

DELETE FROM USUARIO WHERE IDUSUARIO = 1;

/* COMUNICACAO ENTRE BANCO DE DADOS */

/* BACKUP LOGICO = CRIAR OUTRO BANCO COM BACKUP
   BACKUP FISICO, CRIA UM ARQUIVO DE BACKUP */

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

STATUS

CREATE DATABASE BACKUP;

USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBKP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

USE LOJA;

INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,1000,'TESTE','0.0');
--NOME DO BANCO(BACKUP)

SELECT * FROM BACKUP.BKP_PRODUTO;


DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL,NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);

END
$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL,'LIVRO MODELAGEM','50.00');
INSERT INTO PRODUTO VALUES(NULL,'LIVRO BI','80.00');
INSERT INTO PRODUTO VALUES(NULL,'LIVRO ORACLE','70.00');
INSERT INTO PRODUTO VALUES(NULL,'LIVRO SQL SERVER','100.00');

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;

DELIMITER $

CREATE TRIGGER BKP_PRODUTO
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR);
END
$

DELIMITER ;

SELECT * FROM PRODUTO WHERE IDPRODUTO = 1;

DELETE FROM PRODUTO WHERE IDPRODUTO = 1;

SELECT * FROM PRODUTO;

DROP TRIGGER BACKUP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL,NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);

END
$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL,'BIG DATA','200.00');
INSERT INTO PRODUTO VALUES(NULL,'LIVRO C#','100.00');

SELECT * FROM PRODUTO;
SELECT * FROM BACKUP.BKP_PRODUTO;

ALTER TABLE BACKUP.BKP_PRODUTO
ADD EVENTO CHAR(1);

DROP TRIGGER BKP_PRODUTO_DEL;

DELIMITER $

CREATE TRIGGER BKP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR,'D');
END
$

DELIMITER ;

SELECT * FROM PRODUTO;

SELECT * FROM PRODUTO WHERE IDPRODUTO = 5;

DELETE FROM PRODUTO WHERE IDPRODUTO = 5;

SELECT * FROM BACKUP.BKP_PRODUTO;



DROP TRIGGER BACKUP_PRODUTO_INSERT;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_INSERT
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL,NEW.IDPRODUTO, NEW.NOME, NEW.VALOR,'I');

END
$

DELIMITER ;

SELECT * FROM PRODUTO;

INSERT INTO PRODUTO VALUES(NULL,'LIVRO PYTHON','150.00');

SELECT * FROM BACKUP.BKP_PRODUTO;

/* TRIGGER DE AUDITORIA */

DROP DATABASE LOJA;

DROP DATABASE  BACKUP;

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

CREATE DATABASE BACKUP;

USE BACKUP;

/*QUANDO*/
SELECT NOW();
/*QUANDO*/
SELECT CURRENT_USER();

CREATE TABLE BKP_PRODUTO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR_ORIGINAL FLOAT(10,2),
	VALOR_ALTERADO FLOAT(10,2),
	DATA DATETIME,
	USUARIO VARCHAR(30),
	EVENTO CHAR(1)
);

USE LOJA;

SELECT * FROM PRODUTO;

DELIMITER $

CREATE TRIGGER AUDIT_PROD
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR, 
	NEW.VALOR, NOW(), CURRENT_USER, 'U');
END
$

DELIMITER ;

SELECT * FROM PRODUTO;

UPDATE PRODUTO
SET VALOR = 107
WHERE IDPRODUTO = 4;

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;