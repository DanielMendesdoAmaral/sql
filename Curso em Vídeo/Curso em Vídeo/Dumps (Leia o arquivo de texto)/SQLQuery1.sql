-- DDL -> Data Definition Language (Linguagem de Defini��o de Dados (Define a estrutura dos bancos de dados e tabelas).) -> CREATE DATABASE, CREATE TABLE, ALTER TABLE, DROP TABLE
-- DML -> Data Manipulation Language (Linguagem de Manipula��o de Dados (Manipula os dados).) -> INSERT INTO, UPDATE, DELETE, TRUNCATE
-- DQL -> Data Query Language (Linguagem de Consulta de Dados (Seleciona os dados, faz consultas).) -> SELECT

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





-- AULA 8- FAZER BACKUP E DUMPS

-- Backup: � sempre bom ter um backup de um banco de dados antes de fazer updates, deletes, pois s�o opera��es de risco.
-- Dump: � o nome dado a um backup. Voc� pode importar qualquer dump para o seu servidor. Por exemplo, o servidor que vai ser usado, � um backup gerado pelo Curso em V�deo. Ou seja, � um dump.


-- Para fazer um backup via SMSS 
-- Pesquisador de Objetos -> Selecione o servidor -> Bancos de Dados -> Clique com o bot�o direito do mouse no banco de dados que voce deseja fazer o backup -> Tarefas -> Fazer Backup.


-- Para restaurar um banco de dados via SMSS
-- Pesquisador de Objetos -> Selecione o servidor -> Clique com o bot�o direito em Bancos de Dados -> Restaurar Banco de Dados. Lembre-se que o backup n�o pode ser retirado da pasta onde voc� colocou ele.

USE master;
DROP DATABASE cadastro; -- Excluindo o banco de dados

USE cadastro;
SELECT * FROM gafanhotos; -- Restaurei o banco de dados





-- AULA 11 - SELECT 1

-- A partir da aula 11 trabalharemos com o dump do curso em v�deo. Segue as novas tabelas:

USE cadastro;
SELECT * FROM gafanhotos;
SELECT * FROM cursos;

-- * = Todas as colunas

SELECT * FROM cursos
ORDER BY nome; -- Seleciona todos os cursos ordenando crescentemente por nome.

SELECT * FROM cursos
ORDER BY nome DESC; -- Seleciona todos os cursos ordenando decrescentemente por nome.

SELECT nome, descricao FROM cursos; -- Seleciona apenas as colunas nome e descricao.

SELECT ano, nome FROM cursos
ORDER BY ano, nome; -- Ordena por ano e por nome.

USE cadastro;
SELECT nome FROM cursos
WHERE ano = '2016' -- Seleciona todos que s�o de 2016.
ORDER BY nome;

USE cadastro;
SELECT nome, ano FROM cursos
WHERE ano <= 2019 AND ano >= 2014 -- Seleciona todos cursos de 2014 � 2019.
ORDER BY ano;

USE cadastro;
SELECT nome, carga FROM cursos
WHERE carga BETWEEN 20 AND 40 -- Seleciona todos cursos com carga hor�ria entre (between) 20 e 40.
ORDER BY ano;

USE cadastro;
SELECT nome, descricao, ano FROM cursos
WHERE ano IN (2014,2016) -- Seleciona todos os cursos de 2014 e 2016.
ORDER BY ano;





-- AULA 12 - SELECT 2

USE cadastro;
SELECT * FROM cursos
WHERE nome LIKE 'P%' -- Seleciona todos os cursos que tem a letra P no in�cio do nome. 
ORDER BY nome;

-- A porcentagem (vista acima) � um s�mbolo coringa (wildcard). Voc� pode us�-la em diferentes posi��es para obter diferentes resultados. N�o importa se a letra for mai�scula ou min�scula, com acento ou sem acento, se tiver a letra em quest�o, ele mostrar�.

USE cadastro;
SELECT * FROM cursos
WHERE nome LIKE '%A%' -- Isso acha o A em qualquer posi��o, e n�o apenas no meio como parece. Isso por que o coringa % pode achar letras ou ser vazio.
ORDER BY nome;

USE cadastro;
SELECT * FROM cursos
WHERE nome NOT LIKE '%A%' -- Seleciona todos cursos que n�o tem a letra A.
ORDER BY nome;

USE cadastro;
SELECT * FROM cursos
WHERE nome LIKE 'PH%P%' -- Usando mais de uma %.
ORDER BY nome;

-- Temos outra wildcard que � "_". Ele significa que tem um caractere na frente. Veja o exemplo a seguir.

USE cadastro;
SELECT * FROM cursos
WHERE nome LIKE 'PH%P_' -- Seleciona todos cursos que come�am com ph, e terminam com p com alguma coisa na frente do p.
ORDER BY nome;

USE cadastro;
SELECT DISTINCT carga from cursos; -- Mostra as cargas registradas na tabela.

-- FUN��ES DE AGREGA��O.

