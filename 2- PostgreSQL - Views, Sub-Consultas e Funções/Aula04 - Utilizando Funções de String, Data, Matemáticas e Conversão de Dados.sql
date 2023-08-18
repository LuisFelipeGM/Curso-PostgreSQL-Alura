-- Usando Funções do PostgreSQL

select * from aluno;

-- Utilizando a função de Concatenação

-- Esse operador de concatenação junta as Strings do nome
select (primeiro_nome || ' ' || ultimo_nome) as nome_completo from aluno;

-- Porém se utilizar o operador || para concatenar uma string com algo null
-- tudo será null

select 'Luis Felipe' || ' ' || null; 

-- Para resolver isso temos a função CONCAT(), separando os parametro com ,
-- O Null no concat é ignorado
select concat('Luis Felipe', ' ', null);

-- Existe muitas funções para manipular Strings, link da documentação do PostgreSQL:
-- https://www.postgresql.org/docs/9.1/functions-string.html

-- Caso eu queira deixar toda a String em CAIXA ALTA é possivel usar a função
-- UPPER

select upper(concat('Luis Felipe', ' ', 'Garcia Menezes')); -- utilizando 2 funções

-- Caso eu precise remover os espaços no começo e no fim da String temos a função TRIM

select trim(upper(concat(' Luis Felipe', ' ', 'Garcia Menezes')) || ' ');

-----------------------------------------------------------------------------

-- Funções de Data

select concat(primeiro_nome, ' ', ultimo_nome) as nome_completo, data_nascimento from aluno;

-- Vamos fazer um calculo da idade da pessoa, para pegar a data atual 
-- temos uma função de data chamada NOW

select concat(primeiro_nome, ' ', ultimo_nome) as nome_completo, data_nascimento, now() from aluno;

-- O retorno do NOW tras a data, hora, minutos, segundos, milesimos e time zone
-- Se não for preciso todas essas informações é possivel tranformar o timestamp para data
-- utilizando o (::) para converter e o DATE no final 

select concat(primeiro_nome, ' ', ultimo_nome) as nome_completo, data_nascimento, now()::date from aluno;

-- Para saber a idade de uma pessoa posso pegar a data de hoje e subtrair a data de nascimento

select concat(primeiro_nome, ' ', ultimo_nome) as nome_completo, now()::date - data_nascimento from aluno;

-- Porem o retorno está em dias então temos que dividir por 365

select concat(primeiro_nome, ' ', ultimo_nome) as nome_completo, (now()::date - data_nascimento) / 365 as idade from aluno;

-- O código ficou meio grande, mas o Postgre tem uma função para calcular a idade:

select concat(primeiro_nome, ' ', ultimo_nome) as nome_completo, age(data_nascimento) as idade from aluno;

-- A função AGE retorna ano, mes e dia, para retirar só o ano podemos usar a função EXTRACT

select concat(primeiro_nome, ' ', ultimo_nome) as nome_completo, extract(year from age(data_nascimento)) as idade from aluno;

-- Documentação para ver as funções de data:
-- https://www.postgresql.org/docs/9.1/functions-datetime.html


-----------------------------------------------------------------------------

-- Funções Matemáticas

-- Documentação das funções matemáticas:
-- https://www.postgresql.org/docs/9.5/functions-math.html

-- Função que retorna o valor de PI

select pi(); 

-- Essas funções matemáticas são usadas apenas quando necessário em casos muito especficos

-----------------------------------------------------------------------------

-- Conversão de Dados

-- A forma mais facil de converter dados é utilizando a função TO_CHAR

select to_char(now(), 'DD/MM/YYYY'); -- Passando para o to char a data e o formato desejado

-- Documentação para os tipos de formação para datas:
-- https://www.postgresql.org/docs/9.5/functions-formatting.html

select to_char(now(), 'DD, MONTH, YYYY');

-- Conversão direta de tipos:

select 128.3::real;

-- Transformando para Caracter

select to_char(128.3::real, '999D99');


-- DOCUMENTAÇÃO DE TODAS AS FUNÇÕES
-- https://www.postgresql.org/docs/current/functions.html








