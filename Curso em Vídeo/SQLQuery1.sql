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

-- Strings ou caracteres em SQL devem vir em aspas simples. 

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