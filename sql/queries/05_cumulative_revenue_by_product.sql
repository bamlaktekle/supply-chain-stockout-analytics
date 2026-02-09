SELECT
  product_id,
  order_date,
  revenue,
  SUM(revenue) OVER (
    PARTITION BY product_id
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_revenue
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_sales`
ORDER BY product_id, order_date
LIMIT 200;
