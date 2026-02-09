SELECT
  product_id,
  warehouse_id,
  snapshot_date,
  stock_on_hand,
  LAG(stock_on_hand) OVER (
    PARTITION BY product_id, warehouse_id
    ORDER BY snapshot_date
  ) AS prev_stock_on_hand,
  stock_on_hand
    - LAG(stock_on_hand) OVER (
        PARTITION BY product_id, warehouse_id
        ORDER BY snapshot_date
      ) AS stock_change
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory`
ORDER BY product_id, warehouse_id, snapshot_date
LIMIT 200;
