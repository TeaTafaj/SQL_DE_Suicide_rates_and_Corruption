
# 🧭 SQL Reference Guide — Policy & Social Analysis

**Author:** Tea Tafaj  
**Program:** Duke University – MIDS 2025  
**Dataset:** Suicide Rates (Kaggle) + World Happiness Report  
**Date:** October 19, 2025

---

## 📂 Overview

This guidebook documents SQL skills through a real-world dataset combining **social well-being (happiness)** and **suicide rates** across countries and years.  
Each section demonstrates an essential SQL concept — from basics and joins to window functions and CTEs — using cleaned, policy-relevant data.

---

## 🧱 1. Data Loading & Cleaning

**Goal:** Load and join two datasets while keeping only overlapping country–year pairs.

```sql
CREATE VIEW v_policy_clean AS
SELECT
  s.country,
  CAST(s.year AS INT) AS year,
  SUM(CAST(s.suicides_no AS REAL)) AS suicides_no,
  SUM(CAST(s.population AS REAL)) AS population,
  ROUND(
    (SUM(CAST(s.suicides_no AS REAL)) / NULLIF(SUM(CAST(s.population AS REAL)), 0)) * 100000,
    2
  ) AS suicides_per_100k,
  AVG(CAST(s."gdp_per_capita ($)" AS REAL)) AS gdp_per_capita_usd,
  AVG(CAST(h."Life Ladder" AS REAL)) AS happiness_score
FROM raw_suicides s
JOIN raw_happiness h
  ON s.country = h."Country Name"
 AND s.year = h."Year"
GROUP BY s.country, s.year;
```

---

## ⚙️ 2. Basics: SELECT, WHERE, ORDER BY, LIMIT, GROUP BY, HAVING

**Goal:** Show average suicide rates by country (2010–2020).

```sql
SELECT
  country,
  ROUND(AVG(suicides_per_100k), 2) AS avg_suicide_rate,
  COUNT(*) AS n_obs
FROM v_policy_clean
WHERE suicides_per_100k IS NOT NULL
GROUP BY country
HAVING COUNT(*) >= 8
ORDER BY avg_suicide_rate DESC
LIMIT 10;
```

---

## 📊 3. Aggregate Functions

**Goal:** Use `AVG`, `COUNT`, `MIN`, `MAX` to summarize trends over time.

```sql
SELECT
  year,
  COUNT(DISTINCT country) AS n_countries,
  ROUND(AVG(suicides_per_100k), 2) AS avg_suicide_rate,
  ROUND(MIN(suicides_per_100k), 2) AS min_rate,
  ROUND(MAX(suicides_per_100k), 2) AS max_rate,
  ROUND(AVG(gdp_per_capita_usd), 2) AS avg_gdp_per_capita_usd,
  ROUND(AVG(happiness_score), 2) AS avg_happiness
FROM v_policy_clean
GROUP BY year
ORDER BY year;
```

---

## 🧩 4. Data Transformation — CASE WHEN

**Goal:** Categorize GDP per capita into tiers and compare suicide rates.

```sql
CREATE VIEW v_policy_clean_gdp_tiers AS
SELECT
  country,
  year,
  suicides_per_100k,
  gdp_per_capita_usd,
  happiness_score,
  CASE
    WHEN gdp_per_capita_usd >= 30000 THEN 'High income (≥30k)'
    WHEN gdp_per_capita_usd >= 12000 THEN 'Upper-middle (12k–30k)'
    WHEN gdp_per_capita_usd >= 4000  THEN 'Lower-middle (4k–12k)'
    ELSE 'Low income (<4k)'
  END AS gdp_tier
FROM v_policy_clean;
```

---

## 🪜 5. Window Functions — RANK & LAG

**RANK() Example — Top suicide rates per year**

```sql
SELECT
  country,
  year,
  suicides_per_100k,
  RANK() OVER (PARTITION BY year ORDER BY suicides_per_100k DESC) AS rank_in_year
FROM v_policy_clean
ORDER BY year, rank_in_year
LIMIT 20;
```

**LAG() Example — Year-over-year change**

```sql
SELECT
  country,
  year,
  suicides_per_100k,
  ROUND(
    suicides_per_100k - LAG(suicides_per_100k) OVER (PARTITION BY country ORDER BY year),
    2
  ) AS yoy_change
FROM v_policy_clean
ORDER BY country, year
LIMIT 20;
```

---

## 🧠 6. Common Table Expressions (CTE)

**Goal:** Identify mismatched country–year pairs across datasets.  

```sql
WITH s AS (
  SELECT DISTINCT TRIM(country) AS country, CAST(year AS INT) AS year FROM raw_suicides
),
h AS (
  SELECT DISTINCT TRIM("Country Name") AS country, CAST("Year" AS INT) AS year FROM raw_happiness
),
s_only AS (
  SELECT 'suicides_only' AS where_found, country, year FROM s
  EXCEPT
  SELECT 'suicides_only', country, year FROM h
),
h_only AS (
  SELECT 'happiness_only' AS where_found, country, year FROM h
  EXCEPT
  SELECT 'happiness_only', country, year FROM s
)
SELECT * FROM s_only
UNION ALL
SELECT * FROM h_only
ORDER BY where_found, country, year;
```

---

## 🧰 7. Independently Explored Features

### A. EXCEPT — Data Coverage Diagnostic  
Find years present in one dataset but missing in another.  
(*Used above in the CTE section — demonstrates set logic.*)

### B. UNION — Combine insights across metrics  

```sql
SELECT country, year, suicides_per_100k AS value, 'High Suicide' AS category
FROM v_policy_clean
WHERE suicides_per_100k > 30

UNION

SELECT country, year, happiness_score AS value, 'High Happiness' AS category
FROM v_policy_clean
WHERE happiness_score > 7
ORDER BY country, year;
```

---

## 🧾 Summary

| Concept | Technique Demonstrated |
|----------|-----------------------|
| Data Loading | CREATE TABLE, INSERT via import |
| Basics | SELECT, WHERE, ORDER BY, GROUP BY, HAVING |
| Aggregates | COUNT, AVG, MAX, MIN |
| Joins | INNER JOIN, LEFT JOIN |
| Transformation | CASE WHEN |
| Windows | RANK, LAG |
| CTE | WITH + EXCEPT |
| Extra Features | EXCEPT, UNION |

---

**Result:**  
This README demonstrates full proficiency in advanced SQL querying, data cleaning, and relational design using real social-policy data.
