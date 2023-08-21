-- Recriando as tabelas com base no curso apresentado
drop table aluno_curso;
drop table aluno;
drop table curso;

create table aluno(
	id serial primary key,
	primeiro_nome varchar(255) not null,
	ultimo_nome varchar(255) not null,
	data_nascimento date not null
);

create table categoria (
	id serial primary key,
	nome varchar(255) not null
);

create table curso(
	id serial primary key,
	nome varchar(255) not null,
	categoria_id integer not null references categoria(id)
);


create table aluno_curso(
	aluno_id integer not null references aluno(id), -- definindo a chave estrangeira direto
	curso_id integer not null references curso(id),
	primary key(aluno_id, curso_id)
);

-- Carregando dados nas tabelas

-- Tabela Alunos
insert into aluno (primeiro_nome, ultimo_nome, data_nascimento) values ('Luis Felipe', 'Garcia Menezes', '2003-09-01');
insert into aluno (primeiro_nome, ultimo_nome, data_nascimento) values ('Pedro Henrique', 'Chueiri', '2002-02-17');
insert into aluno (primeiro_nome, ultimo_nome, data_nascimento) values ('Victor Hugo', 'Domingues de Oliveira', '2003-09-22');
insert into aluno (primeiro_nome, ultimo_nome, data_nascimento) values ('Lucas', 'Leonardi', '1998-05-15');
insert into aluno (primeiro_nome, ultimo_nome, data_nascimento) values ('Fernanda', 'Menezes', '1992-03-17');

select * from aluno;

-- Tabela Categoria
insert into categoria (nome) values ('Programação');
insert into categoria (nome) values ('Front-End');
insert into categoria (nome) values ('Data Science');
insert into categoria (nome) values ('DevOps');
insert into categoria (nome) values ('Mobile');

select * from aluno;

-- Tabela Curso
insert into curso (nome, categoria_id) values ('Java', 1);
insert into curso (nome, categoria_id) values ('React', 2);
insert into curso (nome, categoria_id) values ('PostgreSQL', 3);
insert into curso (nome, categoria_id) values ('Azure DevOps', 4);
insert into curso (nome, categoria_id) values ('Flutter', 5);

select * from curso;

-- Tabela Aluno_Curso
insert into aluno_curso (aluno_id, curso_id) values (1, 1);
insert into aluno_curso (aluno_id, curso_id) values (2, 2);
insert into aluno_curso (aluno_id, curso_id) values (3, 3);
insert into aluno_curso (aluno_id, curso_id) values (4, 4);
insert into aluno_curso (aluno_id, curso_id) values (5, 1);

select * from aluno_curso;


