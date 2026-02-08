SELECT  
  product_id,
  warehouse_id,
  snapshot_date,
  stock_on_hand,
  reorder_point,
  safety_stock,
  CASE
    WHEN stock_on_hand < reorder_point THEN 'AT_RISK'
    ELSE 'OK'
  END AS stock_status
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory` 
WHERE stock_on_hand < safety_stock * 1.2
ORDER BY snapshot_date DESC
LIMIT 50;


