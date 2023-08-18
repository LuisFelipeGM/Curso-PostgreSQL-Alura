-- Criando tabela com chave primária

-- Toda tabela precia ter o campo de Identificação (ID) para pegarmos a ocorrencia exata
-- Porem não podemos ter IDs nullos ou repetidos.
-- Em vez de colocar not null e unique colocamos primary key que tem a propriedade dos dois
create table curso (
	id integer primary key,
	nome varchar(255) not null
);

insert into curso (id, nome) values (1, 'Java'); -- OK
insert into curso (id, nome) values (1, 'Node'); -- da erro pq o id já existe
insert into curso (id, nome) values (2, 'Node'); -- OK

select * from curso;

-----------------------------------------------------------------------------
-- Criando tabela com chave estrangeira

-- Criando tabela aluno novamente mais simples para o exemplo

drop table aluno;

create table aluno(
	id SERIAL primary key,
	nome varchar(255) not null
);

insert into aluno (nome) values ('Diogo');
insert into aluno (nome) values ('Vinicius');

select * from aluno;

select * from curso;

-- Criando tabela composta

create table aluno_curso (
	aluno_id integer,
	curso_id integer,
	primary key (aluno_id, curso_id),
	-- Adicionando o relacionamento de chave estrangeira:
	foreign key (aluno_id) references aluno(id),
	foreign key (curso_id) references curso(id)
);

-- Como é chave primária composta não pode cadastrar o mesmo aluno no mesmo curso 2 vezes 
-- aluno 1 (Diogo) está fazendo o curso 1 (Java)
insert into aluno_curso (aluno_id, curso_id) values (1, 1); 
insert into aluno_curso (aluno_id, curso_id) values (2, 1);
insert into aluno_curso (aluno_id, curso_id) values (2, 2);

-----------------------------------------------------------------------------

-- Realizando consultas com relacionamentos (Join)

select * from aluno;

select * from curso;

select a.nome as "Nome do Aluno", c.nome as "Curso"
	from aluno a
	inner join aluno_curso ac on ac.aluno_id = a.id
	inner join curso c on ac.curso_id = c.id;


-----------------------------------------------------------------------------
-- LEFT, RIGHT, CROSS e FULL JOINS

insert into aluno (nome) values ('Igor');
insert into curso (id, nome) values (3, 'Python')

select * from aluno;

-- Utilizando a consulta de innerjoin acima não é possivel ver o aluno Igor pois
-- ele não está matriulado a nenhum curso logo temos que usar o left ou right join

-- utilizando o left join para trazer todo os alunos mesmo não estando em nenhum curso
select a.nome as "Nome do Aluno", c.nome as "Curso"
	from aluno a left join aluno_curso ac on ac.aluno_id = a.id
	left join curso c on ac.curso_id = c.id;

-- utilizando o right join para trazer os cursos mesmo não sendo utilizados por aluno
select a.nome as "Nome do Aluno", c.nome as "Curso"
	from aluno a 
	right join aluno_curso ac on ac.aluno_id = a.id
	right join curso c on ac.curso_id = c.id;

-- utilizando o full join para trazer todos os dados independente se tiver relacionamento
select a.nome as "Nome do Aluno", c.nome as "Curso"
	from aluno a 
	full join aluno_curso ac on ac.aluno_id = a.id
	full join curso c on ac.curso_id = c.id;

-- utilizando o cross join para combinar todas as linhas da tabela a com todas as linhas da tabela b
select a.nome as "Nome do Aluno", c.nome as "Curso"
	from aluno a 
	cross join curso c;






