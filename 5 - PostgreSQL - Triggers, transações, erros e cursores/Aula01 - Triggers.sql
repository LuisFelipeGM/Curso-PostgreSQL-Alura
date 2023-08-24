-- Triggers Procedure

-- Reescrevendo a função do curso passado para ser utilizado a Trigger

drop function cria_instrutor;

-- Quando utilizamos TRIGGERs não podemos ter passagem de parametro na função
-- então a forma da gente recolher as informações do objeto sendo passado é
-- atraves do (NEW.)

-- Função que retorna um trigger
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
    END;
$$ LANGUAGE plpgsql

-- Gerando o Trigger
create trigger cria_log_instrutores after insert on instrutor
	for each row execute function cria_instrutor();


select * from instrutor;

SELECT * FROM log_instrutores;


INSERT INTO instrutor (nome, salario) VALUES ('Jukes', 600);


