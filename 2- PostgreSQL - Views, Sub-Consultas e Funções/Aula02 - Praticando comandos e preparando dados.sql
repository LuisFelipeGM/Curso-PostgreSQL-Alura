-- Preparando Dados

-- É possivel fazer insert de multiplas linhas dessa forma:

-- Tabela Aluno
INSERT INTO aluno (primeiro_nome, ultimo_nome, data_nascimento) VALUES (
	'Vinicius', 'Dias', '1997-10-15'
), (
	'Patricia', 'Freitas', '1986-10-25'
), (
	'Diogo', 'Oliveira', '1984-08-27'
), (
	'Maria', 'Rosa', '1985-01-01'
);

-- Tabela Categoria
INSERT INTO categoria (nome) VALUES ('Front-end'), ('Programação'), ('Bancos de dados'), ('Data Science');

-- Tabela Curso
INSERT INTO curso (nome, categoria_id) VALUES
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
	
-- Tabela Aluno_curso
INSERT INTO aluno_curso VALUES (1, 4), (1, 11), (2, 1), (2, 2), (3, 4), (3, 3), (4, 4), (4, 6), (4, 5);

-- Relembrando que caso eu queira alterar um item que não tem uma chave estrangeira
-- apontando para ele não preciso configurar o Cascade posso alterar direto

-- verificando o id
select * from categoria where id = 4;

-- NUNCA ESQUECER de colocar o (WHERE) no UPDATE, se não iria trocar todos os registros para 'Ciência de Dados'
update categoria set nome = 'Ciência de Dados' where id = 4;

select * from categoria;

-----------------------------------------------------------------------------

-- Praticando a criação de relátorios

-- Relátorio dos alunos que estão matriculados em mais cursos, ordenados pelo numero de cursos

select a.primeiro_nome, a.ultimo_nome,
	   count(ac.curso_id) "Números de Cursos"
	from aluno a
	join aluno_curso ac on a.id = ac.aluno_id
group by 1, 2
order by "Números de Cursos" desc 
	limit 1; -- Trazendo apenas a pessoa que fez mais cursos
	

-----------------------------------------------------------------------------

-- Gerando relátorio dos cursos mais requisitados
	
select c.nome, count(ac.curso_id) "Números de Alunos"
	from curso c
	join aluno_curso ac on c.id = ac.curso_id
group by 1
order by "Números de Alunos" desc
	limit 1; -- Trazendo apenas o curso com mais pessoas
	

-----------------------------------------------------------------------------

-- Gerando relátorio da categoria mais requisitada

select ca.nome, count(c.categoria_id) "Número de Cursos"
	from categoria ca
	join curso c on ca.id = c.categoria_id
group by 1
order by "Número de Cursos" desc
	limit 1; -- Trazendo apenas a categoria com mais cursos
	
	
	
	
	
	



