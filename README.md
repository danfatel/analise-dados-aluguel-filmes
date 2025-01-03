<div align='center'>
<img src="https://www.jornalopcao.com.br/wp-content/uploads/2017/12/IMG_6916-620x350.jpg" width="100%"/>
</div>

&nbsp;

Este projeto faz parte de uma iniciativa de **Análise de Dados com SQL**, aplicando conceitos fundamentais para explorar e extrair insights de um banco de dados de aluguel de filmes. A ideia inicial partiu de um vídeo do canal Hashtag Treinamentos. Link: https://youtu.be/hprufLQkS2M?si=HUxkbghY2DpwfV9v.

## Introdução

Com o crescente interesse em serviços de streaming e locadoras digitais, a compreensão do comportamento do cliente e a análise de dados são essenciais para a tomada de decisão. Este projeto utiliza um banco de dados fictício que reflete a operação de uma locadora de filmes, com informações sobre clientes, filmes, gêneros e alugueis.

Através de consultas SQL, buscamos responder perguntas-chave para o negócio, como:

- Quais são os gêneros mais populares?
- Qual é o preço médio de aluguel dos filmes?
- Como o desempenho varia entre filmes de diferentes gêneros e lançamentos?

## Problema

O objetivo principal é realizar uma análise detalhada do banco de dados para fornecer insights que possam auxiliar no planejamento estratégico da empresa fictícia.

Os desafios incluem:

- Analisar os preços e tendências de aluguel.
- Identificar gêneros e filmes mais populares.
- Trabalhar com filtros e agrupamentos complexos.

## Conjunto de Dados

O banco de dados utilizado está estruturado em tabelas inter-relacionadas, representando clientes, filmes, alugueis e outros aspectos. As tabelas principais incluem:

### Tabela: Filmes

| Coluna          | Descrição                  |
|------------------|------------------------------|
| `id_filme`      | Identificador único do filme |
| `titulo`        | Título do filme             |
| `genero`        | Gênero do filme            |
| `preco_aluguel` | Preço de aluguel (em USD)  |
| `ano_lancamento`| Ano de lançamento          |

### Tabela: Alugueis

| Coluna         | Descrição                  |
|-----------------|------------------------------|
| `id_aluguel`   | Identificador único do aluguel |
| `id_filme`     | Identificador do filme alugado|
| `id_cliente`   | Identificador do cliente      |
| `data_aluguel` | Data do aluguel               |

### Diagrama de Relacionamento

<div align='center'>
<img src="https://github.com/danfatel/analise-dados-aluguel-filmes/blob/main/Diagrama.jpeg" width="100%"/>
</div>

&nbsp;

## Análises Realizadas

### A - Preços e Tendências

**Questões investigadas:**

1. Qual é o preço médio de aluguel dos filmes?
   ```sql
   SELECT AVG(preco_aluguel) AS preco_medio FROM filmes;
   ```

2. Qual é o preço médio para cada gênero?
   ```sql
   SELECT genero, ROUND(AVG(preco_aluguel), 2) AS preco_medio FROM filmes GROUP BY genero;
   ```

3. Qual é o preço médio por gênero para filmes de 2011?
   ```sql
   SELECT genero, ROUND(AVG(preco_aluguel), 2) AS preco_medio FROM filmes WHERE ano_lancamento = 2011 GROUP BY genero;
   ```

### B - Popularidade

**Questões investigadas:**

1. Quais são os gêneros mais alugados?
   ```sql
   SELECT genero, COUNT(*) AS total_alugueis FROM filmes JOIN alugueis ON filmes.id_filme = alugueis.id_filme GROUP BY genero ORDER BY total_alugueis DESC;
   ```

2. Quais são os filmes mais populares?
   ```sql
   SELECT titulo, COUNT(*) AS total_alugueis FROM filmes JOIN alugueis ON filmes.id_filme = alugueis.id_filme GROUP BY titulo ORDER BY total_alugueis DESC;
   ```

### C - Experiência do Cliente

- Análise de histórico de alugueis por cliente.
- Identificação de tendências e comportamento de consumo.

## Scripts

Todos os scripts utilizados estão organizados no arquivo [`Projeto Análise de Dados Aluguel de Filmes SQL.sql`](./Projeto%20An%C3%A1lise%20de%20Dados%20Aluguel%20de%20Filmes%20SQL.sql).

## Relatório

Os resultados das análises incluem:

- O preço médio geral de aluguel é **R$2.20**.
- Os gêneros mais populares são **Drama**, **Ficção e Fantasia** e **Comédia**.
- O filme mais alugado foi "**O Reino**" com **15** alugueis.

## Conclusão

Este projeto demonstra como consultas SQL podem ser utilizadas para explorar e extrair insights valiosos de dados. As análises realizadas fornecem suporte para decisões estratégicas em um cenário de negócio fictício.

Para mais detalhes, acesse o arquivo de scripts ou entre em contato!

<div align='center'>
<img src="https://via.placeholder.com/100x100" width="10%"/>
</div>
```

