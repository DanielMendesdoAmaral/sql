/*

	Deseja-se criar um banco de dados para uma agência de turismo, contendo informações sobre recursos oferecidos pelas cidades que fazem parte da programação de turismo 
da agência. As informações a serem mantidas sobre cada cidade referem-se a hotéis, restaurantes e pontos turísticos.





	-- Sobre os hotéis que a cidade possui deseja-se guardar o código, o nome, o endereço, a categoria (sem estrela, 1 estrela, 2 estrelas, ...), os tipos de quartos que os 
formam (simples, mediano, luxo, superluxo), o número dos quartos e o valor da diária de acordo com o tipo do quarto.
	-- Sobre cada cidade deve-se armazenar seu nome, seu estado e a população. Além disso, quando uma nova cidade é cadastrada no banco de dados da agência, um código é a 
ela oferecido.
	-- Cada restaurante da cidade possui um código que o identifica, um nome, um endereço e o tipo de sua categoria (luxo, simples, ...). Além disso, um restaurante pode
pertencer a um hotel e um hotel somente pode ser associado a um restaurante. 
	-- Diferentes pontos turísticos da cidade estão cadastrados no sistema: igrejas, casas de show e museus. A agência de turismo somente trabalha com estes três tipos de 
pontos turísticos. Nenhum outro é possível. 
	-- Além da descrição e do endereço, igrejas devem possuir como característica a data e o estilo de construção. 
	-- Já casas de show devem armazenar o horário de início do show (igual para todos os dias da semana) e o dia de fechamento (apenas um único dia na semana), além da 
descrição e do seu endereço. 
	-- Finalmente, os museus devem armazenar o seu endereço, descrição, data de fundação e número de salas. Um museu pode ter sido fundado por vários fundadores. Para estes,
deve-se armazenar o seu nome, a data de nascimento e a data da morte (se houver), a nacionalidade e a atividade profissional que desenvolvia. Além disso, um mesmo 
fundador pode ter fundado vários museus. 
	-- Quando qualquer ponto turístico é cadastrado no sistema, ele também recebe um código que o identifica. O mesmo é válido para fundadores.
	-- Finalmente, casas de show podem possuir restaurante. Quando o cliente da agência reserva um passeio para uma casa de show, ele já sabe se esta possui restaurante e 
qual o preço médio da refeição, além da especialidade (comida chinesa, japonesa, brasileira, italiana, ...). Dentro de uma casa de show, apenas um único restaurante pode 
existir.





	Faça o esquema conceitual para o banco de dados acima descrito. Defina restrições de participação total e parcial de forma apropriada
	Considerações: os atributos endereço e data não precisam ser decompostos. Eles podem ser considerados como atributos atômicos; considere hotel como apenas um único 
objeto físico, e não como uma cadeia de hotéis. O mesmo vale para restaurante e ponto turístico. 

*/

CREATE DATABASE agenciaTurismo;

USE agenciaTurismo;
CREATE TABLE cidades (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	nome VARCHAR(40) UNIQUE NOT NULL,
	estadoPertencente VARCHAR(40) CHECK(estadoPertencente IN('RS', 'PR', 'SC', 'SP', 'ES',  'RJ', 'MG', 'BA', 'MT', 'MS', 'GO', 'SE', 'RO', 'AM', 'AC', 'PE', 'MA', 'PA', 'CE', 'RN', 'PI', 'PB', 'RR', 'AL', 'AP', 'TO', 'DF')),
	populacao INT NOT NULL
);

USE agenciaTurismo;
CREATE TABLE quartos (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	tipo VARCHAR(10) NOT NULL CHECK(tipo IN('Simples', 'Mediano', 'Luxo', 'Superluxo')),
	numero TINYINT NOT NULL UNIQUE,
	valorDiaria DECIMAL(6,2) NOT NULL,
	hotelPertencente TINYINT NOT NULL FOREIGN KEY REFERENCES hoteis(codigo)
);

USE agenciaTurismo;
CREATE TABLE hoteis (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	nome VARCHAR(40) UNIQUE NOT NULL,
	endereco VARCHAR(100) UNIQUE NOT NULL,
	categoria VARCHAR(20) NOT NULL CHECK(categoria IN('Sem estrela', '1 estrela', '2 estrelas', '3 estrelas', '4 estrelas', '5 estrelas')),
	cidade TINYINT NOT NULL FOREIGN KEY REFERENCES cidades(codigo),
	restaurante TINYINT FOREIGN KEY REFERENCES restaurantes(codigo)
);

