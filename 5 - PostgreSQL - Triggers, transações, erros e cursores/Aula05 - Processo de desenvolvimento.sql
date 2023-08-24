-- Blocos anônimos

-- o comando (DO) executa um bloco anônimo, que executa como se fosse o 
-- corpo de uma função e sempre retorna void

do $$
	declare
		cursor_salarios refcursor;
		salario decimal;
		total_instrutores integer default 0;
		instrutor_recebe_menos integer default 0;
		percentual decimal (5,2);
	begin
		SELECT instrutores_internos(12) INTO cursor_salarios; 
		loop
			FETCH cursor_salarios INTO salario;
			exit when not found;
			total_instrutores := total_instrutores + 1;
	
			IF 600::decimal > salario THEN
				instrutor_recebe_menos := instrutor_recebe_menos + 1;
			END IF;    
	 	END LOOP;
	 	percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;
	 
	 	raise notice 'Percentual: % %%', percentual;
	end
$$;