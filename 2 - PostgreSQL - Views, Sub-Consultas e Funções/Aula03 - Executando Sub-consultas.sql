-- Executandoo Sub-Consultas

select * from curso;
select * from categoria; 

select * from curso where categoria_id = 1 or categoria_id = 2; 

-- Uma forma de otimizar o codigo é usando o IN inves do OR nessa situação
-- dessa forma ele vai continuar pesquisando os cursos com categoria_id entre 1 e 2

select * from curso where categoria_id in(1, 2);

-- Se eu passasse apenas um numero dentro de IN seria a mesma coisa 
-- que perguntar sobre o id igual ao numero

-- TEM O MESMO RESULTADO
select * from curso where categoria_id = 3;

select * from curso where categoria_id in(3);

-----------------------------------------------------------------------------

-- Queries Aninhadas

-- Query para listar as categorias que o nome não tem espaço
select id from categoria where nome not like '% %';

-- Adicionando uma Query dentro do IN (Aninhando) - SUB QUERY
select curso.nome from curso where categoria_id IN(
	select id from categoria where nome not like '% %'
);


-----------------------------------------------------------------------------

-- Personalizando a tabela

-- É possivel utilizar uma Query como fosse uma tabela, se o resultado de uma Query
-- gera uma tabela, podemos usar ela como o FROM de uma outra Query

-- Pegando a quantidade de cursos que uma categoria possui
select ca.nome as categoria, count(c.id) as numero_cursos
	from categoria ca
	join curso c on c.categoria_id  = ca.id 
group by categoria;

-- adicionando a Query de cima como uma tabela nessa nova Query

select categoria, numero_cursos
	from(
		select ca.nome as categoria, count(c.id ) as numero_cursos
			from categoria ca
			join curso c on c.categoria_id  = ca.id 
		group by categoria
	) as categoria_cursos -- É necessário nomear a sub-query 
	where numero_cursos >= 3;
	
-- na maioria das ocasiões uma sub-query pode ser substituído pelo uso do HAVING.









