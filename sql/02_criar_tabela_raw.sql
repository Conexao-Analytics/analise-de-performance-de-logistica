-- =====================
-- CRIAR TABELA RAW
-- =====================
CREATE TABLE raw.deliveries (
    shipment_id TEXT,
    origin_warehouse TEXT,
    destination TEXT,
    carrier TEXT,
    shipment_date DATE,
    delivery_date DATE,
    weight_kg FLOAT,
    cost FLOAT,
    status TEXT,
    distance_miles FLOAT,
    transit_days INT
);