-- Estrutura PlpgSQL

-- Para criar uma função PLpgSQL é necessário definir a linguagem como
-- plpgsql, alem disso é necessario definir o bloco principal de código
-- definindo o BEGIN e o END;

create or replace function primeira_pl() returns integer as $$ 
	begin
		select 1;
	end
$$ language plpgsql;

select primeira_pl();

-- A função acima compila porem não executa, diferente da linguagem SQL
-- que retornava a ultima consulta, no plpgsql é necessario usar o return.

create or replace function primeira_pl() returns integer as $$ 
	begin
		-- Vários comando em SQL
		return 1;
	end
$$ language plpgsql;

select primeira_pl();


-----------------------------------------------------------------------------

-- Declarações de variáveis

-- Para a declaração de variáveis é necessário utilizar mais um bloco antes 
-- do BEGIN e END que vimos anteriormente chamado DECLARE, utilizado exclusivamente
-- para a declaração de variáveis, o diferente das linguagens de programação que o
-- sinal de atribuição é o =, aqui nós utilizamos o :=

create or replace function primeira_pl() returns integer as $$ 
	declare
		primeira_variavel integer default 3; -- declarando um tipo e valor inicial
	begin
		primeira_variavel := primeira_variavel * 2;
		return primeira_variavel;
	end
$$ language plpgsql;

select primeira_pl();

-- Na hora de atribuir valor a variavel no DECLARE é possivel utilizar o (default)
-- ou utilizar a atribuição (:=) ambos funcionam


-----------------------------------------------------------------------------

-- Blocos

-- É possível utilizar sub blocos dentro de um bloco plpgsql

create or replace function primeira_pl() returns integer as $$ 
	declare
		primeira_variavel integer default 3; 
	begin
		primeira_variavel := primeira_variavel * 2;
		
		declare
			primeira_variavel integer;
		begin
			primeira_variavel := 7;
		end;
		
		return primeira_variavel;
	end
$$ language plpgsql;

-- ao executar o bloco acima o valor do retorno será 6, pois no bloco interno
-- é declarado OUTRA variavel com o mesmo nome da anterior que é definida depois
-- com valor 7, porem quando é encerrado esse sub-bloco, essa outra variavel deixa
-- de existir logo o retorno será 6

-- Porém, quando excluimos o bloco declare e a criação desse outra variavel, o valor 7
-- é atribuido para a variavel declarada no bloco principal

create or replace function primeira_pl() returns integer as $$ 
	declare
		primeira_variavel integer default 3; 
	begin
		primeira_variavel := primeira_variavel * 2;
		
		begin
			primeira_variavel := 7;
		end;
		
		return primeira_variavel;
	end
$$ language plpgsql;

select primeira_pl();













