-- DDL -> Data Definition Language (Linguagem de Defini��o de Dados (Define a estrutura dos bancos de dados e tabelas).) -> CREATE DATABASE, CREATE TABLE, ALTER TABLE, DROP TABLE
-- DML -> Data Manipulation Language (Linguagem de Manipula��o de Dados (Manipula os dados).) -> INSERT INTO, UPDATE, DELETE, TRUNCATE

--AULA 3- CRIANDO O PRIMEIRO BANCO DE DADOS

create database cadastro; -- Cria um banco de dados chamado "cadastro". N�o esque�a de quando fazer alguma coisa, atualizar para visualizar.

use cadastro; -- Seleciona o banco de dados "cadastro". � necess�rio mais no prompt de comando, pois aqu voc� pode selecionar o banco de dados clicando nele.
create table pessoas ( -- Cria uma tabela chamada "pessoas".
nome varchar(30),
idade tinyint, 
sexo char(1), 
peso float,
altura float,
nacionalidade varchar(20)
);

use cadastro;
select * from pessoas; -- Visualiza tudo da tabela "pessoas".





--AULA 4- MELHORANDO A ESTRUTURA DO BANCO DE DADOS

-- Apaga o banco de dados "cadastro";
use master;  
go
drop database cadastro;
go

-- Ao criar bancos de dados e tabelas, voc� precisa definir direito o tipo de caracteres, chaves prim�rias, tipos primitivos certos pro banco de dados n�o pesar muito, etc.
-- Tamb�m, n�o registre a idade de uma pessoa, mas sim sua data de nascimento.
-- Constraints - Regras de cria��o, por exemplo, not null, collate, etc.
-- Use nvarchar, que suporta caracteres UTF-8. Acho que n�o tem outro jeito, pois os collates n�o s�o diretamente UTF-8, � tipo uma gambiarra.

-- Dados em SQL devem vir em aspas simples. O que n�o estiver em aspas simples s�o constraints.

CREATE DATABASE cadastro
COLLATE LATIN1_GENERAL_100_CI_AS_SC_UTF8; -- Cria um banco de dados chamado "cadastro" (o antigo foi apagado), onde ele s� permitir� caracteres do tipo UTF-8.

USE cadastro;
CREATE TABLE pessoas (
	id int NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Identity significa que o primeiro registro come�a em 1, e a cada registro, incrementa-se 1. Assim, o primeiro registro automaticamente vai ter id 1, o segundo id2, etc. Ele vai ser a chave prim�ria. N�o podem haver dois registros (tuplas) com id igual.
	nome NVARCHAR(30) NOT NULL, -- NOT NULL � uma constraint que obriga o campo ter um valor.
	nascimento SMALLDATETIME,
	sexo NVARCHAR(1) CHECK(sexo IN('F', 'M')), -- Check � uma constraint para delimitar os poss�veis valores que a coluna "sexo" pode receber. Use aspas simples.
	peso DECIMAL(5, 2), -- Decimal requer dois par�metros: O total de casas, e o total de casas decimais.
	altura DECIMAL(3, 2),
	nacionalidade NVARCHAR(20) DEFAULT 'Brasil' -- Se n�o digitar nada, por padr�o ser� "Brasil".
);

SELECT * FROM pessoas;





-- AULA 5- INSERINDO DADOS NA TABELA (INSERT INTO)

USE cadastro;
INSERT INTO pessoas -- Insere na tabela pessoas os valores...
(nome, nascimento, sexo, peso, altura) -- Note que n�o colocamos id nem nacionalidade, pois o id � auto-increment e a nacionalidade, se n�o digitar nada, � "Brasil".
VALUES
('Lauro', '1938-08-08', 'M', '70', '1.75'); -- Datas em SQL seguem o seguinte formato: AAAA-DD-MM

USE cadastro;
INSERT INTO pessoas 
(nome, nascimento, sexo, peso, altura)
VALUES
('Maria', '1960-08-03', 'F', '53', '1.55'), -- Neste exemplo cadastramos v�rias pessoas em apenas um INSERT INTO.
('Juninho', '1992-30-04', 'M', '65', '1.80'),
('Daniel', '2003-13-08', 'M', '50', '1.75');
SELECT * FROM pessoas;

USE cadastro;
INSERT INTO pessoas VALUES
('Mariana', '1985-05-09', 'F', '55', '1.55', DEFAULT); -- Neste exemplo n�o colocamos os campos a serem preenchidos. Para este caso, coloque todos os campos corretamente nos construtores. N�o colocamos o id pois ele j� est� especificado por padr�o. A nacionalidade colocamos default pois queremos o padr�o, ou seja, Brasil.
SELECT * FROM pessoas;

USE cadastro;
INSERT INTO pessoas
(altura, peso, sexo, nascimento, nome, nacionalidade) -- Neste exemplo invertemos a ordem do construtor. Coloque esta linha apenas se voc� quiser omitir algum dado ou inverter a ordem. Caso o contr�rio n�o precisa.
VALUES
('1.85', '95', 'M', '1972-11-01', 'Cristiano', 'Portugal'),
('1.55', '70', 'F', '2002-24-06', 'Kamilly', DEFAULT);
SELECT * FROM pessoas;





