
DROP TABLE IF EXISTS silver.entregas_clean;

-- =====================
-- CRIAR TABELA SILVER
-- =====================

CREATE TABLE silver.entregas_clean AS
SELECT
    shipment_id AS id_envio,
    origin_warehouse AS armazem_origem,
    destination AS destino,

    TRIM(UPPER(carrier)) AS transportadora,
    TRIM(UPPER(status)) AS status,

    shipment_date AS data_envio,
    delivery_date AS data_entrega,

    weight_kg AS peso_kg,
    cost AS custo,

    distance_miles AS distancia_milhas,

    ROUND((distance_miles * 1.60934)::numeric, 2) AS distancia_km,

    transit_days AS dias_transito_original,

    (delivery_date - shipment_date) AS dias_transito_real

FROM raw.deliveries
WHERE 
    shipment_id IS NOT NULL

    -- Remove registros onde delivery_date e cost são nulos ao mesmo tempo
    AND NOT (
        delivery_date IS NULL
        AND cost IS NULL
    )

    -- Permite cost nulo, mas não valores negativos
    AND (
        cost >= 0
        OR cost IS NULL
    )

    -- Transportadora obrigatória
    AND carrier IS NOT NULL

    -- Permite datas nulas, mas remove datas invertidas
    AND (
        delivery_date >= shipment_date
        OR delivery_date IS NULL
        OR shipment_date IS NULL
    )

    -- Permite peso nulo, mas não negativo
    AND (
        weight_kg >= 0
        OR weight_kg IS NULL
    )

    -- Permite distância nula, mas não negativa
    AND (
        distance_miles >= 0
        OR distance_miles IS NULL
    );