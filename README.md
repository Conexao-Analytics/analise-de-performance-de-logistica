# Análise de Performance Logística: Pontualidade e Custo em Entregas

Projeto de análise de performance logística com foco em pontualidade das entregas e eficiência de custos, visando apoiar a tomada de decisão e identificar oportunidades de melhoria operacional.

## Contexto

A empresa tem recebido um aumento nas reclamações relacionadas à pontualidade das 
entregas. 
A área operacional indica que os prazos estão condizentes com a distância das rotas, mas 
destaca que os esforços para manter os níveis de serviço têm impactado diretamente o 
custo das operações, especialmente em rotas mais longas.

## Objetivo

Analisar a performance das entregas com foco em pontualidade e custo, a fim de: 
* Confirmar se as reclamações dos clientes possuem fundamento 
* Identificar as principais causas dos atrasos 
* Avaliar o comportamentos dos custos com as entregas

## Perguntas de negócio

* Qual a proporção de entregas atrasadas em relação ao total de envios? 
* Quais fatores estão mais associados aos atrasos (rota, transportadora, distância, 
peso)? 
* Existem rotas ou transportadoras com desempenho abaixo do esperado? 
* Como o custo se comporta em relação à distância, peso e transportadora? 
* Existem oportunidades de redução de custo sem impactar o nível de serviço?

## Dados

* **Dados Brutos**: [US Logistics Performance Dataset](https://www.kaggle.com/datasets/shahriarkabir/us-logistics-performance-dataset/code)
* **Origem**: Plataforma Kaggle  
* **Formato**: Arquivo CSV  
* **Tipo de dado**: informações sobre entregas de mercadorias

## Metodologia

O projeto segue as seguintes etapas:

- Tratamento e limpeza dos dados em SQL  
- Análise exploratória (EDA) em Python  
- Construção de indicadores de desempenho (KPIs)  
- Desenvolvimento de dashboard para visualização dos resultados  

## Limpeza e Tratamento

*Em desenvolvimento*

## Análise Exploratória dos Dados (EDA)

A análise exploratória teve como objetivo compreender o comportamento da operação logística, identificar padrões de atraso e avaliar a eficiência dos custos de transporte.

As principais etapas realizadas foram:

- Análise descritiva das variáveis de custo, peso, distância e tempo de trânsito;
- Criação de uma nova regra de negócio para classificação de atrasos baseada no histórico de cada rota;
- Avaliação da evolução temporal das entregas e da taxa de atraso;
- Comparação do desempenho entre transportadoras;
- Identificação das rotas com maiores taxas de atraso;
- Análise dos custos por quilômetro e por quilograma transportado;
- Aplicação do Wilson Score para aumentar a confiabilidade das comparações entre rotas e transportadoras;
- Consolidação dos principais insights e recomendações para a operação.

Os resultados da EDA serviram como base para a construção dos indicadores de desempenho (KPIs) e para o desenvolvimento do dashboard analítico.

## Dashboard

*Em desenvolvimento*

## Principais Insights

*Em desenvolvimento*

## Equipe

| Nome | Função no Projeto |
|-----|-----|
| Vanessa | Product Owner |
| Francielle| Analista de BI  |
| Tatiana | Engenheira de Dados|
| Ingrid | Analista de Dados |