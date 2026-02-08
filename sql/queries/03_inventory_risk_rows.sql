SELECT
  product_id,
  COUNTIF(stock_on_hand < reorder_point) AS risk_days,
  COUNT(*) AS total_days,
  SAFE_DIVIDE(
    COUNTIF(stock_on_hand < reorder_point),
    COUNT(*)
  ) AS risk_rate
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory` 
GROUP BY product_id
ORDER BY risk_rate DESC
LIMIT 20;
