-- Ordenando as consultas
 
-- criando nova tavela de funcionarios
drop table funcionarios;
CREATE TABLE funcionarios(
    id SERIAL PRIMARY KEY,
    matricula VARCHAR(10),
    nome VARCHAR(255),
    sobrenome VARCHAR(255)
);

-- inserindo os dados 
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M001', 'Diogo', 'Mascarenhas');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M002', 'Vinícius', 'Dias');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M003', 'Nico', 'Steppat');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M004', 'João', 'Roberto');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M005', 'Diogo', 'Mascarenhas');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M006', 'Alberto', 'Martins');

-- A clausula ORDER BY defini a ordem em que os dados seram exibidos

select * from funcionarios order by nome ; -- ordenando pelo nome

-- por padrão o ORDER BY adota o padrão ASC Crescente mas podemos utilizar o DESC Decresente

select * from funcionarios order by nome DESC;

-- Ordenando a partir de 2 campos

select * from funcionarios order by nome, matricula desc; -- desc sendo aplicado somente para a matricula


-- É possivel em vez de colocar o nome do campo, colocar a posição da coluna que ele está

select * from funcionarios order by 3,4,2; -- Ordenando pelo nome, sobrenome e depois a matricula

-----------------------------------------------------------------------------

-- Limitando as consultas

-- Quando precisamos fazer uma consulta em uma tabela podemos limitar a quantidade de ocorrencias
-- que viram da consulta para não demorar muito ou não gastar muita memória do banco de dados

select * from funcionarios limit 5;

-- Caso quisermos ordenar essa busca limitada colocamos o ORDER BY antes do LIMIT

select * from funcionarios order by nome limit 5;

-- Utilizando a paginação de dados, eu vi os primeiros 5 registro mas quero ver os 5 proximos
-- O Offset determina em qual posição ele deve começar a busca, pulando as ocorrencias anteriores


select * from funcionarios order by id limit 5 offset 2;

-----------------------------------------------------------------------------

-- Funções de Agregação

-- Funções de agragação servem para agrupar registro em um único resultado sendo eles:
-- COUNT	- Retorna a quantidade de registros
-- SUM 		- Retorna a soma dos registros
-- MAX 		- Retorna o maior valor dos registros
-- MIN 		- Retorna o menor valor dos registros
-- AVG 		- Retorna a média dos registros

select * from funcionarios;

-- Para saber a quantidade de registro na tabela usamos o COUNT() 
-- que aceita 1 campo ou o coringa (*) que são todos os campos

select count(id) from funcionarios;

-- Para somar valores de uma coluna utilizamos o SUM

select count(id), sum(id) from funcionarios;

-- Para retornar o maior valor dos registros utilizamos o MAX

select count(id), sum(id), max(id) from funcionarios;

-- Para retornar o menor valor dos registros utilizamos o MIN

select count(id), sum(id), max(id), min(id) from funcionarios;

-- para retornar a média de valores de um campo utilizamos o AVG
-- utilizando o Round para arredondar a quantidade de casas decimais
select count(id), sum(id), max(id), min(id), round(avg(id),1) from funcionarios;


-----------------------------------------------------------------------------

-- Agrupando consultas

-- utilizando o agrupamento podemos fazer consultas sem que valores es repitam como por exemplo por nome:

select nome from funcionarios order by nome; -- temos 2 diogos

-- Existe 2 formas de agrupar os nomes e não ter nenhum registro repetido

-- Forma 1° é utilizando o DISTINCT, que faz com que os dados não se repitam
-- Não permite nomes duplicados mas se o nome for igual e o sobrenome for diferente ele permite
select distinct nome, sobrenome from funcionarios order by nome;

-- Forma 2° Group By, agrupa os dados iguais e é possivel usar o count() para ver quantos 
-- registros iguais existem

select nome, sobrenome, count(id) from funcionarios group by nome, sobrenome order by nome;

-- Obs.: Quando não for necessário utilizar função de agregação utilizamos 
-- o DISTINCT quando precisamos utilizamos o GROUP BY

-- Da mesma forma que o Order By pode usar o numero da coluna para ordenar, podemos utilizar da 
-- mesma forma o group by

select nome, sobrenome, count(id) from funcionarios group by 1, 2 order by nome;

-- Agrupando para ver quantos alunos tem nos cursos:

select 
	c.nome as "Nome do Curso", count(a.id) as "Número de Alunos"
from aluno a
join aluno_curso ac on a.id  = ac.aluno_id
join curso c on c.id = ac.curso_id
group by c.nome -- poderia usar o 1 para agrupar por nome do curso
order by c.nome;


-----------------------------------------------------------------------------

-- Filtrando Consultas agrupadas

-- Como posso saber quais cursos não tem alunos matriculados? utilizamos a clausula HAVING
-- ela tem a mesma função do where mas é utilizada para funções de agrupamento

select c.nome, count(a.id) 
from curso c
left join aluno_curso ac on ac.curso_id = c.id
left join aluno a on a.id = ac.aluno_id
group by 1
having count(a.id) > 0;

-- Então vamos ver quantas duplicações tem nos nomes dos funcionarios

-- Pessoas que tem nome duplicado na empresa
select nome, count(id) 
from funcionarios
group by nome
having count(id) > 1

-- Pessoas que NÃO tem nome duplicado na empresa
select nome, count(id) 
from funcionarios
group by nome
having count(id) = 1
order by 1;




