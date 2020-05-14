--AULA 3- CRIANDO O PRIMEIRO BANCO DE DADOS

create database cadastro; -- Cria um banco de dados chamado "cadastro". Não esqueça de quando fazer alguma coisa, atualizar para visualizar.

use cadastro; -- Seleciona o banco de dados "cadastro". É necessário mais no prompt de comando, pois aqu você pode selecionar o banco de dados clicando nele.
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

-- Ao criar bancos de dados e tabelas, você precisa definir direito o tipo de caracteres, chaves primárias, tipos primitivos certos pro banco de dados não pesar muito, etc.
-- Também, não registre a idade de uma pessoa, mas sim sua data de nascimento.
-- Constraints - Regras de criação, por exemplo, not null, collate, etc.
-- Use nvarchar, que suporta caracteres UTF-8. Acho que não tem outro jeito, pois os collates não são diretamente UTF-8, é tipo uma gambiarra.

-- Strings ou caracteres em SQL devem vir em aspas simples. 

CREATE DATABASE cadastro
COLLATE LATIN1_GENERAL_100_CI_AS_SC_UTF8; -- Cria um banco de dados chamado "cadastro" (o antigo foi apagado), onde ele só permitirá caracteres do tipo UTF-8.

USE cadastro;
CREATE TABLE pessoas (
	id int NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Identity significa que o primeiro registro começa em 1, e a cada registro, incrementa-se 1. Assim, o primeiro registro automaticamente vai ter id 1, o segundo id2, etc. Ele vai ser a chave primária. Não podem haver dois registros (tuplas) com id igual.
	nome NVARCHAR(30) NOT NULL, -- NOT NULL é uma constraint que obriga o campo ter um valor.
	nascimento SMALLDATETIME,
	sexo NVARCHAR(1) CHECK(sexo IN('F', 'M')), -- Check é uma constraint para delimitar os possíveis valores que a coluna "sexo" pode receber. Use aspas simples.
	peso DECIMAL(5, 2), -- Decimal requer dois parâmetros: O total de casas, e o total de casas decimais.
	altura DECIMAL(3, 2),
	nacionalidade NVARCHAR(20) DEFAULT 'Brasil' -- Se não digitar nada, por padrão será "Brasil".
);

SELECT * FROM pessoas;