WITH inventory_risk AS (
  SELECT
    product_id,
    snapshot_date,
    stock_on_hand,
    safety_stock
  FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory`
  WHERE stock_on_hand < safety_stock
),
recent_sales AS (
  SELECT
    product_id,
    order_date,
    revenue
  FROM `supply-chain-analytics-486803.supply_chain_raw.raw_sales`
)

SELECT
  i.product_id,
  i.snapshot_date,
  i.stock_on_hand,
  i.safety_stock,
  SUM(
    CASE
      WHEN s.order_date BETWEEN DATE_SUB(i.snapshot_date, INTERVAL 7 DAY)
                           AND i.snapshot_date
      THEN s.revenue
      ELSE 0
    END
  ) AS recent_7d_revenue
FROM inventory_risk i
LEFT JOIN recent_sales s
  ON i.product_id = s.product_id
GROUP BY
  i.product_id,
  i.snapshot_date,
  i.stock_on_hand,
  i.safety_stock
ORDER BY recent_7d_revenue DESC
LIMIT 100;
