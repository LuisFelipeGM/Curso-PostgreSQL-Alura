-- Sequencias

create temp table auto(
	id serial primary key,
	nome varchar(30) not null
);

insert into auto(nome) values ('Luis Felipe');

select * from auto;

-- O serial faz auto complete na tabela de id, ele gera os números automaticamente
-- usando uma sequence, uma sequencia numérica gerenciada pelo proprio Postgre

-- Criando uma sequence

create sequence eu_criei; 
-- existe varios parametros possiveis para alterar o funcionamento da sequence

-- visualizando o proximo valor da sequence
select nextval('eu_criei');

-- em vez utilizar o serial para auto incremento no id, é possivel passar uma sequence nossa

drop table auto;

create temp table auto(
	id integer primary key default nextval('eu_criei'),
	nome varchar(30) not null
);

insert into auto(nome) values ('Luis Felipe');

-- o valor do id foi automatico e está no valor 5 porque utilizei o nextval na hora do select
select * from auto;

-- O postgre já utiliza a sequence automaticamente atraves do serial não é necessario fazer manualmente


-----------------------------------------------------------------------------
-- Tipo ENUMERATOR (ENUM)

create temp table filme(
	id serial primary key,
	nome varchar(255) not null,
	classificacao varchar(255) check (classificacao in ('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', '18_ANOS')
);-- dessa foram fica meio ruim de manipular os tipos possiveis de um campo então utilizamod o ENUM


create temp table filme(
	id serial primary key,
	nome varchar(255) not null,
	classificacao enum('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', '18_ANOS')
);-- dessa forma ficou melhor mas e se eu for utilizar esse mesmo ENUM em outras tabelas?


-- Assim é possivel criar um tipo de ENUM para ser reutilizado em varias tabelas diferentes:
-- Dessa forma a criação da tabela fica mais simples
create type classificacao as enum('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', '18_ANOS');
create temp table filme(
	id serial primary key,
	nome varchar(255) not null,
	classificacao classificacao
);

insert into filme (nome, classificacao) values ('Eu, Robo', 'teste'); -- erro teste não está no ENUM
insert into filme (nome, classificacao) values ('Eu, Robo', '14_ANOS'); -- inserido

select * from filme;

-- Documentação sobre os Tipos no Postgre
-- https://www.postgresql.org/docs/current/sql-createtype.html
-- Documentação sobre o ENUM
-- https://www.postgresql.org/docs/current/datatype-enum.html







