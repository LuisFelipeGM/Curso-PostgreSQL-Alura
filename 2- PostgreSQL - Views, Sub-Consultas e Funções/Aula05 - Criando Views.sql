-- Criando uma View

-- Uma view serve para guardar um select com um nome definido pela gente para
-- consultas mais faceis e tambem pode ser utilizada nas sub-querys

-- criando a view
create or replace view vw_cursos_por_categoria as select ca.nome as categoria,
		count(c.id) as numero_cursos
	from categoria ca
	join curso c on c.categoria_id = ca.id
group by categoria;

-- testando a view

select * from vw_cursos_por_categoria;

-- criando uma view que entregue todos os cursos da categoria de programação

create or replace view vw_cursos_programacao as
	select nome from curso where categoria_id = 2;
	
select * from vw_cursos_programacao;

-----------------------------------------------------------------------------

-- Trabalhando com as View

-- É possivel realizar o Join com uma view

select ca.id categoria_id, vw.* from vw_cursos_por_categoria vw
	join categoria ca on ca.nome = vw.categoria ;