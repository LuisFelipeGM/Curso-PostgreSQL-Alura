CREATE DATABASE alura;

CREATE DATABASE teste;

DROP DATABASE teste;

-----------------------------------------------------------------------------

create table aluno(
	id serial,
	nome varchar(255),
	cpf char(11),
	observacao text,
	idade integer,
	dinheiro numeric(10,2),
	altura real,
	ativo boolean,
	data_nascimento date,
	hora_aula time,
	matriculado_em timestamp
);

select * from aluno;