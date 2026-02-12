CREATE OR REPLACE VIEW
  `supply-chain-analytics-486803.supply_chain_raw.vw_lost_revenue_estimates` AS

WITH inventory_risk_revenue AS (
  SELECT
    i.product_id,
    i.snapshot_date,
    SUM(
      CASE
        WHEN s.order_date BETWEEN DATE_SUB(i.snapshot_date, INTERVAL 7 DAY)
                             AND i.snapshot_date
        THEN s.revenue
        ELSE 0
      END
    ) AS recent_7d_revenue
  FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory` AS i
  LEFT JOIN `supply-chain-analytics-486803.supply_chain_raw.raw_sales` AS s
    ON i.product_id = s.product_id
  WHERE i.stock_on_hand < i.safety_stock
  GROUP BY i.product_id, i.snapshot_date
)

SELECT
  product_id,
  SUM(recent_7d_revenue) AS potential_lost_revenue
FROM inventory_risk_revenue
GROUP BY product_id;
