
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
    AND shipment_date IS NOT NULL
    AND delivery_date IS NOT NULL
    AND carrier IS NOT NULL
    AND delivery_date >= shipment_date
    AND weight_kg >= 0
    AND cost >= 0
    AND distance_miles >= 0;