-- Erros e Exceções

-- É possivel capturar erros atraves do EXCEPTION depois do BEGIN

create or replace FUNCTION cria_instrutor() RETURNS trigger AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> new.id;

	        IF new.salario > media_salarial THEN
	            INSERT INTO log_instrutores (informacao) VALUES (new.nome || ' recebe acima da média');
	        END IF;
	
	        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> new.id LOOP
	            total_instrutores := total_instrutores + 1;
	
	            IF new.salario > salario THEN
	                instrutor_recebe_menos := instrutor_recebe_menos + 1;
	            END IF;    
	        END LOOP;
	
	        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;
	
	        INSERT INTO log_instrutores (informacao) 
	            VALUES (new.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores');   
        return new;
    
    exception
    	when undefined_column then
    	return new;
    END
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------------

-- Exibindo Mensagens

-- A palavra usada para levantar um erro ou uma mensagem é o (RAISE), a primeira coisa 
-- precisamos definir o nivel de erro, se é um debug, log, warning, por padrão ele adota
-- o EXCEPTION

create or replace FUNCTION cria_instrutor() RETURNS trigger AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> new.id;

	        IF new.salario > media_salarial THEN
	            INSERT INTO log_instrutores (informacao) VALUES (new.nome || ' recebe acima da média');
	        END IF;
	
	        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> new.id LOOP
	            total_instrutores := total_instrutores + 1;
	
	            IF new.salario > salario THEN
	                instrutor_recebe_menos := instrutor_recebe_menos + 1;
	            END IF;    
	        END LOOP;
	
	        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;
	
	        INSERT INTO log_instrutores (informacao, teste) 
	            VALUES (new.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores');   
        return new;
    
    exception
    	when undefined_column then
	    	raise notice 'Algo de errado não está certo';
	    	raise exception 'Erro complicado de resolver';
	    when raise_exception then
	    -- É possivel pegar uma exceção que eu mesmo criei
    END
$$ LANGUAGE plpgsql;

-- Caso tenhamos um RAISE EXCEPTION toda a transação da rollback

INSERT INTO instrutor (nome, salario) VALUES ('Pijack', 5000);

select * from instrutor;

select * from log_instrutores;


-----------------------------------------------------------------------------

-- Verificando condições

-- cancelar a inserção de um instrutor caso ele receba mais que todo mundo

create or replace FUNCTION cria_instrutor() RETURNS trigger AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> new.id;

	        IF new.salario > media_salarial THEN
	            INSERT INTO log_instrutores (informacao) VALUES (new.nome || ' recebe acima da média');
	        END IF;
	
	        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> new.id LOOP
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

-- criando a trigger para ativar ANTES do insert

create trigger cria_log_instrutores before insert on instrutor
	for each row execute function cria_instrutor();

INSERT INTO instrutor (nome, salario) VALUES ('Pijack', 6000);
