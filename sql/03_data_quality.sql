
-- =========================================
-- DATA QUALITY REPORT - RAW.DELIVERIES
-- =========================================
-- Objetivo: avaliar a qualidade dos dados
-- Principais verificações:
-- - Duplicidade
-- - Valores nulos
-- - Inconsistências categóricas
-- - Validação temporal

-- =========================
-- INFORMAÇÕES DAS COLUNAS
-- =========================

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'deliveries';

-- ===================================
-- VERIFICAR DUPLICADOS DE SHIPMENT_ID
-- ===================================

SELECT shipment_id, COUNT(*)
FROM raw.deliveries
GROUP BY shipment_id
HAVING COUNT(*) > 1;

-- =====================
-- VALORES NULOS 
-- =====================

SELECT
    COUNT(*) AS total_linhas,

    COUNT(*) FILTER (WHERE shipment_id IS NULL) AS nulos_shipment_id,
    COUNT(*) FILTER (WHERE shipment_date IS NULL) AS nulos_shipment_date,
    COUNT(*) FILTER (WHERE delivery_date IS NULL) AS nulos_delivery_date,
    COUNT(*) FILTER (WHERE cost IS NULL) AS nulos_cost,
    COUNT(*) FILTER (WHERE distance_miles IS NULL) AS nulos_distance,
    COUNT(*) FILTER (WHERE carrier IS NULL) AS nulos_carrier,

    COUNT(*) FILTER (WHERE shipment_id = '') AS vazios_shipment_id,
    COUNT(*) FILTER (WHERE carrier = '') AS vazios_carrier

FROM raw.deliveries;

-- PERCENTUAL DE NULOS

SELECT
    COUNT(*) AS total,

    ROUND(100.0 * COUNT(*) FILTER (WHERE shipment_id IS NULL) / COUNT(*), 2) AS pct_shipment_id_null,
    ROUND(100.0 * COUNT(*) FILTER (WHERE shipment_date IS NULL) / COUNT(*), 2) AS pct_shipment_date_null,
    ROUND(100.0 * COUNT(*) FILTER (WHERE delivery_date IS NULL) / COUNT(*), 2) AS pct_delivery_date_null,
    ROUND(100.0 * COUNT(*) FILTER (WHERE cost IS NULL) / COUNT(*), 2) AS pct_cost_null,
    ROUND(100.0 * COUNT(*) FILTER (WHERE distance_miles IS NULL) / COUNT(*), 2) AS pct_distance_null,
    ROUND(100.0 * COUNT(*) FILTER (WHERE carrier IS NULL) / COUNT(*), 2) AS pct_carrier_null

FROM raw.deliveries;

-- VERIFICAR NULOS EM COLUNAS CRÍTICAS

SELECT *
FROM raw.deliveries
WHERE shipment_id IS NULL
   OR shipment_date IS NULL
   OR delivery_date IS NULL
   OR cost IS NULL
   OR distance_miles IS NULL
   OR carrier IS NULL
ORDER BY shipment_id;

-- =====================
-- VALORES NEGATIVOS
-- =====================

SELECT
    COUNT(*) AS total,

    COUNT(*) FILTER (WHERE weight_kg < 0) AS neg_weight,
    COUNT(*) FILTER (WHERE cost < 0) AS neg_cost,
    COUNT(*) FILTER (WHERE distance_miles < 0) AS neg_distance,
    COUNT(*) FILTER (WHERE transit_days < 0) AS neg_transit,

    ROUND(100.0 * COUNT(*) FILTER (WHERE weight_kg < 0) / COUNT(*), 2) AS pct_weight,
    ROUND(100.0 * COUNT(*) FILTER (WHERE cost < 0) / COUNT(*), 2) AS pct_cost,
    ROUND(100.0 * COUNT(*) FILTER (WHERE distance_miles < 0) / COUNT(*), 2) AS pct_distance,
    ROUND(100.0 * COUNT(*) FILTER (WHERE transit_days < 0) / COUNT(*), 2) AS pct_transit

FROM raw.deliveries;

-- =================================
-- VERIFICAÇÃO DE INCONSISTÊNCIAS
-- =================================

SELECT status, COUNT(*)
FROM raw.deliveries
GROUP BY status
ORDER BY COUNT(*) DESC;

SELECT *
FROM raw.deliveries
WHERE TRIM(UPPER(carrier)) NOT IN (
    'DHL',
    'FEDEX',
    'UPS',
    'USPS',
    'ONTRAC',
    'LASERSHIP',
    'AMAZON LOGISTICS'
);

SELECT carrier, COUNT(*)
FROM raw.deliveries
GROUP BY carrier
ORDER BY carrier;


SELECT destination, COUNT(*)
FROM raw.deliveries
GROUP BY destination 
ORDER BY destination;

SELECT origin_warehouse, COUNT(*)
FROM raw.deliveries
GROUP BY origin_warehouse
ORDER BY origin_warehouse;

SELECT 
    status,
    TRIM(UPPER(status)) AS status_clean,
    COUNT(*)
FROM raw.deliveries
GROUP BY status, status_clean
ORDER BY status_clean;

-- =====================
-- DATAS INVÁLIDAS
-- =====================

SELECT 
  MIN(shipment_date) AS min_shipment,
  MAX(shipment_date) AS max_shipment,
  MIN(delivery_date) AS min_delivery,
  MAX(delivery_date) AS max_delivery
FROM raw.deliveries;

SELECT
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE delivery_date < shipment_date) AS datas_invalidas,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE delivery_date < shipment_date) / COUNT(*),
        2
       ) AS pct_datas_invalidas
FROM raw.deliveries;

SELECT shipment_date, delivery_date, transit_days 
FROM raw.deliveries
LIMIT 20;

SELECT *
FROM raw.deliveries
WHERE delivery_date < shipment_date;

SELECT *
FROM raw.deliveries
WHERE 
    delivery_date < shipment_date
    OR transit_days <> (delivery_date::date - shipment_date::date);

SELECT *,
(delivery_date - shipment_date) AS calc_days
FROM raw.deliveries;

SELECT *
FROM raw.deliveries
WHERE transit_days <> (delivery_date - shipment_date);

-- =====================================
-- REGISTROS VÁLIDOS PARA TRANSFORMAÇÃO
-- =====================================

SELECT *
FROM raw.deliveries
WHERE 
    shipment_id IS NOT NULL
    AND shipment_date IS NOT NULL
    AND delivery_date IS NOT NULL
    AND carrier IS NOT NULL;

-- Conclusão:
-- Dados prontos para transformação na camada silver

