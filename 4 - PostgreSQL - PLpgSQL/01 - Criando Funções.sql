-- Criando Funções


-- Primeiro é necessário fazer a criação da funçao
-- escrevendo o (CREATE FUNCTION) e o nome da função
-- Depois sempre é necessário dizer o retorno dessa função
-- Após isso o código a ser executado e por fim a linguaguem
-- que será utilizada

create function primeira_funcao() returns integer as '
	select (5 - 3) * 2
' language sql;

-- Uma das formas de chamar uma função:

select * from primeira_funcao();

-- É possível utilizar Alias para mudar o nome da coluna de retorno da função

select * from primeira_funcao() as "Primeira Função";

-- Se a função retorna um único valor é normal vermos a chamada da função assim:

select primeira_funcao();

-----------------------------------------------------------------------------

-- Recebendo parâmetros

-- Para passarmos valores por parametros precisamos colocar o nome da variavel
-- local e o tipo dentro dos () da função

-- Tornando o código dinâmico

create function soma_dois_numeros(numero_1 integer, numero_2 integer) returns integer as '
	select numero_1 + numero_2;
' language sql;


select soma_dois_numeros(2, 2);

-- é possivel não passar o nome da variavel passada por parâmetro
-- assim quando for utilizar ela passamos a posição dela no parametro
-- através do $ e a posição:

drop function soma_dois_numeros;

create function soma_dois_numeros(integer, integer) returns integer as '
	select $1 + $2;
' language sql;

select soma_dois_numeros(17, 3);

-- É possivel mas não recomendado, pois é importante saber qual variavel está
-- sendo usada e no futuro podemos ter functions com varios parametros


-----------------------------------------------------------------------------

-- Detalhes sobre funções

-- exemplo

create table a (nome varchar(255) not null);

create function cria_a(nome varchar) returns varchar as '
-- colocamos o nome da funcao para referenciar que o nome está vindo
-- do parâmetro
	insert into a (nome) values (cria_a.nome); 
' language sql;

-- O código anterior dá erro pois o retorno da função está definido
-- como varchar logo é necessario que a ultima coisa da função seja
-- o retorno de um varchar nesse caso, logo o codigo seria:

create function cria_a(nome varchar) returns varchar as '
-- colocamos o nome da funcao para referenciar que o nome está vindo
-- do parâmetro
	insert into a (nome) values (cria_a.nome); 

	select nome; -- nome vindo do parametro
' language sql;

-- Sempre que eu tiver um retorno o ultimo comando deve ter algo que me retorne um valor
-- Sempre vai retornar o PRIMEIRO item do comando utilizado
-- Se utilizar o select da tabela a, somente será retornado o primeiro registro

-- (create) cria se não houver essa função, o (or replace) subistitui se a função já
-- existir

create or replace function cria_a(nome varchar) returns varchar as '
	insert into a (nome) values (cria_a.nome); 
	select nome;
' language sql;

select cria_a('Luis Felipe');


-- Se quisermos que a função não retorne nada, apenas insira no banco de dados
-- podemos utilizar o void no retorno

--Obs.: Não podemos alterar uma função se mudarmos seu retorno ou os parametros
-- é necessário utilizar o drop

drop function cria_a;

create or replace function cria_a(nome varchar) returns void as '
	insert into a (nome) values (cria_a.nome); 
' language sql;

select cria_a('Luis Felipe');


-- Se caso seja necessário utilizar uma string dentro da função teremos um problema
-- a declaração da função é dentro de '' caso utilizarmos uma string dara erro
-- exemplo de ERRO:
create or replace function cria_a(nome varchar) returns void as '
	insert into a (nome) values ('Luis Felipe'); 
' language sql;

-- para evitarmos esse erro, a forma mais comum é utilizar a
-- anotação de $$ para delimitar as srings, vai ser utilizado dessa
-- forma daqui para frente

create or replace function cria_a(nome varchar) returns void as $$
	insert into a (nome) values ('Luis Felipe'); 
$$ language sql;




