SELECT
  product_id,
  warehouse_id,
  snapshot_date,
  stock_on_hand,
  AVG(stock_on_hand) OVER (
    PARTITION BY product_id, warehouse_id
    ORDER BY snapshot_date
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS avg_stock_last_7_days
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory`
ORDER BY product_id, warehouse_id, snapshot_date
LIMIT 200;
