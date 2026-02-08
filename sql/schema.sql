-- Raw sales data
CREATE TABLE raw_sales (
  order_id STRING,
  product_id STRING,
  order_date DATE,
  quantity_sold INT64,
  revenue NUMERIC,
  customer_segment STRING
);

-- Daily inventory snapshots
CREATE TABLE raw_inventory (
  product_id STRING,
  warehouse_id STRING,
  snapshot_date DATE,
  stock_on_hand INT64,
  reorder_point INT64,
  safety_stock INT64
);

-- Supplier lead times
CREATE TABLE raw_lead_times (
  product_id STRING,
  supplier_id STRING,
  avg_lead_days INT64,
  reliability_score FLOAT64,
  cost_per_unit NUMERIC
);
