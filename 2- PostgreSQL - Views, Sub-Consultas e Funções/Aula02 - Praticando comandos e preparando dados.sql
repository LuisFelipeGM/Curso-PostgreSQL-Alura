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


