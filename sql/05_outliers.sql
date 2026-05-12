
-- =========================================
-- ANÁLISE DE OUTLIERS - DATASET DELIVERIES
-- =========================================
-- Camada: Silver
--
-- Descrição:
-- Este script realiza:
-- - Cálculo de métricas estatísticas
-- - Identificação de outliers na variável dias_transito_real utilizando IQR
-- - Geração de flag de outliers para a variável dias_transito_real
-- - Quantificação de registros atípicos na variável dias_transito_real
--
-- Variáveis analisadas:
-- - dias_transito_real (principal)
-- - custo
-- - peso_kg
-- - distancia_km
--
-- =========================================


-- ===============================
-- MÉTRICAS dias_transito_real
-- ===============================

SELECT
    MIN(dias_transito_real) AS min,
    MAX(dias_transito_real) AS max,
    AVG(dias_transito_real) AS media,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY dias_transito_real) AS mediana,
    percentile_cont(0.25) WITHIN GROUP (ORDER BY dias_transito_real) AS q1,
    percentile_cont(0.75) WITHIN GROUP (ORDER BY dias_transito_real) AS q3
FROM silver.entregas_clean;

-- =====================================
-- OUTLIERS (IQR) - dias_transito_real
-- =====================================

WITH stats AS (
  SELECT
    percentile_cont(0.25) WITHIN GROUP (ORDER BY dias_transito_real) AS q1,
    percentile_cont(0.75) WITHIN GROUP (ORDER BY dias_transito_real) AS q3
  FROM silver.entregas_clean
)
SELECT *,
CASE 
  WHEN dias_transito_real < (q1 - 1.5 * (q3 - q1))
    OR dias_transito_real > (q3 + 1.5 * (q3 - q1))
  THEN 1 ELSE 0
END AS flag_outlier_dias
FROM silver.entregas_clean
CROSS JOIN stats;

-- ===========================================
-- QUANTIDADE DE OUTLIERS - dias_transito_real
-- ===========================================

WITH stats AS (
  SELECT
    percentile_cont(0.25) WITHIN GROUP (ORDER BY dias_transito_real) AS q1,
    percentile_cont(0.75) WITHIN GROUP (ORDER BY dias_transito_real) AS q3
  FROM silver.entregas_clean
)
SELECT
  COUNT(*) AS total,
  COUNT(*) FILTER (
    WHERE dias_transito_real < (q1 - 1.5 * (q3 - q1))
       OR dias_transito_real > (q3 + 1.5 * (q3 - q1))
  ) AS total_outliers,
  ROUND(
    (100.0 * COUNT(*) FILTER (
      WHERE dias_transito_real < (q1 - 1.5 * (q3 - q1))
         OR dias_transito_real > (q3 + 1.5 * (q3 - q1))
    ) / COUNT(*))::numeric,
    2
  ) AS pct_outliers
FROM silver.entregas_clean
CROSS JOIN stats;

-- =====================
-- MÉTRICAS  custo
-- =====================

SELECT
    MIN(custo) AS min,
    MAX(custo) AS max,
    AVG(custo) AS media,
    percentile_cont(0.25) WITHIN GROUP (ORDER BY custo) AS q1,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY custo) AS mediana,
    percentile_cont(0.75) WITHIN GROUP (ORDER BY custo) AS q3
FROM silver.entregas_clean;


-- =====================
-- MÉTRICAS peso_kg
-- =====================

SELECT
    MIN(peso_kg ) AS min,
    MAX(peso_kg ) AS max,
    AVG(peso_kg ) AS media,
    percentile_cont(0.25) WITHIN GROUP (ORDER BY peso_kg) AS q1,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY peso_kg) AS mediana,
    percentile_cont(0.75) WITHIN GROUP (ORDER BY peso_kg) AS q3
FROM silver.entregas_clean;

-- =========================
-- MÉTRICAS  distancia_km
-- =========================
SELECT
    MIN(distancia_km) AS min,
    MAX(distancia_km) AS max,
    AVG(distancia_km) AS media,
    percentile_cont(0.25) WITHIN GROUP (ORDER BY distancia_km) AS q1,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY distancia_km) AS mediana,
    percentile_cont(0.75) WITHIN GROUP (ORDER BY distancia_km) AS q3
FROM silver.entregas_clean;

