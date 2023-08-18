-- Consulta pegando todos os campos da tabela (*)
select * from aluno;

-- Consulta pegando apenas os campos desejados
select 
	nome, 
	idade,
	matriculado_em
from aluno;

-- Utilizando o Alias (AS) para alterar o nome da tabela APENAS na exibição
select 
	nome,
	idade, 
	matriculado_em as quando_se_matriculou 
from aluno;

-- Utilizando o Alias acima precisamos colocar o Underscore(_) para a separação das palavras
-- Mas caso quisermos utilizar a separação com espaçoas ( ) é necessario colocar entre aspas duplas ("")

select 
	nome as "Nome do Aluno",
	idade, 
	matriculado_em as quando_se_matriculou 
from aluno;

-----------------------------------------------------------------------------

-- UTILIZANDO FILTROS

select * from aluno;

insert into aluno (nome) values ('Vicent Scheuer');
insert into aluno (nome) values ('Nilverton Lopes');
insert into aluno (nome) values ('Pedro Chueiri');
insert into aluno (nome) values ('Heitor');
insert into aluno (nome) values ('Diogo');
insert into aluno (nome) values ('Diego');

-- Quando usamos o Where com algum campo e com o igual (=) estamos comparando
-- exatamente o valor do campo assim retornando as ocorrencias
-- tive que colocar exatamente como está no campo, os dois nomes e o acento no nome
select * from aluno where nome = 'Luís Felipe';

-- Se pesquisar só 'Luis' não vai achar nada
select * from aluno where nome = 'Luis';

-- Agora vamos pesquisar as ocorrencias diferentes de Heitor 
-- utilizando o sinal (<>) ou (!=)
select * from aluno where nome <> 'Heitor';
select * from aluno where nome != 'Heitor';

-- O LIKE é um operador especial de pesquisa ele busca ocorrencias parecidas no campo
-- Tendo 2 operadores especiais o (_) e o (%)

-- O _ significa qualquer caracter naquela posição então se fizermos Di_go pode vir qualquer nome
-- que tenho DI GO no nome nesse caso (Diego e Diogo)

select * from aluno where nome like 'Di_go';

-- O % significa que pode pegar qualquer ocorrencia até aquele ponto ignorando oque vem a seguir
-- se fizermos D% ele vai pegar todos os nomes que começam com D

select * from aluno where nome like 'D%';

select * from aluno where nome like '% %'; -- pegando todos os nomes compostos que tem espaço

select * from aluno where nome like '%i%o%'; -- pegando todos os nomes que tenham i e o em qualquer posição

-- Temos também o NOT LIKE que ele não iria buscar ocorrencias que passamos e vai retornas as outras

select * from aluno where nome not like 'Di_go';

-----------------------------------------------------------------------------

-- Filtro generico que funciona para qualquer tipo de campo sendo o IS NULL e o IS NOT NULL
-- para fazer pesquisas em campos que estão nulos é necessario colocar o is, o igual não funciona nesse caso

select * from aluno where cpf is null; -- trazendo todos os alunos que o cpf está nulo

select * from aluno where cpf is not null; -- trazendo todos os alunos que o cpf não está nulo


-- OPERADORES PARA FILTRO DE CAMPOS NUMÉRICOS E DATAS

-- O igual (=) e diferente (<>)(!=) também funcionam para filtros de tipos numéricos e Datas

select * from aluno where idade = 19;

select * from aluno where idade != 19; -- as ocorrencias que tem idade nula nãom aparecem no filtro

-- Os Operadores são os de comparação:
-- Maior que (>)
-- Menor que (<)
-- Maior ou igual que (<=)
-- Menor ou igual que (>=)

select * from aluno where idade > 19;

select * from aluno where idade < 20;

select * from aluno where idade >= 19;

select * from aluno where idade <= 19;


-- Outro operador é o BETWEEN que pega as ocorrencias no intervalo de um campo

select * from aluno where idade between 10 and 15;


-- OPERADORES PARA CAMPOS BOOLEAN

-- os unicos operadores que funcionam para valores tipo boolean são os de
-- comparação (=), diferente (!=) e IS para buscar valores nulos

select * from aluno where ativo = true;

select * from aluno where ativo != true;

select * from aluno where ativo is null;


-----------------------------------------------------------------------------

-- UTILIZANDO OPERADORES LÓGICOS (AND) E (OR)

-- Utilizando o And os dois filtros tem que ser verdadeiros para a ocorrencia aparecer

select * from aluno where nome like 'D%' and cpf is null

-- Utilizando o Or um dos filtros pode ser verdadeiro para a ocorrencia aparecer

select * from aluno where nome like 'Diogo' or idade between 10 and 20;

select * from aluno 
	where nome like 'D%' 
	or nome like 'Lu%'
	or nome like '%ei%';


