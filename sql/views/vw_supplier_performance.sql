CREATE OR REPLACE VIEW
  `supply-chain-analytics-486803.supply_chain_raw.vw_supplier_performance` AS

SELECT
  supplier_id,
  COUNT(DISTINCT product_id) AS num_products,
  AVG(avg_lead_days)        AS avg_lead_days,
  AVG(reliability_score)    AS avg_reliability,
  AVG(cost_per_unit)        AS avg_cost_per_unit
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_lead_times`
GROUP BY supplier_id;
