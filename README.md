# 📦 Sourcing Analysis Dashboard

This project analyzes software vendor spend and contract data using SQL and Power BI to uncover sourcing insights and support strategic procurement decisions.

## 📂 Project Overview

Organizations often face challenges managing software contracts across various vendors. This project was created to demonstrate how data analytics and visualization tools can streamline sourcing decisions, identify cost-saving opportunities, and monitor vendor performance over time.

---

## 🧮 SQL Analysis

SQL scripts were used to clean, aggregate, and analyze the underlying data, answering key questions such as:

- 💰 What is the total spend per vendor?
- 📅 How does spend trend over time?
- 🔁 What’s the difference between original contract costs vs. renewal costs?
- ✅ Which vendors are marked as preferred?

Sample SQL logic includes:

```sql
-- Example: Calculate total spend per vendor
SELECT vendor_id, SUM(amount_spent) AS total_spend
FROM spend_records
GROUP BY vendor_id;
