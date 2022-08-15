select * from funcionarios;
select * from departamentos;
select * from localizacao;

/* FUNCOES DE AGREGACAO */

/* QUERY SIMPLES */

SELECT * FROM FUNCIONARIOS;

/* CONTANDO O NUMERO DE OCORRENCIAS */

SELECT COUNT(*) FROM FUNCIONARIOS;
SELECT COUNT(*) FROM DEPARTAMENTOS;
SELECT COUNT(*) FROM LOCALIZACAO;

/* AGRUPANDO POR SEXO COM GROUP BY */

SELECT COUNT(*) FROM FUNCIONARIOS
GROUP BY SEXO;

/* COLOCANDO O NOME DA COLUNA */

SELECT SEXO, COUNT(*) AS "QTD_POR_SEXO" FROM FUNCIONARIOS
GROUP BY SEXO;

/* MOSTRANDO O NUMERO DE FUNCIONARIOS EM CADA DEPARTAMENTO */

SELECT DEPARTAMENTO, COUNT(*) AS "FUNC_POR_DEPART"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO; 

/* EXIBINDO O MAXIMO DE SALARIOS = 149929 */

SELECT MAX(SALARIO) AS "MAIOR_SALARIO" 
FROM FUNCIONARIOS;

/* EXIBINDO O MINIMO DE SALARIO = 40138 */

SELECT MIN(SALARIO) AS "MENOR_SALARIO" 
FROM FUNCIONARIOS;

/* EXIBINDO O MAXIMO E O MINIMO JUNTOS */

SELECT MIN(SALARIO) AS "MENOR_SALARIO", MAX(SALARIO) AS "MAIOR_SALARIO" 
FROM FUNCIONARIOS;

/* EXIBINDO O MAXIMO E O MINIMO DE CADA DEPARTAMENTO */

SELECT DEPARTAMENTO, MIN(SALARIO) AS "min_salario", MAX(SALARIO) AS "max_salario", 
	   (MAX(SALARIO) - MIN(SALARIO)) AS "dif_salario"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO;

/* EXIBINDO O MAXIMO E O MINIMO POR SEXO */

SELECT SEXO, MIN(SALARIO) AS "min_salario", MAX(SALARIO) AS "max_salario", 
	   (MAX(SALARIO) - MIN(SALARIO)) AS "dif_salario"
FROM FUNCIONARIOS
GROUP BY SEXO;

/* ESTATISTICAS */

/* MOSTRANDO UMA QUANTIDADE LIMITADA DE LINHAS */

SELECT * FROM FUNCIONARIOS
LIMIT 10;

/* QUAL O GASTO TOTAL DE SALARIO PAGO PELA EMPRESA */

SELECT SUM(SALARIO) AS "TOTAL_SAL"
FROM FUNCIONARIOS;

/* QUAL O MONTANTE TOTAL QUE CADA DEPARTAMENTO RECEBE DE SALARIO */

SELECT DEPARTAMENTO, SUM(SALARIO) AS "SUM_SALARIO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO;

/* POR DEPARTAMENTO, QUAL O TOTAL E A MÉDIA PAGA PARA OS FUNCIONARIOS? */

SELECT SUM(SALARIO), AVG(SALARIO)
FROM FUNCIONARIOS;

SELECT DEPARTAMENTO, SUM(SALARIO) AS "SUM_SALARIO", AVG(SALARIO) AS "AVG_SALARIO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO;

/* ORDENANDO */

SELECT DEPARTAMENTO, SUM(SALARIO) AS "SUM_SALARIO", AVG(SALARIO) AS "AVG_SALARIO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO
ORDER BY 3;

SELECT DEPARTAMENTO, SUM(SALARIO) AS "SUM_SALARIO", AVG(SALARIO) AS "AVG_SALARIO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO
ORDER BY 3 ASC;Q

