-- Detalhes do INSERT

-- Sempre que formos inserir valores do tipo String ou Datas precisamos utlizar Aspas simples ('')
-- Aspas Simples delimitão valores

insert into teste values ('a', 'b');

-- Já Aspas duplas delimita nome de colunas (utilizado para colunas e Alias)

select primeira_coluna as "Primeira Coluna" from teste;

-- Para inserir números com ponto flutuante usamos o (.) para separar eles, a virgula (,)
-- serve apenas para separar os valores no comando então sempre usar o ponto

insert into teste values (18.0);


-----------------------------------------------------------------------------
-- INSERT SELECT

-- Adicionando os dados dos cursos e alunos novamente porem no novo Schema


INSERT INTO academico.aluno (primeiro_nome, ultimo_nome, data_nascimento) VALUES 
	('Vinicius', 'Dias', '1997-10-15'), 
	('Patricia', 'Freitas', '1986-10-25'), 
	('Diogo', 'Oliveira', '1984-08-27'), 
	('Maria', 'Rosa', '1985-01-01');

INSERT INTO academico.categoria (nome) VALUES ('Front-end'), ('Programação'), ('Bancos de dados'), ('Data Science');

INSERT INTO academico.curso (nome, categoria_id) VALUES
	('HTML', 1),
	('CSS', 1),
	('JS', 1),
	('PHP', 2),
	('Java', 2),
	('C++', 2),
	('PostgreSQL', 3),
	('MySQL', 3),
	('Oracle', 3),
	('SQL Server', 3),
	('SQLite', 3),
	('Pandas', 4),
	('Machine Learning', 4),
	('Power BI', 4);
	
INSERT INTO academico.aluno_curso VALUES (1, 4), (1, 11), (2, 1), (2, 2), (3, 4), (3, 3), (4, 4), (4, 6), (4, 5);


-- Relatório buscar todos os cursos da categoria programação:

select academico.curso.id, academico.curso.nome
	from academico.curso 
	join academico.categoria on academico.categoria.id = academico.curso.categoria_id
where categoria_id = 2;

-- Criando uma tabela temporaria para incluir o resultado dessa query

create temporary table cursos_programacao (
	id_curso integer primary key,
	nome_curso varchar(255) not null
);

-- para ter o resultado da query no insert é preciso apenas colocar a query depois do insert:

-- Tabela que vai ser inserida
insert into cursos_programacao 
-- select a ser usado (Necessario que a ordem esteja igual a dos campos da tabela)
select academico.curso.id, academico.curso.nome -- select a ser usado
	from academico.curso 
	join academico.categoria on academico.categoria.id = academico.curso.categoria_id
where categoria_id = 2;

select * from cursos_programacao;


-----------------------------------------------------------------------------
-- Importando Dados

-- para a importação de dados antes de tudo precisamos ter um destino para esses dados

create schema teste;

create table teste.cursos_programacao (
	id_curso integer primary key,
	nome_curso varchar(255) not null
);

insert into teste.cursos_programacao 
select academico.curso.id, academico.curso.nome
	from academico.curso 
	join academico.categoria on academico.categoria.id = academico.curso.categoria_id
where categoria_id = 2;


select * from teste.cursos_programacao;

-- Agora importamos o arquivo .CSV indo na tabela nas pastas do lado esquerdo e import





