-- Parâmetro composto

create table instrutor (
    id serial primary key,
        nome varchar(255) not null,
        salario decimal(10, 2)
);

insert into instrutor (nome, salario) values ('Vinicius Dias', 100);

-- Criando função para retornar o dobro de salário de um instrutor

create or replace function dobro_do_salario(instrutor) returns decimal as $$
	select $1.salario * 2 as Dobro
$$ language sql;

-- Quando passamos o parametro instrutor estamos passando um registro inteiro
-- da tabela instrutor, logo para chamar a função passamos:

select nome, dobro_do_salario(instrutor.*) from instrutor;

-- Dessa forma ele vai aplicar essa função para todos os registros da tabela
-- Assim estamos passando parametros compostos por varios tipos primitivos diferentes
-- (Objetos no banco)

-----------------------------------------------------------------------------

-- Retorno composto

-- Para Realizar o retorno composto, os dados devem estar na mesma ordem
-- e seus tipos sejam iguais aos que estão na tabela

create or replace function cria_instrutor_falso() returns instrutor as $$
	select 22, 'nome falso', 200::decimal;
$$ language sql;

-- Quando chamamos a funçao é retornado uma linha (objeto ou registro)
-- completo como se fosse um registro na tabela instrutor

select cria_instrutor_falso();

-- Consigo utilizar o retorno dessa funçao como se fosse uma tabela:

select * from cria_instrutor_falso();


-----------------------------------------------------------------------------

-- Retornando Conjuntos

-- Antes foi dito que só iria retornar o primeiro registro da ultima consulta
-- da função, agora vamos ver como retornar conjuntos

-- inserindo dados para popular a tabela

INSERT INTO instrutor (nome, salario) VALUES ('Vinicius Dias', 100);
INSERT INTO instrutor (nome, salario) VALUES ('Diogo Mascarenhas', 200);
INSERT INTO instrutor (nome, salario) VALUES ('Nico Steppat', 300);
INSERT INTO instrutor (nome, salario) VALUES ('Juliana', 400);
INSERT INTO instrutor (nome, salario) VALUES ('Priscila', 500);

-- Para retornar um conjunto utilizamos o (SETOF)

create or replace function instrutores_bem_pagos(valor_salario decimal) returns setof instrutor as $$
	select * from instrutor where salario > valor_salario;
$$ language sql;

select * from instrutores_bem_pagos(300);

-- Em vez de usar o SETOF e o tipo é possivel retornar uma tabela 

drop function instrutores_bem_pagos;

create or replace function instrutores_bem_pagos(valor_salario decimal) returns table (id integer, nome varchar, salario decimal) as $$
	select * from instrutor where salario > valor_salario;
$$ language sql;

-- Mas como já possuo a tabela com os tipos, a utilização do SETOF é
-- muito mais comum

-----------------------------------------------------------------------------

-- Parâmetros de Saída

-- Como vimos antes tem algumas formas de retornar mais de um valor da function, porem 
-- tem uma outra forma de realizar isso atraves do (OUT) criando variaveis de saida

create or replace function soma_e_produto (numero_1 integer, numero_2 integer, out soma integer, out produto integer) as $$
	select numero_1 + numero_2 as soma, numero_1 * numero_2 as produto;
$$ language sql;

-- nessa função não temos o (returns) pois vamos retornar as variaveis de saida

select * from soma_e_produto(3,3);

-- Outra coisa que poderiamos fazer é criar um tipo e retornar esse tipo:

create type dois_valores as (soma integer, produto integer);

drop function soma_e_produto;

create or replace function soma_e_produto (numero_1 integer, numero_2 integer)returns dois_valores as $$
	select numero_1 + numero_2 as soma, numero_1 * numero_2 as produto;
$$ language sql;

select * from soma_e_produto(3,3);

-- Sabendo desses parametros de saída agora podemos utilizar o record

drop function instrutores_bem_pagos;

create or replace function instrutores_bem_pagos(valor_salario decimal, out nome varchar, out salario decimal) returns setof record as $$
	select nome, salario from instrutor where salario > valor_salario;
$$ language sql;

select * from instrutores_bem_pagos(300); 

-- Como foi definido os parametros de saida anteriormente eu apenas preciso dizer que quero
-- todos os registros (SETOF) e que retorna qualquer coisa (record), como já foi definido antes
-- não é necessario definir de novo

-- A boa prática é criar um tipo para deixar explicito o retorno, mas os parametro de saida são uma opção