SELECT DEPARTAMENTO, SUM(SALARIO) AS "SUM_SALARIO", AVG(SALARIO) AS "AVG_SALARIO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO
ORDER BY 2 DESC;

SELECT * FROM FUNCIONARIOS;

SELECT DEPARTAMENTO, COUNT(*) AS "QTD_FUNC", AVG(SALARIO) AS "AVG_SALARIO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO
ORDER BY 2;

/* Modelagem Banco de Dados x Data Science */

/* Banco de Dados -> 1,2 e 3 Formas normais
Evitam redundancia, consequentemente poupam espaço em disco.
Consomem muito processamento em função de Joins. Queries lentas
*/

/*
Data Sciente e B.I -> Focam em agregações e performance. Não
se preocupam com espço em disco. Em B.I., modelgem minima (DW)
em Data Sciente, preferencialmente modelagem Colunar
*/

/*
O SERVIDOR DE MAQUINAS GEROU UM ARQUIVO DE LOG CSV.
VAMOS IMPORTA-LO E ANALISA-LO DENTRO DO NOSSO BANCO
*/

/* IMPORTANDO O CSV */

CREATE TABLE MAQUINAS(
	MAQUINA VARCHAR(20),
	DIA INT,
	QTD NUMERIC(10,2)
);

COPY MAQUINAS
FROM 'C:\LogMaquinas.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM MAQUINAS;

/* QUAL A MEDIA DE CADA MAQUINA */

SELECT MAQUINA, AVG(QTD) AS "MEDIA_QTD"
FROM MAQUINAS
GROUP BY MAQUINA;

/* ARREDONDANDO */
--ROUND(COLUNA,2)

SELECT MAQUINA, SUM(QTD) AS "QTD TOTAL", ROUND(AVG(QTD),2) AS "MEDIA_QTD"
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 3 DESC;

/* QUAL A MODA DAS QUANTIDADES */

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM maquinas
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC;

/* QUAL A MODA DAS QUANTIDADES DE CADA MAQUINA */

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

/* MODA DO DATASET INTEIRO */

SELECT QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
GROUP BY QTD
ORDER BY 2 DESC;

/* QUAL O MAXIMO E MINIMO E AMPLITUDE DE CADA MAQUINA */

SELECT MAQUINA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   (MAX(QTD) - MIN(QTD)) AS AMPLITUDE
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;

/* ACRESCENTANDO A MEDIA AO RELATORIO */

SELECT MAQUINA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   (MAX(QTD) - MIN(QTD)) AS "amplitude",
	   ROUND(AVG(QTD),2) AS "media"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 3 DESC;
	   
/* DESVIOI PADRAO E VARIANCIA */

--STDDEV_POP(COLUNA)
--VAR_POP(COLUNA)

SELECT MAQUINA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   (MAX(QTD) - MIN(QTD)) AS "amplitude",
	   ROUND(AVG(QTD),2) AS "media",
	   ROUND(STDDEV_POP(QTD),2) AS "desvio_pad",
	   ROUND(VAR_POP(QTD),2) AS "variancia"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 3 DESC;
	   
/* MEDIANA - NAO EXISTE UMA FUNCAO PRONT */

CREATE OR REPLACE FUNCTION _final_median(NUMERIC[])
   RETURNS NUMERIC AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;
										 
