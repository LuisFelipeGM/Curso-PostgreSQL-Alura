-- UPDATE FROM

-- O UPDATE FROM é usado para alterar os valores de um registro no banco de dados

-- Alterei o resgistro de ID 4 que passou o nome do curso de PHP para PHP Básico
update academico.curso set nome = 'PHP Básico' where id = 4;
update academico.curso set nome = 'Java Básico' where id = 5;
update academico.curso set nome = 'C++ Básico' where id = 6;

select * from academico.curso order by 1;


-- Os dados do Schema teste estão desatualizados comparado com o Schema Academico

update teste.cursos_programacao set nome_curso = nome
	from academico.curso where teste.cursos_programacao.id_curso  = academico.curso.id;

select * from teste.cursos_programacao;

-- Dessa forma é possivel atualizar valores de uma tabela em outra atraves do UPDATE SET FROM

-----------------------------------------------------------------------------
-- Erros que acontecem usando o Update e Delete

-- removendo todos os dados da minha tabela
delete from teste.cursos_programacao;
-- dessa forma foi removido todos os dados dessa tabela e não é uma boa pratica
-- Então SEMPRE é necessário utilizar a Clausula WHERE para todos os comandos DML


-----------------------------------------------------------------------------
-- Transações - COMMIT e ROLLBACK

-- São formas de você salvar o estado do banco naquele momento antes de fazer 
-- um UPDATE ou DELETE, marcando um Checkpoint, assim se der erro ou algum problema
-- eu posso voltar para o estado anterior ou aceitar o novo estado

-- para marcar o começo de uma Transação utilizo o:

start transaction;
-- ou
begin;

-- Se for necessário voltar atras para o Checkpoint realizado antes damos um Rollback

rollback;

-- Caso a alteração que desejamos fazer foi feita de forma certa e desejada utilizamos o
-- Commit

commit;

-- Se estiver uma Transação aberta e nos desconectarmos do banco, o Postgre da o Rollback
-- automaticamente

-- Então antes de sair sempre é necessário utilizar o COMMIT ou ROLLBACK
-- Documentação sobre Transações:
-- https://www.postgresql.org/docs/current/tutorial-transactions.html

