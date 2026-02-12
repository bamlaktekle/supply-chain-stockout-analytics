CREATE OR REPLACE VIEW
  `supply-chain-analytics-486803.supply_chain_raw.vw_inventory_risk` AS

WITH daily_flags AS (
  SELECT
    product_id,
    warehouse_id,
    snapshot_date,
    stock_on_hand,
    reorder_point,
    safety_stock,
    CASE
      WHEN stock_on_hand < reorder_point THEN 1
      ELSE 0
    END AS is_below_reorder
  FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory`
)

SELECT
  product_id,
  warehouse_id,
  COUNT(*) AS total_days,
  SUM(is_below_reorder) AS risk_days,
  SAFE_DIVIDE(SUM(is_below_reorder), COUNT(*)) AS risk_rate
FROM daily_flags
GROUP BY product_id, warehouse_id;
