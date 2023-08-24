-- Retornos em PLpgSQL

-- Rescrevendo as funções criadas anteriormente

-- Quando o retorno é void não precisa adicionar retorno nenhum
CREATE OR REPLACE FUNCTION cria_a( nome VARCHAR) RETURNS void AS $$
    BEGIN
        INSERT INTO a(nome) VALUES('Patricia');
    END
$$ LANGUAGE plpgsql;

select cria_a('Vinicius Dias');

-- Retornando um tipo composto

-- Existe 2 possibilidades para retornar uma linha inteira, utilizando o 
-- return row e transformando o tipo do retorno em instrutor
-- ou criando uma variavel do tipo do instrutor e retornando ela:

-- 1 possibiilidade
CREATE OR REPLACE FUNCTION cria_instrutor_falso() RETURNS instrutor AS $$ 
    BEGIN
        RETURN ROW(22, 'Nome falso', 200::DECIMAL)::instrutor; 
    END
$$ LANGUAGE plpgsql;

-- 2 possibiilidade
CREATE OR REPLACE FUNCTION cria_instrutor_falso() RETURNS instrutor AS $$ 
    declare
    	retorno instrutor;
	BEGIN
        select 22, 'Nome falso', 200::DECIMAl into retorno; 
       return retorno;
    END
$$ LANGUAGE plpgsql;

select id, salario from cria_instrutor_falso(); 


-- Retornando mais de uma linha

-- Se quero retornar o resultado de uma Query inteira, é preciso apenas colocar
-- RETURN QUERY

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$
    BEGIN
        RETURN QUERY SELECT * FROM instrutor WHERE salario > valor_salario;
    END;
$$ LANGUAGE plpgsql;

select * from instrutores_bem_pagos(300);

-- retornando apenas o nome e o salario

create type nome_salario as (nome varchar, salario decimal);

drop function instrutores_bem_pagos;

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF nome_salario AS $$
    BEGIN
        RETURN QUERY SELECT nome, salario FROM instrutor WHERE salario > valor_salario;
    END;
$$ LANGUAGE plpgsql;

select nome, salario from instrutores_bem_pagos(300);


-----------------------------------------------------------------------------

-- If e Else

-- Quando utilizamos if e else é necessario no fim informar que o if acabou
-- utilizando o END IF

CREATE FUNCTION salario_ok (instrutor instrutor) RETURNS VARCHAR AS $$
    BEGIN 
        -- se o salário do instrutor for maior do que 200, está ok. Senão pode aumentar
        IF instrutor.salario > 200 THEN
            RETURN 'Salário está ok.';
        ELSE 
            RETURN 'Salário pode aumentar';
        END IF;
    END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor) FROM instrutor;

-- Inves de receber o instrutor, vamos receber o ID do instrutor para utilizar a 
-- função

DROP FUNCTION salario_ok;

CREATE FUNCTION salario_ok (id_instrutor INTEGER) RETURNS VARCHAR AS $$
    DECLARE
        instrutor instrutor;
    BEGIN 
        SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;

        -- se o salário do instrutor for maior do que 200, está ok. Senão pode aumentar
        IF instrutor.salario > 200 THEN
            RETURN 'Salário está ok.';
        ELSE 
            RETURN 'Salário pode aumentar';
        END IF;
    END;
$$ LANGUAGE plpgsql;


SELECT nome, salario_ok(instrutor.id) FROM instrutor;


-----------------------------------------------------------------------------

-- ElseIf

-- utilizado para realizar mais de uma verificação

DROP FUNCTION salario_ok;

CREATE OR REPLACE FUNCTION salario_ok (id_instrutor INTEGER) RETURNS VARCHAR AS $$
    DECLARE
        instrutor instrutor;
    BEGIN 
        SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;

        -- se o salário do instrutor for maior do que 300 reais, está ok. Se for 300 reais, então pode aumentar. Caso contrário, o salário está defasado.
        IF instrutor.salario > 300 THEN
            RETURN 'Salário está ok.';
        ELSEIF instrutor.salario = 300 THEN
            RETURN 'Salário pode aumentar';
        ELSE
            RETURN 'Salário está defasado';     
        END IF;
    END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;


-----------------------------------------------------------------------------

-- Case When (Switch case da programação)

-- É bom utilizar esse Case When quando temos muitos Ifs e Elses na tomada de decisão

CREATE OR REPLACE FUNCTION salario_ok (id_instrutor INTEGER) RETURNS VARCHAR AS $$
    DECLARE
        instrutor instrutor;
    BEGIN 
        SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;

        CASE
            WHEN instrutor.salario = 100 THEN
                RETURN 'Salário muito baixo';
            WHEN instrutor.salario = 200 THEN
                RETURN 'Salário baixo';
            WHEN instrutor.salario = 300 THEN
                RETURN 'Salário ok';
            ELSE
                RETURN 'Salário ótimo';
        END CASE;
    END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;


-- simplificando código acima:

CREATE OR REPLACE FUNCTION salario_ok (id_instrutor INTEGER) RETURNS VARCHAR AS $$
    DECLARE
        instrutor instrutor;
    BEGIN 
        SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;

        case instrutor.salario
            WHEN 100 THEN
                RETURN 'Salário muito baixo';
            WHEN 200 THEN
                RETURN 'Salário baixo';
            WHEN 300 THEN
                RETURN 'Salário ok';
            ELSE
                RETURN 'Salário ótimo';
        END CASE;
    END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;










