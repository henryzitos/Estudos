SELECT * FROM Empregado;
SELECT * FROM Dependente;
SELECT * FROM Orgao;

-- SOMA DOS SALÁRIOS
SELECT sum(Salario) FROM Empregado;
-- SOMA DOS SALÁRIOS POR CARGO
SELECT c.Nome_cargo, (
  SELECT SUM(Salario)
  FROM Empregado e
  WHERE e.fk_Cargo_id_cargo = c.id_cargo
);
FROM Cargo c;
-- SOMA DOS SALÁRIOS POR CARGO E ÓRGÃO
SELECT o.Nome_orgao, c.Nome_cargo, SUM(e.Salario)
FROM Orgao o
INNER JOIN Empregado e ON o.id_orgao = e.fk_Orgao_id_orgao
INNER JOIN Cargo c ON e.fk_Cargo_id_cargo = c.id_cargo
GROUP BY o.Nome_orgao, c.Nome_cargo;

-- MÉDIA DOS SALÁRIOS POR SEXO
SELECT Sexo, AVG(Salario) FROM Empregado GROUP BY sexo;
-- MÉDIA DOS SALÁRIOS POR ANO DE NASCIMENTO
SELECT YEAR(dataNascimento), AVG(Salario) FROM Empregado GROUP BY YEAR(dataNascimento);

-- CONTAGEM DE QUANTOS DEPENDENTES CADA EMPREGADO TEM
SELECT e.Matricula, COUNT(d.idDependente) FROM Empregado e
LEFT JOIN Dependente d ON e.Matricula = d.fk_Empregado_Matricula
GROUP BY e.Matricula;
-- TODOS OS EMPREGADOS COM DEPENDENTES MENOR QUE UMA IDADE x
SELECT e.Matricula, e.Nome, d.Nome_dependente, e.dataNascimento FROM Empregado e
JOIN Dependente d ON e.Matricula = d.fk_Empregado_Matricula
WHERE TIMESTAMPDIFF(YEAR, e.dataNascimento, CURDATE()) < 18;

-- TODOS OS NOMES DOS EMPREGADOS COM SALÁRIO E NOME DOS DEVIDOS DEPENDENTES SE HOUVER (OU SEJA, SE TIVER MAIS DE UM DEPENDENTE APARECE n VEZES, SE NÃO TIVER DEPENDENTE APARECE 1 VEZ)
SELECT e.Nome, e.Salario, IFNULL(d.Nome_dependente, 'Sem Dependente') FROM Empregado e
LEFT JOIN Dependente d ON e.Matricula = d.fk_Empregado_Matricula
ORDER BY e.Nome, d.Nome_dependente;
