SELECT  
product_id,
  SUM(quantity_sold) AS total_units_sold,
  SUM(revenue)      AS total_revenue
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_sales`
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 20;