USE cadastro;
SELECT COUNT(*) FROM cursos; -- Conta quantos cursos tem cadastrados. � uma fun��o de agrega��o.

USE cadastro;
SELECT COUNT(nome) FROM cursos -- Conta quantos cursos com mais de 40 horas tem cadastrados.
WHERE carga > 40;

USE cadastro;
SELECT MAX(carga) FROM cursos; -- Mostra a maior carga entre os cursos cadastrados.

USE cadastro;
SELECT MAX(carga) FROM cursos -- Mostra a maior carga de cursos em 2016.
WHERE ano=2016;

USE cadastro;
SELECT MIN(carga) FROM cursos; -- Mostra a menor carga dentre os cursos cadastrados.

USE cadastro;
SELECT SUM(totaulas) FROM cursos; -- Mostra a soma de aulas.

USE cadastro;
SELECT AVG(totaulas) FROM cursos
WHERE ano = 2016; -- Mostra a m�dia de aulas.

-- EXERC�CIOS

-- 1- Uma lista com o nome de todas as gafanhotas.

USE cadastro;
SELECT nome FROM gafanhotos
WHERE sexo = 'F';

-- 2- Uma lista com os dados de todos aqueles que nasceram entre 1/Jan/2000 e 31/Dez/2015.

USE cadastro;
SELECT * FROM gafanhotos
WHERE nascimento >= '2000-01-01' AND nascimento <= '2015-12-31';

-- 3- Uma lista com o nome de todos os homens que trabalham como Programadores.

USE cadastro;
SELECT nome FROM gafanhotos
WHERE profissao = 'Programador' AND sexo = 'M';

-- 4- Uma lista com todos os dados de todas as mulheres que nasceram no Brasil e que t�m seu nome iniciando com a letra J.

USE cadastro;
SELECT * FROM gafanhotos 
WHERE nacionalidade = 'Brasil' AND sexo = 'F' AND nome LIKE 'J%';

-- 5- Uma lista com o nome e nacionalidade de todos os homens que t�m Silva no nome, n�o nasceram no Brasil e pesam menos de 100kg.

USE cadastro;
SELECT nome, nacionalidade FROM gafanhotos
WHERE sexo = 'M' AND nome LIKE '%silva%' AND nacionalidade != 'Brasil' AND peso < 100;

-- 6- Qual � a maior altura entre gafanhotos homens que moram no Brasil?

USE cadastro;
SELECT MAX(altura) FROM gafanhotos 
WHERE sexo = 'M' AND nacionalidade = 'Brasil';

-- 7- Qual � a m�dia de peso dos gafanhotos homens cadastrados?

USE cadastro;
SELECT AVG(peso) AS media_peso_gafanhotos_homens FROM gafanhotos -- AS cria uma coluna para exibir o resultado.
WHERE sexo = 'M'; 

-- 8- Qual � o menor peso entre as gafanhotas que nasceram fora do Brasil e entre 01/Jan/1990 e 31/Dez/2000?

USE cadastro;
SELECT MIN(peso) AS menor_peso FROM gafanhotos
WHERE sexo = 'F' AND nacionalidade != 'Brasil' AND nascimento >= '1990-01-01' AND nascimento <= '2000-12-31';

-- 9- Quantas gafanhotas tem mais de 1.90m de altura?

USE cadastro;
SELECT COUNT(*) FROM gafanhotos
WHERE sexo = 'F' AND altura > 1.90;





-- AULA 13- SELECT 3

USE cadastro;
SELECT carga FROM cursos
GROUP BY carga; -- Agrupa os elementos por carga. Diferente do distinct, que distingue.

USE cadastro;
SELECT carga, COUNT(nome) AS quantidade FROM cursos -- Mostra quantos cursos tem de cada carga hor�ria.
GROUP BY carga
ORDER BY quantidade;

USE cadastro;
SELECT carga, COUNT(nome) AS quantidade FROM cursos -- Mostra quantos cursos tem de cada carga hor�ria, mas somente se tiver mais de 3.
GROUP BY carga
HAVING COUNT(nome) > 3
ORDER BY quantidade;

USE cadastro;
SELECT ano, COUNT(*) AS quantidade FROM cursos 
WHERE ano > 2015 -- Seleciona a quantidade de cursos de cada ano acima de 2015.
GROUP BY ano
ORDER BY ano;

USE cadastro;
SELECT carga, COUNT(*) AS quantidade FROM cursos 
WHERE carga > (SELECT AVG(carga) FROM cursos) -- Sleciona todos os cursos com carga maior que a m�dia de carga de todos os cursos.
GROUP BY carga
ORDER BY carga;

-- EXERC�CIOS

USE cadastro;
SELECT * FROM gafanhotos;

-- 1- Uma lista com as profiss�es dos gafanhotos e seus respectivos quantitativos.

USE cadastro;
SELECT profissao, COUNT(*) AS quantidade FROM gafanhotos
GROUP BY profissao
ORDER BY quantidade;

-- 2- Quantos gafanhotos e quantas gafanhotas nasceram ap�s 01/Jan/2005?

