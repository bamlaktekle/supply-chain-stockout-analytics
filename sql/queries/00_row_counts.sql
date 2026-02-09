SELECT 'raw_sales' AS table_name, COUNT(*) AS row_count
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_sales`
UNION ALL
SELECT 'raw_inventory', COUNT(*)
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_inventory`
UNION ALL
SELECT 'raw_lead_times', COUNT(*)
FROM `supply-chain-analytics-486803.supply_chain_raw.raw_lead_times`;
