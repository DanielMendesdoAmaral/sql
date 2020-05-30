/*

	Deseja-se criar um banco de dados para uma ag�ncia de turismo, contendo informa��es sobre recursos oferecidos pelas cidades que fazem parte da programa��o de turismo 
da ag�ncia. As informa��es a serem mantidas sobre cada cidade referem-se a hot�is, restaurantes e pontos tur�sticos.





	-- Sobre os hot�is que a cidade possui deseja-se guardar o c�digo, o nome, o endere�o, a categoria (sem estrela, 1 estrela, 2 estrelas, ...), os tipos de quartos que os 
formam (simples, mediano, luxo, superluxo), o n�mero dos quartos e o valor da di�ria de acordo com o tipo do quarto.
	-- Sobre cada cidade deve-se armazenar seu nome, seu estado e a popula��o. Al�m disso, quando uma nova cidade � cadastrada no banco de dados da ag�ncia, um c�digo � a 
ela oferecido.
	-- Cada restaurante da cidade possui um c�digo que o identifica, um nome, um endere�o e o tipo de sua categoria (luxo, simples, ...). Al�m disso, um restaurante pode
pertencer a um hotel e um hotel somente pode ser associado a um restaurante. 
	-- Diferentes pontos tur�sticos da cidade est�o cadastrados no sistema: igrejas, casas de show e museus. A ag�ncia de turismo somente trabalha com estes tr�s tipos de 
pontos tur�sticos. Nenhum outro � poss�vel. 
	-- Al�m da descri��o e do endere�o, igrejas devem possuir como caracter�stica a data e o estilo de constru��o. 
	-- J� casas de show devem armazenar o hor�rio de in�cio do show (igual para todos os dias da semana) e o dia de fechamento (apenas um �nico dia na semana), al�m da 
descri��o e do seu endere�o. 
	-- Finalmente, os museus devem armazenar o seu endere�o, descri��o, data de funda��o e n�mero de salas. Um museu pode ter sido fundado por v�rios fundadores. Para estes,
deve-se armazenar o seu nome, a data de nascimento e a data da morte (se houver), a nacionalidade e a atividade profissional que desenvolvia. Al�m disso, um mesmo 
fundador pode ter fundado v�rios museus. 
	-- Quando qualquer ponto tur�stico � cadastrado no sistema, ele tamb�m recebe um c�digo que o identifica. O mesmo � v�lido para fundadores.
	-- Finalmente, casas de show podem possuir restaurante. Quando o cliente da ag�ncia reserva um passeio para uma casa de show, ele j� sabe se esta possui restaurante e 
qual o pre�o m�dio da refei��o, al�m da especialidade (comida chinesa, japonesa, brasileira, italiana, ...). Dentro de uma casa de show, apenas um �nico restaurante pode 
existir.





	Fa�a o esquema conceitual para o banco de dados acima descrito. Defina restri��es de participa��o total e parcial de forma apropriada
	Considera��es: os atributos endere�o e data n�o precisam ser decompostos. Eles podem ser considerados como atributos at�micos; considere hotel como apenas um �nico 
objeto f�sico, e n�o como uma cadeia de hot�is. O mesmo vale para restaurante e ponto tur�stico. 

*/

CREATE DATABASE agenciaTurismo;