USE cadastro;
SELECT sexo, COUNT(*) AS quantidade FROM gafanhotos
WHERE nascimento > '2005-01-01'
GROUP BY sexo 
ORDER BY quantidade;

-- 3- Uma lista com os gafanhotos que nasceram fora do Brasil, mostrando o pa�s de origem e o total de pessoas nascidas l�. S� nos interessam os pa�ses que tiverem mais de 3 gafanhotos com essa nacionalidade.

USE cadastro;
SELECT nacionalidade, COUNT(*) AS quantidade FROM gafanhotos 
GROUP BY nacionalidade
HAVING COUNT(*) > 3
ORDER BY quantidade;

-- 4- Uma lista agrupada pela altura dos gafanhotos, mostrando quantas pessoas pesam mais de 100kg e que est�o acima da m�dia de altura de todos os cadastrados.

USE cadastro;
SELECT altura, COUNT(*) AS quantidade FROM gafanhotos
WHERE peso > 100 AND altura > (SELECT AVG(altura) FROM gafanhotos)
GROUP BY altura
ORDER BY quantidade;





-- AULA 15- CHAVES ESTRANGEIRAS E JOIN

-- ACID - Atomicidade, Consist�ncia, Isolamento e Durabilidade.

-- Relacionamento de n-1: Pegue a chave prim�ria do lado 1 e envie como estrangeira para o lado n. As chaves estrangeira e prim�ria devem ser do mesmo tipo.

USE cadastro;
SELECT * FROM gafanhotos;
SELECT * FROM cursos;

USE cadastro;
ALTER TABLE gafanhotos
ADD cursopreferido INT; -- Adicionamos uma tabela em gafanhotos onde ficar� os cursos preferidos de cada gafanhoto.
SELECT * FROM gafanhotos;

USE cadastro;
ALTER TABLE gafanhotos
ADD FOREIGN KEY (cursopreferido)
REFERENCES cursos(idcurso); -- Adicionamos uma chave estrangeira na coluna cursopreferido, que vem da coluna idcurso da tabela cursos.
SELECT * FROM gafanhotos;

USE cadastro;
UPDATE gafanhotos
SET cursopreferido = '6' -- Adicionamos o curso preferido (com id 6, MySQL) do gafanhoto (com id 1, Daniel Morais). Fazemos isso mais 4 vezes abaixo.
WHERE id = '1';
SELECT * FROM gafanhotos;

USE cadastro;
UPDATE gafanhotos
SET cursopreferido = '4'
WHERE id = '2';
SELECT * FROM gafanhotos;

USE cadastro;
UPDATE gafanhotos
SET cursopreferido = '8' 
WHERE id = '3';
SELECT * FROM gafanhotos;

USE cadastro;
UPDATE gafanhotos
SET cursopreferido = '15' 
WHERE id = '4';
SELECT * FROM gafanhotos;

USE cadastro;
UPDATE gafanhotos
SET cursopreferido = '24' 
WHERE id = '5';
SELECT * FROM gafanhotos;

-- Note que relacionamos o ID dos cursos preferidos. Mas, e se quisermos saber o NOME dos cursos preferidos? Usamos as jun��es (INNER JOIN/OUTER JOIN).

SELECT gafanhotos.nome, cursos.nome FROM gafanhotos
JOIN cursos -- Este join � o inner join. Vide o slide da aula 15. Temos tamb�m o outer join. Usamos o inner join quando queremos saber quem prefere o qu�, ou quem � preferido.
ON cursos.idcurso = gafanhotos.cursopreferido; -- O que acontece aqui? Selecionamos a colunas nome e cursopreferido da tabela gafanhotos, juntando com a tabela cursos onderso � igual o curso preferido da tabela gafanhotos, estabelecendo uma rela��o entre as duas tabelas.

-- JOIN COM LEFT E RIGHT -> AO UTILIZARMOS LEFT OUTER JOIN (OU SIMPLESMENTE LEFT JOIN), ESTAMOS NOS REFERINDO � TABELA QUE EST� � ESQUERDA DO JOIN. SE RIGHT, � DIREITA DO JOIN.

SELECT gafanhotos.nome, cursos.nome FROM gafanhotos 
LEFT OUTER JOIN cursos -- Este � o left outer join. Por exemplo: Tem gafanhotos que n�o preferem curso nenhum. At� ent�o s� selecionamos os gafanhotos que preferem algum curso. Se quisermos mostrar tamb�m os que n�o preferem, utilizamos left outer join.
ON cursos.idcurso = gafanhotos.cursopreferido; 

SELECT gafanhotos.nome, cursos.nome FROM gafanhotos 
RIGHT OUTER JOIN cursos -- Este � o right outer join. Por exemplo: Tem cursos que n�o s�o preferidos de nenhum gafanhoto. At� ent�o s� selecionamos os cursos preferidos por algum gafanhoto. Se quisermos mostrar tamb�m os que n�o s�o preferidos, utilizamos right outer join.
ON cursos.idcurso = gafanhotos.cursopreferido; 
