-- Cursores

-- Temos que declarar os cursores no DECLARE, podemos criar o cursor e depois passar a query
-- para ele armazenar e podemos passar a query direto na hora da instancia

create or replace function instrutores_internos(id_instrutor integer) returns ??? $$
	declare 
		cursor_salarios refcursor 
	begin 
		open cursor_salarios for select instrutor.salario 
									FROM instrutor 
									WHERE id <> id_instrutor
									and salario > 0;
	end;
$$ plpgsql;


-----------------------------------------------------------------------------

-- Manipulando Cursores

-- fetch cursor_salarios into salario; -- atribui a linha atual na variavel	

create or replace function instrutores_internos(id_instrutor INTEGER) RETURNS refcursor AS $$
    DECLARE
        cursor_salario refcursor;
    BEGIN
        OPEN cursor_salario FOR SELECT instrutor.salario 
                                    FROM instrutor 
                                 WHERE id <> id_instrutor 
                                    AND salario > 0;                         
        RETURN cursor_salario;
    END;
$$ LANGUAGE plpgsql;


-----------------------------------------------------------------------------

-- Usando o cursor na trigger

create or replace FUNCTION cria_instrutor() RETURNS trigger AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
       cursor_salarios refcursor;
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> new.id;

	        IF new.salario > media_salarial THEN
	            INSERT INTO log_instrutores (informacao) VALUES (new.nome || ' recebe acima da média');
	        END IF;
	
	       SELECT instrutores_internos(NEW.id) INTO cursor_salarios; 
	       loop
		       	FETCH cursor_salarios INTO salario;
		      	exit when not found;
	            total_instrutores := total_instrutores + 1;
	
	            IF new.salario > salario THEN
	                instrutor_recebe_menos := instrutor_recebe_menos + 1;
	            END IF;    
	        END LOOP;
	
	        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;
	       	ASSERT percentual < 100::DECIMAL, 'Instrutores novos não podem receber mais do que todos os antigos';
	
	        INSERT INTO log_instrutores (informacao) 
	            VALUES (new.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores');   
        return new;
    END
$$ LANGUAGE plpgsql;


INSERT INTO instrutor (nome, salario) VALUES ('João', 6000);




