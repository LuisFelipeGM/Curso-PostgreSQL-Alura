-- Utulizando o Cascade Constraint

-- caso tentamos fazer uma exclusão do aluno que esteja matriculado em um curso
-- irá dar um erro de restrição 

delete from aluno where id = 1;

-- podemos adicionar uma regra de negocio de que inves de dar erro ao tentar excluir
-- um aluno por estar matriculado em um curso, excluir o aluno e remover ele do curso tambem

-- alterando a tabela 

drop table aluno_curso;

create table aluno_curso (
	aluno_id integer,
	curso_id integer,
	primary key (aluno_id, curso_id),
	foreign key (aluno_id) references aluno(id) on delete cascade,
	foreign key (curso_id) references curso(id) on delete cascade
);

insert into aluno_curso (aluno_id, curso_id) values (1, 1); 
insert into aluno_curso (aluno_id, curso_id) values (2, 1);
insert into aluno_curso (aluno_id, curso_id) values (2, 2);

select a.nome as "Nome do Aluno", c.nome as "Curso"
	from aluno a 
	full join aluno_curso ac on ac.aluno_id = a.id
	full join curso c on ac.curso_id = c.id;
	
-- agora rodando o delete anterior para o aluno 1 vai desmatricular ele do curso tambem

delete from aluno where id = 1;

-----------------------------------------------------------------------------
-- Utilizando o Update Cascade

select * from aluno;

-- atualizando o id do aluno (*NÃO É UMA BOA PRATICA, ESTÁ SENDO FEITO PARA FINS EDUCATIVOS*)

-- erro de restrição, o ID está em um relacionamento
update aluno 
	set id = 10
	where id = 2;

-- alterando as regras de negócio novamente para adicionar o Update cascade

drop table aluno_curso;

create table aluno_curso (
	aluno_id integer,
	curso_id integer,
	primary key (aluno_id, curso_id),
	foreign key (aluno_id) references aluno(id) on delete cascade on update cascade,
	foreign key (curso_id) references curso(id) on delete cascade on update cascade
);

insert into aluno_curso (aluno_id, curso_id) values (2, 1);
insert into aluno_curso (aluno_id, curso_id) values (2, 2);

-- Agora que a regra de negócio foi mudada o código vai funcionar pois irá alterar nos relacionamentos

update aluno 
	set id = 10
	where id = 2;


select a.id as "ID do Aluno", a.nome as "Nome do Aluno",c.id as "ID do curso", c.nome as "Curso"
	from aluno a 
	full join aluno_curso ac on ac.aluno_id = a.id
	full join curso c on ac.curso_id = c.id;

-- Obs.: na regra de negócio é possivel colocar o valor Cascade para mudar nas tabelas com relacionamento
-- ou utlizar o Restrict (padrão) para não permitir alterar ou excluir tendo ocorrencia em outra tabela




