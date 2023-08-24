-- Criando tabelas
CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
	primeiro_nome VARCHAR(255) NOT NULL,
	ultimo_nome VARCHAR(255) NOT NULL,
	data_nascimento DATE NOT NULL
);

CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE curso (
    id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	categoria_id INTEGER NOT NULL REFERENCES categoria(id)
);

CREATE TABLE aluno_curso (
	aluno_id INTEGER NOT NULL REFERENCES aluno(id),
	curso_id INTEGER NOT NULL REFERENCES curso(id),
	PRIMARY KEY (aluno_id, curso_id)
);

-----------------------------------------------------------------------------

-- Função para adicionar curso e se a categoria não existir cria a categoria

CREATE FUNCTION cria_curso(nome_curso VARCHAR, nome_categoria VARCHAR) RETURNS void AS $$ 
    DECLARE
        id_categoria INTEGER;
    BEGIN
        SELECT id INTO id_categoria FROM categoria WHERE nome = nome_categoria;

        IF NOT FOUND THEN
            INSERT INTO categoria (nome) VALUES (nome_categoria) RETURNING id INTO id_categoria;
        END if;

        INSERT INTO curso (nome, categoria_id) VALUES (nome_curso, id_categoria);    
    END
$$ LANGUAGE plpgsql;

SELECT cria_curso('PHP', 'Programação');
SELECT * FROM curso;

SELECT * FROM categoria;

SELECT cria_curso('Java', 'Programação');
SELECT * FROM curso;


-----------------------------------------------------------------------------

/*
* Inserir instrutores (com salários).
* Se o salário for maior do que a média, salvar um log
* Salvar outro log dizendo que fulano recebe mais do que x% da grade de instrutores. 
*/

CREATE TABLE log_instrutores (
    id SERIAL PRIMARY KEY,
    informacao VARCHAR(255),
    momento_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE FUNCTION cria_instrutor(nome_instrutor VARCHAR, salario_instrutor DECIMAL) RETURNS void AS $$ 
    DECLARE
        id_instrutor_inserido INTEGER;
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL;
    BEGIN
        INSERT INTO instrutor (nome, salario) VALUES (nome_instrutor, salario_instrutor) RETURNING id INTO id_instrutor_inserido;

        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> id_instrutor_inserido;

        IF salario_instrutor > media_salarial THEN
            INSERT INTO log_instrutores (informacao) VALUES (nome_instrutor || ' recebe acima da média');
        END IF;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> id_instrutor_inserido LOOP
            total_instrutores := total_instrutores + 1;

            IF salario_instrutor > salario THEN
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            END IF;    
        END LOOP;

        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;

        INSERT INTO log_instrutores (informacao) 
            VALUES (nome_instrutor || ' recebe mais do que ' || percentual || '% da grade de instrutores');
    END;
$$ LANGUAGE plpgsql


SELECT * FROM instrutor;

SELECT cria_instrutor('Fulano de tal', 1000);

SELECT * FROM log_instrutores;

SELECT cria_instrutor('Outro instrutora', 400);

SELECT * FROM log_instrutores;



