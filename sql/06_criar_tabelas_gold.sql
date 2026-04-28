
-- =========================================
-- KPIs GERAIS - PERFORMANCE LOGÍSTICA
-- =========================================

CREATE TABLE gold.kpis_gerais AS
SELECT
    -- volume
    COUNT(*) AS total_envios,

    -- atrasos
    COUNT(*) FILTER (WHERE status = 'DELAYED') AS total_atrasos,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (WHERE status = 'DELAYED')
            / COUNT(*)
        )::numeric,
        2
    ) AS pct_atrasos,

    -- tempo
    ROUND(AVG(dias_transito_real)::numeric, 2) AS tempo_medio_transporte,

    MIN(dias_transito_real) AS menor_tempo_entrega,
    MAX(dias_transito_real) AS maior_tempo_entrega,

    -- custo
    ROUND(AVG(custo)::numeric, 2) AS custo_medio_envio,

    ROUND(SUM(custo)::numeric, 2) AS custo_total,

    -- distância
    ROUND(AVG(distancia_km)::numeric, 2) AS distancia_media_entregas,

    -- custo por km
    ROUND(
        (SUM(custo) / SUM(distancia_km))::numeric,
        2
    ) AS custo_por_km

FROM silver.entregas_clean;


-- ==================================================
-- PERFORMANCE POR TRANSPORTADORA
-- ==================================================

CREATE TABLE gold.performance_transportadora AS
SELECT
    transportadora,

    -- volume operacional
    COUNT(*) AS total_envios,

    -- atrasos
    COUNT(*) FILTER (WHERE status = 'DELAYED') AS total_atrasos,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (WHERE status = 'DELAYED')
            / COUNT(*)
        )::numeric,
        2
    ) AS taxa_atraso,

    -- tempo
    ROUND(AVG(dias_transito_real)::numeric, 2) AS tempo_medio_transporte,

    MIN(dias_transito_real) AS menor_tempo_entrega,
    MAX(dias_transito_real) AS maior_tempo_entrega,

    -- custos
    ROUND(AVG(custo)::numeric, 2) AS custo_medio_envio,

    ROUND(SUM(custo)::numeric, 2) AS custo_total,

    -- distância
    ROUND(AVG(distancia_km)::numeric, 2) AS distancia_media,

    -- eficiência
    ROUND(
        (SUM(custo) / SUM(distancia_km))::numeric,
        2
    ) AS custo_por_km

FROM silver.entregas_clean
GROUP BY transportadora
ORDER BY taxa_atraso DESC;


-- ==========================================
-- PERFORMANCE POR ROTA
-- ==========================================

CREATE TABLE gold.performance_rota AS
SELECT
    armazem_origem || ' -> ' || destino AS rota,

    -- volume operacional
    COUNT(*) AS total_envios,

    -- atrasos
    COUNT(*) FILTER (WHERE status = 'DELAYED') AS total_atrasos,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (WHERE status = 'DELAYED')
            / COUNT(*)
        )::numeric,
        2
    ) AS taxa_atraso,

    -- tempo
    ROUND(AVG(dias_transito_real)::numeric, 2) AS tempo_medio_transporte,

    MIN(dias_transito_real) AS menor_tempo_entrega,
    MAX(dias_transito_real) AS maior_tempo_entrega,

    -- custos
    ROUND(AVG(custo)::numeric, 2) AS custo_medio_envio,

    ROUND(SUM(custo)::numeric, 2) AS custo_total,

    -- distância
    ROUND(AVG(distancia_km)::numeric, 2) AS distancia_media,

    -- eficiência
    ROUND(
        (SUM(custo) / SUM(distancia_km))::numeric,
        2
    ) AS custo_por_km

FROM silver.entregas_clean
GROUP BY rota
ORDER BY taxa_atraso DESC;

-- ==========================================
-- ANÁLISE DE CUSTOS
-- ==========================================

CREATE TABLE gold.analise_custos AS
SELECT
    transportadora,

    -- volume operacional
    COUNT(*) AS total_envios,

    -- custos
    ROUND(AVG(custo)::numeric, 2) AS custo_medio_envio,

    ROUND(SUM(custo)::numeric, 2) AS custo_total,

    -- distância
    ROUND(AVG(distancia_km)::numeric, 2) AS distancia_media,

    -- peso
    ROUND(AVG(peso_kg)::numeric, 2) AS peso_medio,

    -- eficiência custo x distância
    ROUND(
        (SUM(custo) / SUM(distancia_km))::numeric,
        2
    ) AS custo_por_km,

    -- eficiência custo x peso
    ROUND(
        (SUM(custo) / SUM(peso_kg))::numeric,
        2
    ) AS custo_por_kg

FROM silver.entregas_clean
GROUP BY transportadora
ORDER BY custo_por_km DESC;