CREATE AGGREGATE median(NUMERIC) (
  SFUNC=array_append,
  STYPE=NUMERIC[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);

SELECT MEDIAN(QTD) AS mediana
FROM MAQUINAS;

SELECT ROUND(MEDIAN(QTD),2) AS mediana
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01';

SELECT ROUND(MEDIAN(QTD),2) AS mediana
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02';

SELECT ROUND(MEDIAN(QTD),2) AS mediana
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03';

INSERT INTO MAQUINAS VALUES('Maquina 01',11,15.9);
INSERT INTO MAQUINAS VALUES('Maquina 02',11,15.4);
INSERT INTO MAQUINAS VALUES('Maquina 03',11,15.7);
INSERT INTO MAQUINAS VALUES('Maquina 01',12,30);
INSERT INTO MAQUINAS VALUES('Maquina 02',12,24);
INSERT INTO MAQUINAS VALUES('Maquina 03',12,45);

SELECT * FROM MAQUINAS;
										 
delete from maquinas where dia = 11 or dia = 12;

/*
	QUANTIDADE
	TOTAL
	MEDIA
	MAXIMO
	MINIMO
	AMPLITUDE
	VARIANCIA
	DESVIO PADRAO
	MEDIANA
	COEFICIENTE DE VARIACAO
*/

SELECT MAQUINA,
	   COUNT(QTD) AS "quantidade",
	   SUM(QTD) AS "total",
	   ROUND(AVG(QTD),2) AS "media",
	   ROUND(MAX(QTD),2) AS "maximo",
	   ROUND(MIN(QTD),2) AS "minimo",
	   ROUND((MAX(QTD) - MIN(QTD)),2) AS "amplitude",
	   ROUND(VAR_POP(QTD),2) AS "variancia",
	   ROUND(STDDEV_POP(QTD),2) AS "desv padrao",
	   ROUND(MEDIAN(QTD),2) AS "mediana",
	   MODE() WITHIN GROUP(ORDER BY QTD) AS "moda",
	   ROUND(((STDDEV_POP(QTD) / AVG(QTD)) * 100 ),2) AS "coef var"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 1;

/* MODA - MODE() WITHIN GROUP(ORDER BY COLUNA)*/	   
/* SELECT MODE() WITHIN GROUP(ORDER BYY COLUNA) AS "MODA" FROM MAQUINAS; */

SELECT MAQUINA, MODE() WITHIN GROUP(ORDER BY QTD) AS "moda" 
FROM MAQUINAS 
GROUP BY 1;

SELECT MAQUINA,
	   COUNT(QTD) AS "quantidade",
	   SUM(QTD) AS "total",
	   ROUND(AVG(QTD),2) AS "media",
	   ROUND(MAX(QTD),2) AS "maximo",
	   ROUND(MIN(QTD),2) AS "minimo",
	   ROUND((MAX(QTD) - MIN(QTD)),2) AS "amplitude",
	   ROUND(VAR_POP(QTD),2) AS "variancia",
	   ROUND(STDDEV_POP(QTD),2) AS "desv padrao",
	   ROUND(MEDIAN(QTD),2) AS "mediana",
	   MODE() WITHIN GROUP(ORDER BY QTD) AS "moda",
	   ROUND(((STDDEV_POP(QTD) / AVG(QTD)) * 100 ),2) AS "coef var"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 1;

/* create table as select */

/*Podemos criar uma tabela com o resultado de uma querie
e essa é a forma de realizar uma modelagem colunar 
CREATE TABLE AS SELECT
*/


CREATE TABLE GENERO(
	IDGENERO INT PRIMARY KEY,
	NOME VARCHAR(30)
);

INSERT INTO GENERO VALUES(1,'FANTASIA');
INSERT INTO GENERO VALUES(2,'AVENTURA');
INSERT INTO GENERO VALUES(3,'SUSPENSE');
INSERT INTO GENERO VALUES(4,'AÇÃO');
INSERT INTO GENERO VALUES(5,'DRAMA');

CREATE TABLE FILME(
	IDFILME INT PRIMARY KEY,
	NOME VARCHAR(50),
	ANO INT,
    ID_GENERO INT,
	FOREIGN KEY(ID_GENERO)
	REFERENCES GENERO(IDGENERO)
);

INSERT INTO FILME VALUES(100,'KILL BILL I',2007,2);
INSERT INTO FILME VALUES(200,'DRACULA',1998,3);
INSERT INTO FILME VALUES(300,'SENHOR DOS ANEIS',2008,1);
INSERT INTO FILME VALUES(400,'UM SONHO DE LIBERDADE',2008,5);
INSERT INTO FILME VALUES(500,'OS BAD BOYS',2008,4);
INSERT INTO FILME VALUES(600,'GUERRA CIVIL',2016,2);
INSERT INTO FILME VALUES(700,'CADILLAC RECORDS',2009,5);
INSERT INTO FILME VALUES(800,'O HOBBIT',2008,1);
INSERT INTO FILME VALUES(900,'TOMATES VERDES FRITOS',2008,5);
INSERT INTO FILME VALUES(1000,'CORRIDA MORTAL',2008,4);

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA DATE,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

select * from locacao

INSERT INTO LOCACAO VALUES(1,'01/08/2019',23,3,100);
INSERT INTO LOCACAO VALUES(2,'01/02/2019',56,1,400);
INSERT INTO LOCACAO VALUES(3,'02/07/2019',23,3,400);
INSERT INTO LOCACAO VALUES(4,'02/02/2019',43,1,500);
INSERT INTO LOCACAO VALUES(5,'02/02/2019',23,2,100);
INSERT INTO LOCACAO VALUES(6,'03/07/2019',76,3,700);
INSERT INTO LOCACAO VALUES(7,'03/02/2019',45,1,700);
INSERT INTO LOCACAO VALUES(8,'04/08/2019',89,3,100);
INSERT INTO LOCACAO VALUES(9,'04/02/2019',23,3,800);
INSERT INTO LOCACAO VALUES(10,'05/07/2019',23,3,500);
INSERT INTO LOCACAO VALUES(11,'05/02/2019',38,3,800);
INSERT INTO LOCACAO VALUES(12,'01/10/2019',56,1,100);
INSERT INTO LOCACAO VALUES(13,'06/12/2019',23,3,400);
INSERT INTO LOCACAO VALUES(14,'01/02/2019',56,2,300);
INSERT INTO LOCACAO VALUES(15,'04/10/2019',76,3,300);
INSERT INTO LOCACAO VALUES(16,'01/09/2019',32,2,400);
INSERT INTO LOCACAO VALUES(17,'08/02/2019',89,3,100);
INSERT INTO LOCACAO VALUES(18,'01/02/2019',23,1,200);
INSERT INTO LOCACAO VALUES(19,'08/09/2019',45,3,300);
INSERT INTO LOCACAO VALUES(20,'01/12/2019',89,1,400);
INSERT INTO LOCACAO VALUES(21,'09/07/2019',23,3,1000);
INSERT INTO LOCACAO VALUES(22,'01/12/2019',21,3,1000);
INSERT INTO LOCACAO VALUES(23,'01/02/2019',34,2,100);
INSERT INTO LOCACAO VALUES(24,'09/08/2019',67,1,1000);
INSERT INTO LOCACAO VALUES(25,'01/02/2019',76,3,1000);
INSERT INTO LOCACAO VALUES(26,'01/02/2019',66,3,200);
INSERT INTO LOCACAO VALUES(27,'09/12/2019',90,1,400);
INSERT INTO LOCACAO VALUES(28,'03/02/2019',23,3,100);
INSERT INTO LOCACAO VALUES(29,'01/12/2019',65,5,1000);
INSERT INTO LOCACAO VALUES(30,'03/08/2019',43,1,1000);
INSERT INTO LOCACAO VALUES(31,'01/02/2019',27,31,200);

SELECT * FROM GENERO;
SELECT * FROM FILME;
SELECT * FROM LOCACAO;

SELECT F.NOME, G.NOME, L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM FUNCIONARIOS;

CREATE TABLE REL_LOCADORA AS 
SELECT F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM REL_LOCADORA;

COPY REL_LOCADORA TO
'G:\REL_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

/* SINCRONIZANDO TABELAS E RELATORIOS */

DROP TABLE LOCACAO;

/* SINCRONIZANDO TABELAS E RELATORIOS */

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA DATE,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

CREATE SEQUENCE SEQ_LOCACAO;

NEXTVAL('SQ_LOCACAO');

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/08/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/07/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',43,1,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',23,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/07/2018',76,3,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',45,1,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/08/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/02/2018',23,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/07/2018',23,3,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/02/2018',38,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/10/2018',56,1,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'06/12/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,2,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/10/2018',76,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/09/2018',32,2,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/02/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',23,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/09/2018',45,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',89,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/07/2018',23,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',21,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',34,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/08/2018',67,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',76,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',66,3,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/12/2018',90,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',65,5,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/08/2018',43,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',27,31,200);

