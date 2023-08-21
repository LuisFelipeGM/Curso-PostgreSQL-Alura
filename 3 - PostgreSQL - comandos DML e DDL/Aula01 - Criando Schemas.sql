-- Criando Schemas

-- Schemas servem para fazer a separação de tabelas no memso banco de dados,
-- colocando em sub pacotes com nomes especificos, assim podendo organizar
-- as tabelas pelo projeto ou área de atuação, podendo até mesmo ter 2 tabelas
-- com o mesmo nome em Schemas diferentes no mesmo banco de dados!

-- Obs.: Quando não é criado um Schema o Postgre usa o Schema padrão (public)

-- Criando o Schema:

create schema academico;

-- Criando as tabelas no Schema
-- Para criar a tabela no Schema precisamos referenciar ele:
-- NomeDoSchema.NomeDaTabela

create table academico.aluno(
	id serial primary key,
	primeiro_nome varchar(255) not null,
	ultimo_nome varchar(255) not null,
	data_nascimento date not null
);

create table academico.categoria (
	id serial primary key,
	nome varchar(255) not null
);

create table academico.curso(
	id serial primary key,
	nome varchar(255) not null,
	categoria_id integer not null references academico.categoria(id)
);


create table academico.aluno_curso(
	aluno_id integer not null references academico.aluno(id), 
	curso_id integer not null references academico.curso(id),
	primary key(aluno_id, curso_id)
);