-- AULA 6- ALTERANDO A ESTRUTURA DA TABELA (ALTER TABLE E DROP TABLE)

-- Coluna = campo de uma tabela. Para mexer em colunas, use alter table.

USE cadastro;
ALTER TABLE pessoas
ADD profissao NVARCHAR(10);
SELECT * FROM pessoas;  -- Adiciona a coluna "profissao" � tabela "pessoas".

USE cadastro;
ALTER TABLE pessoas
DROP COLUMN profissao; -- Apaga a coluna "profissao".
SELECT * FROM pessoas;

USE cadastro;
ALTER TABLE pessoas
ADD profissao NVARCHAR(10);

USE cadastro;
ALTER TABLE pessoas
ALTER COLUMN profissao NVARCHAR(20); -- Modificamos o tipo da coluna. Voc� tamb�m pode modificar as constraints.

-- Em SQL, para renomear, n�o d� para usar o LATER TABLE. Mas, temos uma solu��o:

USE cadastro;
EXEC sp_rename 'pessoas', 'gafanhotos'; -- Renomeia a tabela "pessoas" para "gafanhotos".
SELECT * FROM gafanhotos;

USE cadastro;
EXEC sp_rename 'gafanhotos.peso', 'massa'; -- Renomeia a coluna "peso" para "massa".
SELECT * FROM gafanhotos;

USE cadastro;
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='cursos' AND XTYPE='u') -- S� vai criar a tabela se n�o existir, assim, n�o dar� problemas.
	CREATE TABLE cursos (
		nome NVARCHAR(30) NOT NULL UNIQUE, -- Unique � uma constraint que n�o aceita registros iguais.
		descricao NVARCHAR(4000),
		carga INT,
		totalAulas INT,
		ano DATETIME DEFAULT '2016'
	);
SELECT * FROM cursos;

USE cadastro;
ALTER TABLE cursos
ADD id INT IDENTITY(1,1); 
SELECT * FROM cursos;

USE cadastro;
ALTER TABLE cursos
ADD PRIMARY KEY(id); -- Para adicionar uma coluna como chave prim�ria ap�s a tabela j� ter sido constru�da.
SELECT * FROM cursos;

USE cadastro;
CREATE TABLE apagar (
	auxiliar CHAR,
	apagarColuna INT
);
SELECT * FROM apagar;

USE cadastro;
ALTER TABLE apagar
DROP COLUMN apagarColuna; -- Apaga a coluna "apagarColuna" da tabela "apagar".
SELECT * FROM apagar;

USE cadastro;
DROP TABLE apagar; -- Apaga a tabela "apagar".

-- Para apagar um banco de dados use "DROP DATABASE nome_database"





-- AULA 7- MANIPULANDO LINHAS (UPDATE, DELETE E TRUNCATE)

-- Registro = linha = tupla

USE cadastro;
INSERT INTO cursos VALUES
('HTML4', 'Curso de HTML5', '40', '37', '2014'),
('Algoritmos', 'L�gica de Programa��o', '20', '15', '2014'),
('Photoshop', 'Dicas de Photoshop CC', '10', '8', '2014'),
('PGP', 'Curso de PHP para iniciantes', '40', '20', '2010'),
('Jarva', 'Introdu��o � Linguagem Java', '10', '29', '2000'),
('MySQL', 'Banco de Dados MySQL', '30', '15', '2016'),
('Word', 'Curso completo de Word', '40', '30', '2018'),
('Sapateado', 'Dan�as R�tmicas', '40', '30', '2018'),
('Cozinha �rabe', 'Aprenda a fazer kibe', '40', '30', '2018'),
('YouTuber', 'Gerar pol�mica e ganhar inscritos', '5', '2', '2018');
SELECT * FROM cursos;

UPDATE cursos
SET nome = 'HTML5' -- Coloca o nome "HTML5" no registro que tem o id "1". Note a import�ncia de uma chave prim�ria.
WHERE id = '1';
SELECT * FROM cursos;

UPDATE cursos
SET nome = 'PHP', ano = '2015' -- Muda dois atributos ao mesmo tempo.
WHERE id = '4';
SELECT * FROM cursos;

UPDATE cursos 
SET nome = 'Java', carga = '40', ano = '2015'
WHERE id = '5';
SELECT * FROM cursos;

DELETE FROM cursos
WHERE id = '8'; -- Deleta da tabela o objeto com id 8.
SELECT * FROM cursos;

DELETE FROM cursos
WHERE id = '9';
SELECT * FROM cursos;

DELETE FROM cursos
WHERE id = '10';
SELECT * FROM cursos;

TRUNCATE TABLE cursos; -- Apaga TODOS os registros da tabela cursos.
SELECT * FROM cursos;