SELECT * FROM LOCACAO;	
SELECT * FROM GENERO;
SELECT * FROM FILME;
SELECT * FROM REL_LOCADORA;

DROP TABLE REL_LOCADORA;
DROP TABLE RELATORIO_LOCADORA;

SELECT L.IDLOCACAO, 
       F.NOME AS FILME, 
	   G.NOME AS GENERO, 
	   L.DATA AS DATA, 
	   L.DIAS AS DIAS, 
	   L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

CREATE TABLE RELATORIO_LOCADORA AS 
	   SELECT L.IDLOCACAO, 
       F.NOME AS FILME, 
	   G.NOME AS GENERO, 
	   L.DATA AS DATA, 
	   L.DIAS AS DIAS, 
	   L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

DROP TABLE RELAROIO_LOCADORA;

DROP TABLE LOCACAO;

SELECT * FROM RELATORIO_LOCADORA;
SELECT * FROM LOCACAO;

/* SELECT PARA TRAZER OS REGISTROS NOVOS */

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

SELECT L.IDLOCACAO, 
   F.NOME AS FILME, 
   G.NOME AS GENERO, 
   L.DATA AS DATA, 
   L.DIAS AS DIAS, 
   L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

/* INSERINDO OS REGISTROS NOVOS */

INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, 
   F.NOME AS FILME, 
   G.NOME AS GENERO, 
   L.DATA AS DATA, 
   L.DIAS AS DIAS, 
   L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

