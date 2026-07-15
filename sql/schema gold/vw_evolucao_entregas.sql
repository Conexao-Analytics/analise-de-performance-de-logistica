CREATE OR REPLACE VIEW gold.vw_evolucao_entregas AS
SELECT
    DATE_TRUNC('month', data_entrega) AS mes,

    SUM(
        CASE
            WHEN entregas_atrasadas = TRUE THEN 1
            ELSE 0
        END
    ) AS entregas_atrasadas,

    SUM(
        CASE
            WHEN entregas_atrasadas = FALSE THEN 1
            ELSE 0
        END
    ) AS entregas_no_prazo

FROM gold.gold_entregas
WHERE data_entrega IS NOT NULL
GROUP BY 1
ORDER BY 1;