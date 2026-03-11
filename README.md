# Supply Chain Stockout Analytics

## 1. Business Problem

Retailers and distributors lose money when popular products go out of stock or sit in the wrong warehouses.  
The goal of this project is to **identify which products and warehouses are riskiest, estimate the revenue at risk from stockouts, and evaluate supplier performance**, using an analytics-engineering style pipeline.

This is a simulated but realistic analytics project designed to showcase data analytics and analytics engineering skills for roles like Data Analyst, Analytics Engineer, and Data/Cloud SWE.

---

## 2. Data & Modeling

### Synthetic Dataset

All data is generated with Python to resemble a mid‑size retailer:

- **Sales**
  - ~500 sales transactions
  - ~200 SKUs (`Widget-001` …) across multiple customer segments
  - Fields: `order_id`, `product_id`, `order_date`, `quantity_sold`, `revenue`, `customer_segment`
- **Inventory**
  - Daily inventory snapshots over 90 days
  - 4 warehouses (e.g., LA-West, LA-East, Chicago, Dallas)
  - Fields: `product_id`, `warehouse_id`, `snapshot_date`, `stock_on_hand`, `reorder_point`, `safety_stock`
- **Lead times / suppliers**
  - ~200 product–supplier relationships
  - Fields: `product_id`, `supplier_id`, `avg_lead_days`, `reliability_score`, `cost_per_unit`

### BigQuery Tables

Raw data is stored in Google BigQuery:

- `raw_sales`
- `raw_inventory`
- `raw_lead_times`

### Analytics Views (Model Layer)

Analytics-ready views are built on top of the raw tables:

- `vw_inventory_risk`  
  Product/warehouse‑level **stockout risk scores**  
  - `risk_days`, `total_days`, `risk_rate` per `(product_id, warehouse_id)`
- `vw_lost_revenue_estimates`  
  Product‑level **potential lost revenue**, approximated by joining low‑stock inventory snapshots to trailing 7‑day sales
- `vw_supplier_performance`  
  Supplier‑level **reliability and cost metrics**  
  - `num_products`, `avg_lead_days`, `avg_reliability`, `avg_cost_per_unit` per `supplier_id`

These views are the primary sources used by Looker Studio.

---

## 3. Architecture

High‑level pipeline:

1. **Data generation (Python)**
   - `generate_data.py` creates `raw_sales.csv`, `raw_inventory.csv`, and `raw_lead_times.csv`.
2. **Ingestion (BigQuery)**
   - CSVs are loaded into `supply_chain_raw.raw_*` tables.
3. **Modeling (BigQuery SQL)**
   - `CREATE OR REPLACE VIEW` statements define `vw_inventory_risk`, `vw_lost_revenue_estimates`, and `vw_supplier_performance`.
4. **Visualization (Looker Studio)**
   - Looker Studio connects directly to the `vw_*` views for live dashboards.

Text diagram:

```text
Python (generate_data.py)
        ↓
CSV files (sales, inventory, lead_times)
        ↓
BigQuery raw tables (raw_sales, raw_inventory, raw_lead_times)
        ↓
BigQuery views (vw_inventory_risk, vw_lost_revenue_estimates, vw_supplier_performance)
        ↓
Looker Studio dashboards (Overview, Product Risk, Supplier Performance)

## 4. Tech Stack
Python – pandas, NumPy for synthetic data generation

Google BigQuery – cloud data warehouse, SQL analytics

BigQuery Views – lightweight modeling / analytics engineering layer

Looker Studio – interactive dashboards and stakeholder‑friendly visuals

Git + GitHub – version control for SQL, Python, and documentation

--- 

## 5. Dashboards

## Overview
Answers: “Which products and warehouses are riskiest, and where is the revenue risk?”

- KPI cards summarizing:
- Total risk_days across all product/warehouse pairs
- Average risk_rate
- Table of highest‑risk (product_id, warehouse_id) combinations
- Table of products with the highest potential lost revenue (vw_lost_revenue_estimates)
- Controls to filter by product_id and warehouse_id

## Product Risk 
Answers: “Which SKUs drive most stockout risk and revenue exposure?”

- Table of SKUs with:
- risk_days, risk_rate
- Bar chart of top products by potential_lost_revenue
- Filters to focus on specific SKUs or warehouses

## Supplier Performance
Answers: “How do suppliers trade off cost vs reliability?”

- Table of suppliers with:
  - num_products, avg_lead_days, avg_reliability, avg_cost_per_unit

- Bubble (scatter) chart:

  - X‑axis: avg_cost_per_unit
  - Y‑axis: avg_reliability
  - Bubble size: num_products