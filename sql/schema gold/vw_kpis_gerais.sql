CREATE OR REPLACE VIEW gold.vw_kpis_gerais AS
SELECT
    COUNT(*) AS total_envios,

    SUM(
        CASE
            WHEN entregas_atrasadas = TRUE THEN 1
            ELSE 0
        END
    ) AS total_atrasados,

    ROUND(
        (
            100.0 *
            SUM(
                CASE
                    WHEN entregas_atrasadas = TRUE THEN 1
                    ELSE 0
                END
            ) /
            COUNT(*)
        )::numeric,
        2
    ) AS taxa_atraso,

    ROUND(
        AVG(custo)::numeric,
        2
    ) AS custo_medio_envio,

    ROUND(
        AVG(
            CASE
                WHEN distancia_km > 0
                THEN custo / distancia_km
            END
        )::numeric,
        2
    ) AS custo_por_km

FROM gold.gold_entregas;


