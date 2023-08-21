-- Criando um Banco de Dados

-- O Padrão de criação de um banco de dados é o seguinte:

 CREATE DATABASE nome
    [ [ WITH ] [ OWNER [=] user_name ] --  o dono desse banco de dados
           [ TEMPLATE [=] template ] -- template a ser seguido
           [ ENCODING [=] codificação ] ] -- tabela de caracteres que será utilizado
           [ LC_COLLATE [=] lc_collate ] -- tratar a ordenação de dados com base no encoding
           [ LC_CTYPE [=] lc_ctype ] -- responsável por verificar se as letras maiúsculas ou 
           							 -- minúsculas afetam outras questões, como comparação
           [ TABLESPACE [=] tablespace_name] --  podemos criar espaços físicos onde o Postgre vai 
           									 -- separar nossos bancos de dados
           [ ALLOW_CONNECTIONS [=] allowconn] --  para sempre permitir conexões
           [ CONNECTION LIMIT [=] connlimit] -- limite de conexões
           [ IS TEMPLATE [=] istemplate] -- se esse banco é ou não um template
           
-- se usarmos só a 1 linha (create database nome), criamos o banco de dados com todas
-- as informações padrões 
           
-- Exemplo:

CREATE DATABASE alura
    WITH
    OWNER = postgres
    ENCONDING = "UTF8"
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = 01;

-----------------------------------------------------------------------------

-- Defições em tabelas
   
-- Na criação de uma tabela tem muitas funções que podem ser usadas para aquela
-- tabela ter determinada funcionalidade sendo diversos casos, no curso é abordado sobre o
-- TEMPORARY ou TEMP, IF NOT EXISTS, CHECK, DEFAULT e UNIQUE
   
-- Documentação completa sobre:
-- https://www.postgresql.org/docs/12/sql-createtable.html

   
-- IF NOT EXISTS é uma verificação que é feita na hora da execução da criação de uma
-- tabela, se a tabela já existir o código é ignorado e vai para proxima execução assim
-- evitando um erro e parando a execução do script

CREATE TABLE IF NOT EXISTS academico.aluno (
    id SERIAL PRIMARY key,
    primeiro_nome VARCHAR(255) NOT NULL,
    ultimo_nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL
);


-- TEMPORARY ou TEMP, é utilizado para criar uma tabela temporária que é excluida assim que
-- for finalizado a sessão do banco de dados

CREATE TEMPORARY TABLE a (
        coluna VARCHAR(255) NOT NULL
);

-- CHECK é utilizado para verificar se no momento da inserção está passando algum valor 
-- que não é permitido para a tabela por exemplo:

CREATE TEMPORARY TABLE a (
        coluna VARCHAR(255) NOT NULL CHECK (coluna <> '')
);
-- está vendo se quando for passado o valor da coluna, não pode ter o valor de uma string vazia ('')

-- Já o DEFAULT é utilizado para atribuir valores padrões para as colunas das tabelas se não forem
-- passados na hora do insert

-- No exemplo abaixo se a pessoa não passar a data de nascimento o valor padrão será a data atual:

CREATE TABLE academico.aluno (
    id SERIAL PRIMARY KEY;
    primeiro_nome VARCHAR(255) NOT null;
    ultimo_nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT null default now()::date
);

-- O UNIQUE serve para deixar os valores de determinada tabela unicos logo não pode ter 
-- valores repetidos, muito usado para números de documentos porem é possivel usar o 
-- UNIQUE para gerar combinações unicas entre 2 colunas de tabelas

--  Não podemos permitir que tenhamos valores repetidos em ambas colunas na tabela.

CREATE TEMPORARY TABLE a (
        coluna1 VARCHAR(255) NOT NULL CHECK (coluna1 <> ''),
        coluna2 VARCHAR(255) NOT NULL,
        UNIQUE (coluna1, coluna2)
);

INSERT INTO a VALUES ("a", "b"); -- É executado e adicionado a tabela
INSERT INTO a VALUES ("a", "b"); -- Erro pois violou a constraint
INSERT INTO a VALUES ("a", "c"); -- É executado e adicionado a tabela

-----------------------------------------------------------------------------

-- Alterando informações de uma tabela

-- Se já tivermos dados em uma tabela e precisarmos renomear seu nome por exemplo
-- não é possivel dar drop e depois create na tabela, iria perder todos os dados
-- ali já existentes ai vem os comandos de ALTER TABLE:
-- Documentação dos ALTER TABLE
-- https://www.postgresql.org/docs/12/sql-altertable.html


-- Alterando o nome da tabela:

alter table a rename to teste; 

-- Alterando o nome de uma coluna:

alter table teste rename column coluna1 to primeira_coluna;
alter table teste rename column coluna2 to segunda_coluna;


-- Alterar o Schema de uma tabela:

alter table teste set schema teste;


-- Alterando Colunas da tabela:

-- Adicionando uma coluna nova:

alter table teste add terceira_coluna varchar(255);

-- Excluindo uma coluna:

alter table teste drop terceira_coluna;

-- Existe muitas ações que podemos alterar em uma tabela, na documentação tem tudo que é necessário
-- https://www.postgresql.org/docs/12/sql-altertable.html

-- Esses comandos que vimos, são comandos DDL (Data Definition Language), comandos que alteram a forma
-- do banco e suas tabelas com o CREATE, ALTER e DROP













