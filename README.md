
# 🌍 SQL Reference Guide — Policy & Social Analysis

**Author:** Tea Tafaj  
**Program:** Duke University – MIDS 2025  
**Date:** October 19, 2025  
**Datasets:** Suicide Rates (Kaggle) + World Happiness Report  

---

## 📚 Table of Contents

1. [Project Overview](#project-overview)
2. [01_setup_joins.sql — Data Loading & Cleaning](#01_setup_joinssql--data-loading--cleaning)
3. [02_basics.sql — Core SQL Operations](#02_basicssql--core-sql-operations)
4. [03_aggregate.sql — Aggregate Functions](#03_aggregatesql--aggregate-functions)
5. [06_case_when_transform.sql — Data Transformation](#06_case_when_transformsql--data-transformation)
6. [08_windows.sql — Window Functions](#08_windowssql--window-functions)
7. [09_CTE.sql — Common Table Expressions](#09_ctesql--common-table-expressions)
8. [10_independent.sql — EXCEPT Feature](#10_independentsql--except-feature)
9. [11_independent_union.sql — UNION Feature](#11_independent_unionsql--union-feature)
10. [Summary of Key Learnings](#summary-of-key-learnings)

---

## 🧭 Project Overview

This project integrates two social datasets — the **Kaggle Suicide Rates dataset** and the **World Happiness Report** — to analyze global well-being trends through SQL.  
The goal was to **build a reusable SQL reference guide** showcasing both foundational and advanced database skills, while asking meaningful social-policy questions.

---

## 🧱 01_setup_joins.sql — Data Loading & Cleaning

**Question:** How can we integrate two datasets (suicide rates and happiness indicators) into a consistent, query-ready database?  

**Explanation:**  
This step imported the two raw datasets (`raw_suicides` and `raw_happiness`) into SQLite, ensuring that both were aligned by **country and year**.  
We then created `v_policy_clean`, a **joined view** that aggregated data across age and sex to one observation per country-year, removing mismatched entries.  

**Why it matters:** This ensures that all further analysis uses **clean, consistent data**, avoiding duplication or null mismatches.

📁 *See file: `01_setup_joins.sql`*

---

## ⚙️ 02_basics.sql — Core SQL Operations

**Question:** Which countries had the highest average suicide rates between 2010–2020?  

**Explanation:**  
Demonstrates SQL basics: `SELECT`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, and `LIMIT`.  
We filtered valid observations, calculated each country’s mean suicide rate, and ranked them to identify outliers and trends.  

**Why it matters:** These core operations are essential for **exploratory data analysis** and aggregating policy metrics.

📁 *See file: `02_basics.sql`*

---

## 📊 03_aggregate.sql — Aggregate Functions

**Question:** How do global suicide and happiness levels change over time?  

**Explanation:**  
We applied aggregation functions like `AVG()`, `MIN()`, `MAX()`, and `COUNT()` by year. This allowed us to track longitudinal changes across the world.  
It shows trends such as whether GDP per capita or happiness levels correlate with suicide rate fluctuations.  

**Why it matters:** Aggregate analysis is key to understanding **macro-level social patterns**.

📁 *See file: `03_aggregate.sql`*

---

## 🧩 06_case_when_transform.sql — Data Transformation

**Question:** How can we classify countries by economic tiers and compare their suicide rates?  

**Explanation:**  
Used `CASE WHEN` to categorize GDP per capita into four income groups (Low, Lower-Middle, Upper-Middle, High).  
Then compared average suicide rates per tier to explore relationships between wealth and well-being.  

**Why it matters:** Demonstrates **data transformation** and feature engineering — grouping continuous values into analytical categories.

📁 *See file: `06_case_when_transform.sql`*

---

## 🪜 08_windows.sql — Window Functions

**Question:** Which countries consistently rank highest in suicide rates, and how do their rates change year-to-year?  

**Explanation:**  
Implemented `RANK()` to find top suicide rates per year and `LAG()` to measure yearly changes for each country.  
This provides insight into which nations experience persistent or rising suicide challenges.  

**Why it matters:** Window functions enable **dynamic ranking and trend analysis**, vital for longitudinal studies.

📁 *See file: `08_windows.sql`*

---

## 🧠 09_CTE.sql — Common Table Expressions

**Question:** Which country–year pairs exist in one dataset but not the other?  

**Explanation:**  
Created layered CTEs (`WITH s, h, s_only, h_only`) to identify mismatched entries between the two datasets.  
Used `EXCEPT` and `UNION ALL` within the same query to reveal missing overlaps and ensure join accuracy.  

**Why it matters:** CTEs make complex transformations and checks **readable, modular, and maintainable**.

📁 *See file: `09_CTE.sql`*

---

## 🔗 10_independent.sql — EXCEPT Feature

**Question:** How can we quickly find unique entries that exist only in one table?  

**Explanation:**  
Demonstrated the `EXCEPT` set operation to isolate country–year pairs that appear in `raw_suicides` but not in `raw_happiness`, and vice versa.  
Used as a **data diagnostic tool** before joining datasets.  

**Why it matters:** `EXCEPT` is a powerful method to **validate and audit datasets** during ETL (Extract–Transform–Load) stages.

📁 *See file: `10_independent.sql`*

---

## ⚖️ 11_independent_union.sql — UNION Feature

**Question:** Which countries have either very high suicide rates or very high happiness scores?  

**Explanation:**  
Used `UNION` to combine results from two queries into a single table — one listing high-suicide cases, the other high-happiness cases.  
This produces a merged comparative table of extremes, offering a way to explore societal contrasts.  

**Why it matters:** `UNION` demonstrates **set logic** and helps synthesize multiple perspectives into one unified output.

📁 *See file: `11_independent_union.sql`*

---

## 🧾 Summary of Key Learnings

| Concept | Purpose | File |
|----------|----------|------|
| Data Integration | Cleaned and merged suicide + happiness datasets | 01_setup_joins.sql |
| Basic SQL Queries | Core selection, grouping, and sorting | 02_basics.sql |
| Aggregate Metrics | Global summary and longitudinal insights | 03_aggregate.sql |
| Transformation | Grouping data by GDP tiers | 06_case_when_transform.sql |
| Window Functions | Ranking and time-based change | 08_windows.sql |
| CTE | Modular multi-step queries | 09_CTE.sql |
| EXCEPT | Data validation between datasets | 10_independent.sql |
| UNION | Combining different insights | 11_independent_union.sql |

---

This repository acts as a reusable **SQL practice portfolio**, covering data cleaning, transformation, analysis, and documentation of key relational techniques.
