# supply-chain-stockout-analytics

Goal: Build a cloud-based analytics pipeline to predict stockouts and estimate lost revenue for a fictional retailer.

Stack: BigQuery, dbt, Python, Looker Studio.

## Week 1 Summary

Data:
- Generated synthetic retail supply chain data:
  - ~500 sales rows across 50 products and 3 customer segments
  - ~18,000 inventory snapshot rows across 4 warehouses over 90 days
  - 50 product–supplier lead time records

Key findings so far:
- Identified top 10 highest-risk SKUs by stockout frequency.
- Calculated 7-day potential lost revenue by product using sales joined to low-stock inventory.
- Built window-function queries to track stock level changes and cumulative revenue over time.

