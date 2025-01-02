# --- ANÁLISES DE DADOS COM SQL --- #

-- Agrupamentos
-- Filtragem em agrupamentos
-- Subqueries
-- Criação de Views

-- tabelas do banco de dados...

SELECT * FROM alugueis;
SELECT * FROM atores;
SELECT * FROM atuacoes;
SELECT * FROM clientes;
SELECT * FROM filmes;

-- CASE 1. Análise para descobrir o preço médio de aluguel dos filmes.

SELECT AVG(preco_aluguel) from filmes;


-- CASE 2. Qual é o preço médio para cada gênero de filme?

SELECT
	genero,
    ROUND(AVG(preco_aluguel), 2) as preco_medio,
    COUNT(*) as qtd_filmes
from filmes
group by genero;
	
    
-- CASE 3: Fazer a mesma análise, mas considerando apenas os filmes com ANO_LANCAMENTO igual a 2011.

SELECT
	genero,
    ROUND(AVG(preco_aluguel), 2) as preco_medio,
    COUNT(*) as qtd_filmes
from filmes
where ano_lancamento = 2011
group by genero; 	


-- CASE 4. Descobrir os gêneros e filmes mais populares.

-- Gêneros mais populares
SELECT genero, COUNT(*) AS total_alugueis
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY genero
ORDER BY total_alugueis DESC;

-- Filmes mais populares
SELECT titulo, COUNT(*) AS total_alugueis
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY titulo
ORDER BY total_alugueis DESC
LIMIT 10;


-- CASE 5. Qual é o perfil demográfico dos clientes por região?

SELECT regiao, sexo, COUNT(*) AS total_clientes
FROM clientes
GROUP BY regiao, sexo
ORDER BY regiao, total_clientes DESC;


-- CASE 6. Quais filmes e gêneros geram mais receita para direcionar futuras aquisições de conteúdo e promoções?

-- Receita por filme
SELECT titulo, SUM(preco_aluguel) AS receita_total
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY titulo
ORDER BY receita_total DESC;

-- Receita por gênero
SELECT genero, SUM(preco_aluguel) AS receita_total
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY genero
ORDER BY receita_total DESC;


-- CASE 7. Identificar os clientes mais frequentes e os que não alugam há muito tempo para criar estratégias de fidelização e reengajamento.

-- Clientes que mais alugam
SELECT nome_cliente, COUNT(*) AS total_alugueis
FROM clientes
JOIN alugueis ON clientes.id_cliente = alugueis.id_cliente
GROUP BY nome_cliente
ORDER BY total_alugueis DESC
LIMIT 10;

-- Clientes inativos há mais de 6 meses
SELECT nome_cliente, MAX(data_aluguel) AS ultima_locacao
FROM clientes
JOIN alugueis ON clientes.id_cliente = alugueis.id_cliente
GROUP BY nome_cliente
HAVING MAX(data_aluguel) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY ultima_locacao ASC;


-- CASE 8.  Fazer uma análise de desempenho dos alugueis. Para isso, uma análise comum é identificar quais aluguéis tiveram nota acima da média. 

SELECT AVG(nota) FROM alugueis;  -- 7.93

SELECT *
from alugueis
WHERE nota >= (SELECT AVG(nota) FROM alugueis);


-- CASE 9. Criar views.

CREATE VIEW resultado AS
SELECT
	genero,
	ROUND(AVG(preco_aluguel), 2) AS media_preco,
    COUNT(*) AS qtd_filmes
FROM filmes
GROUP BY genero;


CREATE VIEW preco_medio_filmes AS
SELECT AVG(preco_aluguel) from filmes;


CREATE VIEW genero_popular AS
SELECT genero, COUNT(*) AS total_alugueis
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY genero
ORDER BY total_alugueis DESC;


CREATE VIEW filme_popular AS
SELECT titulo, COUNT(*) AS total_alugueis
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY titulo
ORDER BY total_alugueis DESC
LIMIT 10;


CREATE VIEW perfil_demografico AS
SELECT regiao, sexo, COUNT(*) AS total_clientes
FROM clientes
GROUP BY regiao, sexo
ORDER BY regiao, total_clientes DESC;


CREATE VIEW receita_filme AS
SELECT titulo, SUM(preco_aluguel) AS receita_total
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY titulo
ORDER BY receita_total DESC;


CREATE VIEW receita_genero AS
SELECT genero, SUM(preco_aluguel) AS receita_total
FROM filmes
JOIN alugueis ON filmes.id_filme = alugueis.id_filme
GROUP BY genero
ORDER BY receita_total DESC;


CREATE VIEW maiores_clientes AS
SELECT nome_cliente, COUNT(*) AS total_alugueis
FROM clientes
JOIN alugueis ON clientes.id_cliente = alugueis.id_cliente
GROUP BY nome_cliente
ORDER BY total_alugueis DESC
LIMIT 10;


CREATE VIEW clientes_inativos_seis_meses AS
SELECT nome_cliente, MAX(data_aluguel) AS ultima_locacao
FROM clientes
JOIN alugueis ON clientes.id_cliente = alugueis.id_cliente
GROUP BY nome_cliente
HAVING MAX(data_aluguel) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY ultima_locacao ASC;


SELECT * FROM maiores_clientes;
DROP VIEW genero_popular;