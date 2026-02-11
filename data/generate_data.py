import pandas as pd
import numpy as np

np.random.seed(42)

# ---- Basic dimensions ----
num_products = 200
num_warehouses = 4
num_days = 90   # 3 months
num_suppliers = 10

products = [f"Widget-{i:02d}" for i in range(1, num_products + 1)]
warehouses = ["LA-West", "LA-East", "Chicago", "Dallas"]
suppliers = [f"Supplier-{i:02d}" for i in range(1, num_suppliers + 1)]
customer_segments = ["Enterprise", "SMB", "Consumer"]

dates = pd.date_range("2025-01-01", periods=num_days, freq="D")

# ---- Sales data (~500 rows) ----
num_sales = 500
sales = pd.DataFrame({
    "order_id": [f"O{i:04d}" for i in range(1, num_sales + 1)],
    "product_id": np.random.choice(products, num_sales),
    "order_date": np.random.choice(dates, num_sales),
    "quantity_sold": np.random.randint(1, 100, num_sales),
    "customer_segment": np.random.choice(customer_segments, num_sales)
})

# assume price between 10 and 200 per unit
price_lookup = {p: np.random.uniform(10, 200) for p in products}
sales["unit_price"] = sales["product_id"].map(price_lookup)
sales["revenue"] = (sales["quantity_sold"] * sales["unit_price"]).round(2)

sales = sales[[
    "order_id", "product_id", "order_date",
    "quantity_sold", "revenue", "customer_segment"
]]

# ---- Inventory snapshots (~50 products * 4 warehouses * 90 days) ----
rows = []
for p in products:
    base_stock = np.random.randint(200, 1000)
    for w in warehouses:
        stock = base_stock + np.random.randint(-50, 50)
        reorder_point = int(base_stock * 0.3)
        safety_stock = int(base_stock * 0.2)
        for d in dates:
            # random daily consumption
            change = np.random.randint(-30, 30)
            stock = max(stock + change, 0)
            rows.append([
                p, w, d.date(), stock,
                reorder_point, safety_stock
            ])

inventory = pd.DataFrame(
    rows,
    columns=[
        "product_id", "warehouse_id", "snapshot_date",
        "stock_on_hand", "reorder_point", "safety_stock"
    ]
)

# ---- Lead times (~100 rows) ----
lead_rows = []
for p in products:
    s = np.random.choice(suppliers)
    avg_lead = np.random.randint(3, 30)
    reliability = np.random.uniform(0.7, 0.99)
    cost = np.random.uniform(5, 80)
    lead_rows.append([p, s, avg_lead, round(reliability, 3), round(cost, 2)])

lead_times = pd.DataFrame(
    lead_rows,
    columns=[
        "product_id", "supplier_id", "avg_lead_days",
        "reliability_score", "cost_per_unit"
    ]
)

# ---- Save to CSV ----
sales.to_csv("data/raw_sales.csv", index=False)
inventory.to_csv("data/raw_inventory.csv", index=False)
lead_times.to_csv("data/raw_lead_times.csv", index=False)

print("Generated:")
print("  data/raw_sales.csv      ->", len(sales), "rows")
print("  data/raw_inventory.csv  ->", len(inventory), "rows")
print("  data/raw_lead_times.csv ->", len(lead_times), "rows")
