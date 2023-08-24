-- Begin de novo?

-- Colocando transações para que apenas insira no banco se os dois comandos
-- funcionem dessa forma utilizando o START TRANSACTION e COMMIT;

create or replace FUNCTION cria_instrutor() RETURNS trigger AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> new.id;

       start transaction;
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
	      	commit;    
        return new;
    END
$$ LANGUAGE plpgsql;

insert into instrutor (nome, salario) values ('Maria', 700);

-- Porem ao tentar inserir da um erro, NÃO PODEMOS FAZER TRANSAÇÕES DENTRO DE FUNÇÔES
-- Utilizamos apenas procedures 

-- Voltando a função para ficar sem transações
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
    END
$$ LANGUAGE plpgsql;

insert into instrutor (nome, salario) values ('Maria', 700);

-----------------------------------------------------------------------------

-- Praticando o Rollback;

begin;
insert into instrutor (nome, salario) values ('Luis', 700);
rollback;

-- Uma função roda na mesma transação do codigo que a chamou logo se dermos rollback
-- depois que utilizamos o gatilho para inserir na tabela de log, la tambem vai ser
-- dado o rollback

