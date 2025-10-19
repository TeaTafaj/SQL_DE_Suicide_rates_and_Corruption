WITH year_avg AS (
  SELECT
    year,
    AVG(suicides_per_100k) AS avg_rate_year
  FROM v_policy_clean
  GROUP BY year
),
joined AS (
  SELECT
    c.country,
    c.year,
    c.suicides_per_100k,
    y.avg_rate_year
  FROM v_policy_clean c
  JOIN year_avg y USING (year)
)
SELECT
  country,
  year,
  ROUND(suicides_per_100k, 2) AS suicides_per_100k,
  ROUND(avg_rate_year, 2)     AS year_avg_rate,
  ROUND(suicides_per_100k - avg_rate_year, 2) AS above_avg_abs,
  ROUND((suicides_per_100k / avg_rate_year - 1) * 100, 1) AS above_avg_pct
FROM joined
WHERE suicides_per_100k > 1.2 * avg_rate_year
ORDER BY year, suicides_per_100k DESC
LIMIT 50;