USE agenciaTurismo;
CREATE TABLE restaurantes (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	nome VARCHAR(40) UNIQUE NOT NULL,
	endereco VARCHAR(100) UNIQUE NOT NULL,
	categoria VARCHAR(20) NOT NULL, CHECK(categoria IN('Simples', 'Mediano', 'Luxo', 'Superluxo')),
	precoMedio DECIMAL(5,2) NOT NULL,
	especialidade VARCHAR(20) NOT NULL CHECK(especialidade IN('Chinesa', 'Japonesa', 'Italiana', 'Fast Food', 'Brasileira')),
	cidade TINYINT NOT NULL FOREIGN KEY REFERENCES cidades(codigo)
);

USE agenciaTurismo;
CREATE TABLE casasDeShow (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	endereco VARCHAR(100) UNIQUE NOT NULL,
	descricao VARCHAR(500) NOT NULL,
	horarioInicioShow TIME NOT NULL,
	diaFechamento DATETIME NOT NULL,
	cidade TINYINT NOT NULL FOREIGN KEY REFERENCES cidades(codigo),
	restaurante TINYINT FOREIGN KEY REFERENCES restaurantes(codigo)
);

USE agenciaTurismo;
CREATE TABLE igrejas (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	endereco VARCHAR(100) UNIQUE NOT NULL,
	descricao VARCHAR(500) NOT NULL,
	dataCriacao DATETIME NOT NULL,
	tipoConstrucao VARCHAR(20) NOT NULL CHECK(tipoConstrucao IN('Comum', 'Barroca', 'Santuário', 'Templo', 'Catedral', 'Convento')),
	cidade TINYINT NOT NULL FOREIGN KEY REFERENCES cidades(codigo)
);

USE agenciaTurismo;
CREATE TABLE museus (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	endereco VARCHAR(100) UNIQUE NOT NULL,
	descricao VARCHAR(500) NOT NULL,
	dataCriacao DATETIME NOT NULL,
	numeroSalas SMALLINT NOT NULL,
	cidade TINYINT NOT NULL FOREIGN KEY REFERENCES cidades(codigo)
);

USE agenciaTurismo;
CREATE TABLE fundadores (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	nome VARCHAR(40) UNIQUE NOT NULL,
	dataNascimento DATETIME NOT NULL,
	dataMorte DATETIME,
	nacionalidade VARCHAR(30) NOT NULL,
	profissao VARCHAR(30) NOT NULL
);

USE agenciaTurismo;
CREATE TABLE fundar (
	codigo TINYINT IDENTITY(0,1) PRIMARY KEY,
	museu TINYINT NOT NULL FOREIGN KEY REFERENCES museus(codigo),
	fundador TINYINT NOT NULL FOREIGN KEY REFERENCES fundadores(codigo)
);

USE agenciaTurismo;
INSERT INTO cidades VALUES
('São Paulo', 'SP', 12018000),
('Fortaleza', 'CE', 2643000);
SELECT * FROM cidades;

USE agenciaTurismo;
INSERT INTO restaurantes VALUES
('Gero', 'Rua Giovanni Battista Pirelli, 279 - Vila Homero Thon, São Paulo, SP', 'Superluxo', '360.00', 'Italiana', '1'),
('McDonalds', 'Rua José Walter Meirelles, 450 - Condomínio Araucária, Fortaleza, CE', 'Mediano', '30.00', 'Fast Food', '2'),
('Japan Sushis', 'Avenida Belchior, 21 - São Paulo, SP', 'Luxo', '90.00', 'Japonesa', '1'),
('Casa do Norte', 'Rua Abraham Krabbs, 98 - Fortaleza, CE', 'Superluxo', '360.00', 'Brasileira', '2')
SELECT * FROM restaurantes;

USE agenciaTurismo;
INSERT INTO hoteis VALUES
('Pirelli Hotel', 'Rua Giovanni Battista Pirelli, 279 - Vila Homero Thon, São Paulo, SP', '5 estrelas', '1', '0'),
('Meirelles Hotel', 'Rua José Walter Meirelles, 450 - Condomínio Araucária, Fortaleza, CE', '3 estrelas', '2', '1')
SELECT * FROM hoteis;

