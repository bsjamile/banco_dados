-- master fica os dados dos databases criados
-- model fica as tabelas modelos que eu quero q sejam criadas em todos os bds que eu criar
-- msdb fica informações sobre horas, agendamentos, backups, além de informacoes sobre o integration services (ETL)
-- tempdb fica tabelas temporarias, que ao fechar elas somem. 
	--Entao pode servir para criar tabelas testes, por ex
--ReportServer sao ferramentas que emitem relatorios formatados, bonitinhos 
	--para representar de forma amigavel para os clientes, por exemplo
--ReportServerTempDB serve para dividir o fluxo quando tem mta gente acessando os relatorios ao mesmo tempo

/* ASSUNTO - O DELIMITADOR DO SQL SERVER
	GO	
*/

/* CRIANDO UM BANCO DE DADOS */

/* 
   PROCESSAMENTO ASSINCRONO = SEM ORDEM 
   PROCESSA DO MAIS FÁCIL PARA O MAIS DIFICIL
   EXEMPLO: PRIMEIRO O USE, DEPOIS O CREATE TABLE E DEPOIS O CREATE DATABASE
   POR ISSO UTILIZAMOS O GO PARA FAZER O SQL ENTENDER O FLUXO
*/
/*
	O GO QUEBRA AS INSTRUCOES EM VARIOS PACOTES
	E AI O SERVIDOR SEGUE O FLUXO DA FORMA QUE VOCE ESPECIFICOU
	E NAO ESCOLHE O MAIS FACIL DE SER EXECUTADO
*/


CREATE DATABASE AULA_SQL
GO
USE AULA_SQL
GO
CREATE TABLE TESTE(
	NOME VARCHAR(30),

)
GO
DROP DATABASE AULA_SQL
GO
DROP DATABASE BANCO01
GO
DROP DATABASE BANCO02
GO
DROP DATABASE BANCO03
GO

/* ORGANIZAR FISICAMENTE E LOGICAMENTE UM BANCO DE DADOS */

/* 1 - CRIAR O BANCO COM ARQUIVOS PARA OS SETORES DE MKT E VENDAS
   2 - CRIAR UM ARQUIVO GERAL
   3 - DEIXAR O MDF APENAS COM O DICIONARIO DE DADOS
   4 - CRIAR 2 GRUPOS DE ARQUIVOS (PRIMARY - MDF)
*/

USE EMPRESA
GO

CREATE TABLE TB_EMPRESA(
	ID INT,
	NOME VARCHAR(50)
)
GO

USE EMPRESA
GO
DROP TABLE TB_EMPRESA 
