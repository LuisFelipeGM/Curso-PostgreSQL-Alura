-- Inserindo na tabela aluno
insert into aluno 
	(nome, 
	cpf, 
	observacao, 
	idade, 
	dinheiro, 
	altura, 
	ativo, 
	data_nascimento, 
	hora_aula, 
	matriculado_em) 
values 
	('Luís Felipe', 
	'12345678901', 
	'Luís Felipe é um excelente aluno e muito esforçado', 
	19,
	100.50,
	1.81,
	true,
	'2003-09-01',
	'17:30:00',
	'2023-08-18 10:20:00');
	
select * from aluno;

-----------------------------------------------------

-- Alterando um registro na tabela aluno

update aluno set 
	nome = 'Vicent', 
	cpf = '98765432109', 
	observacao = 'Muito inteligente', 
	idade = 38, 
	dinheiro = 15.28, 
	altura = 1.82, 
	ativo = FALSE, 
	data_nascimento = '1980-01-15', 
	hora_aula = '13:00:00', 
	matriculado_em = '2020-01-02 15:00:00'
where id = 1;

select * from aluno;

-----------------------------------------------------

-- Deletando um registro na tabela aluno

-- Verificando se o where do dado que quero deletar está correto
select * from aluno where nome = 'Vicent';

delete from aluno where nome = 'Vicent';

select * from aluno;