USE agenciaTurismo;
INSERT INTO quartos VALUES
('Superluxo', '1', '3600.00', '3'),
('Superluxo', '2', '3600.00', '3'),
('Superluxo', '3', '3600.00', '3'),
('Superluxo', '4', '3600.00', '3'),
('Superluxo', '5', '3600.00', '3'),
('Mediano', '10', '300.00', '4'),
('Mediano', '20', '300.00', '4'),
('Mediano', '30', '300.00', '4'),
('Mediano', '40', '300.00', '4'),
('Mediano', '50', '300.00', '4')
SELECT * FROM quartos;

INSERT INTO casasDeShow VALUES
('Avenida Belchior, 21 - São Paulo, SP', 'A melhor casa de shows de São Paulo.', '19:30', '2020-01-01', '1', '3'),
('Rua Abraham Krabbs, 98 - Fortaleza, CE', 'A melhor casa de shows de Fortaleza.', '15:00', '2020-02-02', '2', '4')
SELECT * FROM casasDeShow;

INSERT INTO igrejas VALUES
('Rua Augusto Pereira, 56 - São Paulo, SP', 'Templo de Salomão', '2015-01-01', 'Templo', '1'),
('Rua Senhora de Oliveira, 98 - Fortaleza, CE', 'Igreja turística', '1896-02-02', 'Barroca', '2')
SELECT * FROM igrejas;

INSERT INTO museus VALUES
('Rua Augusto Pereira, 65 - São Paulo, SP', 'Museu do Ipiranga', '1800-01-01', '100', '1'),
('Rua Senhora de Oliveira, 89 - Fortaleza, CE', 'Museu do Lampião', '1950-02-02', '50', '2')
SELECT * FROM museus;

INSERT INTO fundadores VALUES
('Pedro', '1780-01-01', '1860-01-01', 'Português', 'Historiador'),
('Francisco', '1925-01-01', '2010-01-01', 'Brasileiro', 'Arquiteto')
SELECT * FROM fundadores;

INSERT INTO fundar VALUES 
('1', '0'),
('1', '1'),
('2', '0'),
('2', '1')
SELECT * FROM fundar;

USE agenciaTurismo;
SELECT hoteis.nome, quartos.numero FROM hoteis -- Seleciona os quartos dos hoteis
JOIN quartos 
ON hoteis.codigo = quartos.hotelPertencente;

USE agenciaTurismo;
SELECT hoteis.nome, cidades.nome FROM hoteis  -- Seleciona os hoteis das cidades
JOIN cidades 
ON hoteis.cidade = cidades.codigo;

USE agenciaTurismo;
SELECT hoteis.nome, restaurantes.nome FROM hoteis -- Seleciona os restaurantes dos hoteis.
JOIN restaurantes 
ON hoteis.restaurante = restaurantes.codigo;

USE agenciaTurismo;
SELECT restaurantes.nome, cidades.nome FROM restaurantes -- Seleciona os restaurantes das cidades.
JOIN cidades 
ON restaurantes.cidade = cidades.codigo;

USE agenciaTurismo;
SELECT casasDeShow.descricao, cidades.nome FROM casasDeShow -- Seleciona as casas de shows das cidades.
JOIN cidades 
ON casasDeShow.cidade = cidades.codigo;

USE agenciaTurismo;
SELECT restaurantes.nome, casasDeShow.descricao FROM restaurantes -- Seleciona os restaurantes das casas de shows.
JOIN casasDeShow 
ON casasDeShow.restaurante = restaurantes.codigo;

USE agenciaTurismo;
SELECT igrejas.descricao, cidades.nome FROM igrejas -- Seleciona as igrejas da cidade.
JOIN cidades 
ON igrejas.cidade = cidades.codigo;

USE agenciaTurismo;
SELECT cidades.nome, museus.descricao FROM cidades  -- Seleciona os museus da cidade.
JOIN museus
ON cidades.codigo = museus.cidade;

USE agenciaTurismo;
SELECT museus.descricao, fundadores.nome FROM museus -- Seleciona os fundadores dos museus.
JOIN fundar
ON museus.codigo = fundar.museu 
JOIN fundadores 
ON fundadores.codigo = fundar.fundador;