-- Return next

-- O return next permite realizar varios retornos quando não temos
-- uma query para isso

-- criando uma função que retorna uma tabuada

create or replace function tabuada(numero integer) returns setof integer as $$
	declare
	begin
		return next numero * 1;
		return next numero * 2;
		return next numero * 3;
		return next numero * 4;
		return next numero * 5;
		return next numero * 6;
		return next numero * 7;
		return next numero * 8;
		return next numero * 9;
		return next numero * 10;
	end
$$ language plpgsql;

select tabuada(2);


-----------------------------------------------------------------------------

-- Conhecendo Loop

-- O Loop padrão do PLpgSQL é o LOOP, ele tem a seguinte estrutura:
-- (LOOP) (EXIT WHEN) (END LOOP), sendo que EXIT WHEN é a condição para
-- finalizar a execução do LOOP

create or replace function tabuada(numero integer) returns setof integer as $$
	declare
		multiplicador integer default 1;
	begin
		loop
			return next numero * multiplicador;
			multiplicador := multiplicador + 1;
			exit when multiplicador = 11;
		end loop; 
	end
$$ language plpgsql;

select tabuada(14);

-- Formatar a tabuada

drop function tabuada;

create or replace function tabuada(numero integer) returns setof varchar as $$
	declare
		multiplicador integer default 1;
	begin
		loop
			return next numero || ' X ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador + 1;
			exit when multiplicador = 11;
		end loop; 
	end
$$ language plpgsql;

select tabuada(14);


-----------------------------------------------------------------------------

-- While

-- criando a função de tabuada com o laço while

create or replace function tabuada(numero integer) returns setof varchar as $$
	declare
		multiplicador integer default 1;
	begin
		while multiplicador < 11 loop
			return next numero || ' X ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador + 1;
		end loop;
	end
$$ language plpgsql;

select tabuada(9);

-----------------------------------------------------------------------------

-- For

-- normalmente utilizado para quando sabemos a quantidade de vez é para o loop ser
-- executado, como no for estou definindo o numero de vezes que precisa executar
-- não é necessário o incremento, e o for cria a variavel de controle logo não
-- é necessário criar uma variável no declare (código bem menor)

create or replace function tabuada(numero integer) returns setof varchar as $$begin
		for multiplicador in 1..10 loop
			return next numero || ' X ' || multiplicador || ' = ' || numero * multiplicador;
		end loop;
	end
$$ language plpgsql;

select tabuada(9);

-- É possivel utilizar o Loop em uma Query


create or replace function instrutor_com_salario(out nome varchar, out salario_ok varchar) returns setof record as $$
	declare 
		instrutor instrutor;
	begin 
		for instrutor in select * from instrutor loop
			nome := instrutor.nome;
			salario_ok := salario_ok(instrutor.id);
			return next;
		end loop;
		
	end
$$ language plpgsql;

select * from instrutor_com_salario();