/* VAMOS DEIXAR ESSE PROCEDIMENTO AUTOMATICO POR MEIO
DE UMA TRIGGER */

CREATE OR REPLACE FUNCTION ATUALIZA_REL()
RETURNS TRIGGER AS $$
BEGIN

INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

/* VAMOS DEIXAR ESSE PROCEDIMENTO AUTOMATICO POR MEIO
DE UMA TRIGGER */

CREATE OR REPLACE FUNCTION ATUALIZA_REL()
RETURNS TRIGGER AS $$
BEGIN

INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

COPY RELATORIO_LOCADORA TO
'C:\RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


/* COMANDO PARA APAGAR UMA TRIGGER */

DROP TRIGGER TG_RELATORIO ON LOCACAO;

CREATE TRIGGER TG_RELATORIO
AFTER INSERT ON LOCACAO
FOR EACH ROW
	EXECUTE PROCEDURE ATUALIZA_REL();
				
/* INSERINDO NOVOS REGISTROS */

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),100,7,300);

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),500,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),800,6,500);

SELECT * FROM LOCACAO;
SELECT * FROM RELATORIO_LOCADORA;

SELECT COUNT(IDLOCACAO) AS RELATORIO, (SELECT COUNT(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

/* SINCRONIZANDO COM REGISTROS DELETADOS */

CREATE OR REPLACE FUNCTION DELETE_LOCACAO()
RETURNS TRIGGER AS $$
BEGIN
DELETE FROM RELATORIO_LOCADORA
WHERE IDLOCACAO = OLD.IDLOCACAO;

COPY RELATORIO_LOCADORA TO
'C:\RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

RETURN OLD;
END; 
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER DELETE_REG
	BEFORE DELETE ON LOCACAO
	FOR EACH ROW
	EXECUTE PROCEDURE DELETE_LOCACAO();

SELECT * FROM LOCACAO;
SELECT * FROM RELATORIO_LOCADORA;

DELETE FROM LOCACAO
WHERE IDLOCACAO = 41;

SELECT COUNT(IDLOCACAO) AS RELATORIO, (SELECT COUNT(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

/* VARIAVEIS DUMMY PARA MACHINE LEARNING */

/* UTILIZANDO O CASE */

SELECT NOME, SEXO FROM FUNCIONARIOS;

SELECT NOME, CARGO,
CASE
		WHEN CARGO = 'Financial Advisor' THEN 'Condicao 01'
		WHEN CARGO = 'Structural Engineer' THEN 'Condicao 02'
		WHEN CARGO = 'Executive Secretary' THEN 'Condicao 03'
		WHEN CARGO = 'Sales Associative' THEN 'Condicao 04'
		ELSE 'OUTRAS CONDICOES'
END AS "CONDICOES"
FROM FUNCIONARIOS;

SELECT CARGO FROM FUNCIONARIOS;

SELECT NOME,
CASE

	WHEN SEXO = 'Masculino' THEN 'M'
	ELSE 'F'

END AS "SEXO"
FROM FUNCIONARIOS;

/* UTILIZANDO VALORES BOOLEANOS */

SELECT NOME, CARGO, (SEXO = 'Masculino') AS Masculino, (SEXO = 'Feminino') AS Feminino
FROM FUNCIONARIOS;

/* MESCLANDO AS TECNICAS - VARIABLE DUMMY PYTHON */

SELECT NOME, CARGO,
CASE
		WHEN (SEXO = 'Masculino') = true THEN 1
		ELSE 0
END AS "MASCULINO",
CASE
		WHEN (SEXO = 'Feminino') = true THEN 1
		ELSE 0
END AS "FEMININO"
FROM FUNCIONARIOS;

/* FILTROS DE GRUPO */

/* FILTROS BASEADOS EM VALORES NUMERICOS */

SELECT NOME, DEPARTAMENTO
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

/* FILTROS BASEADOS EM STRINGS */
SELECT NOME, DEPARTAMENTO, SALARIO --CASE INSENSITIVE
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'; --CASE SENSITIVE

/* FILTROS BASEADOS EM MULTIPLOS TIPOS E COLUNAS - CONSIDERAR OR E AND */

SELECT NOME, DEPARTAMENTO, SALARIO --CASE INSENSITIVE
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'
AND
SALARIO > 100000;

/* FILTRO BASEEADO EM UNICO TIPO E COLLUNA - ATENCAO PARA A REGRA 
DO AND E OR - EM RELACIONAMENTOS 1 X 1 O FILTRO AND TRATANDO DE UMA UNICA
COLUNA SEMPRE DARÁ FALSO */

SELECT NOME, DEPARTAMENTO, SALARIO --CASE INSENSITIVE
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'
OR
DEPARTAMENTO = 'Books';

/* FILTROS BASEADOS EM PADRAO DE CARACTERES */

SELECT NOME, DEPARTAMENTO, SALARIO --CASE INSENSITIVE
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE '%B%';

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE
DEPARTAMENTO LIKE 'B%'
GROUP BY DEPARTAMENTO;

/* FILTROS BASEADOS EM PADRAO DE CARACTERES COM MAS LETRAS */

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE
DEPARTAMENTO LIKE 'Be%'
GROUP BY DEPARTAMENTO;

/* UTILIZANDO O CARCTER CORINGA NO MEIO DA PALAVRA */

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE
DEPARTAMENTO LIKE 'B%s'
GROUP BY DEPARTAMENTO;

/* 
	E SE EU QUISESSE FILTRAR O AGRUPAMENTO PELO SALARIO?
	POR EXEMPLO, MAIOR QUE 40.000.000 
    COLUNAS NAO AGREGADAS = WHERE
    COLUNAS AGREGADAS = HAVING
*/

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE
DEPARTAMENTO LIKE 'B%s'
GROUP BY DEPARTAMENTO;

/* TRABALHO NO WHERE QUEM NAO ESTÁ AGREGADO
	NO HAVING COM QUEM ESTÁ AGREGADO
	
	O HAVING É O WHERE DAS CLAUSULAS AGREGADAS
*/

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE
DEPARTAMENTO LIKE 'B%'
GROUP BY DEPARTAMENTO
HAVING SUM(SALARIO) > 4000000;

/* MULTPIPLOS CONTADORES */

SELECT COUNT(*) FROM FUNCIONARIOS;

SELECT COUNT(*) AS "MASCULINO"
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino';

SELECT SEXO, COUNT(*) AS "MASCULINO"
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
GROUP BY SEXO;

SELECT COUNT(*) AS "QUANTIDAE TOTAL", 
(SELECT COUNT(*) AS "MACULINO"
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
GROUP BY SEXO) AS "MASCULINO"
FROM FUNCIONARIOS;

SELECT COUNT(*) AS "QTD TOTAL",
COUNT(*) FILTER(WHERE SEXO = 'Masculino') AS "QTD MASC",
COUNT(*) FILTER(WHERE SEXO = 'Feminino') AS "QTD FEM",
COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books') AS "DEP BOOKS",
COUNT(*) FILTER(WHERE SALARIO > 140000) AS "SAL > 140K"
FROM FUNCIONARIOS;

/* REFORMATACAO STRINGS */

/* LISTANDO */

SELECT DEPARTAMENTO FROM FUNCIONARIOS;

/* DISTINCT */

SELECT DISTINCT DEPARTAMENTO FROM FUNCIONARIOS;

/* UPPERR CASE */

SELECT DISTINCT UPPER(DEPARTAMENTO) FROM FUNCIONARIOS;

SELECT DISTINCT LOWER(DEPARTAMENTO) FROM FUNCIONARIOS;

/* CONCATENANDO STRINGS */

SELECT CARGO || ' - ' || DEPARTAMENTO AS "CARGO - DEP"
FROM FUNCIONARIOS;

SELECT DISTINCT (CARGO || ' - ' || DEPARTAMENTO) AS "CARGO - DEP"
FROM FUNCIONARIOS;

SELECT UPPER(CARGO || ' - ' || DEPARTAMENTO) AS "CARGO - DEP"
FROM FUNCIONARIOS;

SELECT LOWER(CARGO || ' - ' || DEPARTAMENTO) AS "cargo - dep"
FROM FUNCIONARIOS;

/* Remover espaços */

SELECT '           UNIDADOS        ';

/* CONTANDO CARACTERES */

SELECT LENGTH('           UNIDADOS        ');

SELECT TRIM('           UNIDADOS        ');

SELECT LENGTH(TRIM('           UNIDADOS        '));

/* DESAFIO - CRIAR UMA COLUNA AO LADO DA COLUNA CARGO QUE DIGA SE A PESSOA É ASSITENTE OU NAO*/

SELECT NOME, CARGO
FROM FUNCIONARIOS
WHERE CARGO
LIKE '%Assistant%';

SELECT NOME, CARGO,
CASE

	WHEN CARGO LIKE '%Assistant%' THEN 'Assistant'
	ELSE '--------'

END AS "Assistants"
FROM FUNCIONARIOS;

SELECT NOME, CARGO, (CARGO LIKE '%Assistant%') AS "ASSISTENTE?"
FROM FUNCIONARIOS;

SELECT NOME,
CASE

	WHEN CARGO LIKE '%Assistant%' THEN 1
	ELSE 0

END AS "Assistente?"
FROM FUNCIONARIOS;


