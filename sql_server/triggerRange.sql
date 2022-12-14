/* TRIGGER DE RANGE */

/* ERRO 16,1 = O BANCO AVISANDO QUE VC ESTA FAZENDO ALGO ERRADO*/

SELECT 'TRIGGERS' + 10
GO

CREATE TABLE SALARIO_RANGE(
	MINSAL MONEY,
	MAXSAL MONEY
)
GO

INSERT INTO SALARIO_RANGE VALUES(
	3000.00,6000.00
)
GO

DELETE FROM SALARIO_RANGE
GO

SELECT * FROM SALARIO_RANGE
GO

SELECT * FROM EMPREGADO
GO

CREATE TRIGGER TG_RANGE
ON DBO.EMPREGADO
FOR INSERT,UPDATE
AS
	DECLARE
		@MINSAL MONEY,
		@MAXSAL MONEY,
		@ATUALSAL MONEY

	SELECT @MINSAL = MINSAL, @MAXSAL = MAXSAL FROM SALARIO_RANGE

	SELECT @ATUALSAL = I.SALARIO
	FROM INSERTED I

	IF(@ATUALSAL < @MINSAL)
	BEGIN
			RAISERROR('SALARIO MENOR QUE O PISO',16,1)
			ROLLBACK TRANSACTION
	END

	IF(@ATUALSAL > @MAXSAL)
	BEGIN
			RAISERROR('SALARIO MAIOR QUE O TETO',16,1)
			ROLLBACK TRANSACTION
	END
GO

INSERT INTO EMPREGADO VALUES(4,'JAMILE',5000.00,NULL)
INSERT INTO EMPREGADO VALUES(5,'GABRIELLA',7000.00,NULL)
INSERT INTO EMPREGADO VALUES(6,'SIMONE',2000.00,NULL)
GO

UPDATE EMPREGADO SET SALARIO = 9000.00
WHERE IDEMP = 1
GO

UPDATE EMPREGADO SET SALARIO = 1000.00
WHERE IDEMP = 1
GO


SELECT * FROM EMPREGADO
GO

SELECT * FROM SALARIO_RANGE
GO

/* VERIFICANDO O TEXTO DE UMA TRIGGER */

SP_HELPTEXT TG_RANGE
GO 