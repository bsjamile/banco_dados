/* EXERCICIOS - DATABASE SALARIOS */

/* QUAL A MODA DOS SALARIOS. A MODA DOS SALÁRIOS DIZ ALGO DE RELEVANTE? */

SELECT MODE() WITHIN GROUP(ORDER BY SALARIO) AS MODA
FROM FUNCIONARIOS;

/* QUAL A MODA DEPARTAMENTAL? QUAL O DEPARTAMENTO QUE MAIS EMPREGA? */

SELECT MODE() WITHIN GROUP(ORDER BY DEPARTAMENTO) AS MODA
FROM FUNCIONARIOS;
/* BELEZA E ROUPAS TEM A MESMA QTD DE EMPREGADOS*/

/* QUAL O DESVIO PADRAO DE CADA DEPARTAMENTO? */

SELECT DEPARTAMENTO, 
	   SUM(SALARIO) AS TOTAL_DEP,
	   ROUND(STDDEV_POP(SALARIO),2) AS DESV_PAD
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO
ORDER BY 3;


/* CALCULE A MEDIANA SALARIAL DE TODO O SET DE DADOS */

SELECT MAX(SALARIO) AS MAX_SAL,
	   MIN(SALARIO) AS MIN_SAL,
	   ROUND((MAX(SALARIO) - MIN(SALARIO)),2) AS AMPLITUDE,
	   ROUND(MEDIAN(SALARIO),2) AS MEDIANA
FROM FUNCIONARIOS;

/* QUAL A AMPLITUDE DE TODOS OS SALARIOS? */

SELECT MAX(SALARIO) AS MAX_SAL,
	   MIN(SALARIO) AS MIN_SAL,
	   ROUND(MAX(SALARIO) - MIN(SALARIO),2) AS AMPLITUDE
FROM FUNCIONARIOS;


/* CALCULE AS PRINCIPAIS MEDIDAS ESTATÍSTICAS POR DEPARTAMENTO */

SELECT DEPARTAMENTO,
	   COUNT(SALARIO) AS "quantidade",
	   SUM(SALARIO) AS "total",
	   ROUND(AVG(SALARIO),2) AS "media",
	   ROUND(MAX(SALARIO),2) AS "maximo",
	   ROUND(MIN(SALARIO),2) AS "minimo",
	   ROUND((MAX(SALARIO) - MIN(SALARIO)),2) AS "amplitude",
	   ROUND(VAR_POP(SALARIO),2) AS "variancia",
	   ROUND(STDDEV_POP(SALARIO),2) AS "desv padrao",
	   ROUND(MEDIAN(SALARIO),2) AS "mediana",
	   MODE() WITHIN GROUP(ORDER BY SALARIO) AS "moda",
	   ROUND(((STDDEV_POP(SALARIO) / AVG(SALARIO)) * 100 ),2) AS "coef var"
	   FROM FUNCIONARIOS
	   GROUP BY DEPARTAMENTO
	   ORDER BY 8;

/* QUAL DEPARTAMENTO DE TÁ UMA MAIOR PROBABILIDADE DE GANHAR MAIS? -- OUTDOOR */
	--MENOR DESV PADRAO, MENOR VARIANCIA, MENOR COEF VAR, MAIOR MEDIANA