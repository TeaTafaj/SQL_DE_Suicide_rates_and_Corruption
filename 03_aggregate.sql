-- Aggregate functions over time (per year)
SELECT
  year,
  COUNT(*)                           AS n_country_year_rows,
  COUNT(DISTINCT country)            AS n_countries,
  ROUND(AVG(suicides_per_100k), 2)   AS avg_suicide_rate,
  ROUND(MIN(suicides_per_100k), 2)   AS min_suicide_rate,
  ROUND(MAX(suicides_per_100k), 2)   AS max_suicide_rate,
  ROUND(AVG(gdp_per_capita_usd), 2)  AS avg_gdp_per_capita_usd,
  ROUND(AVG(happiness_score), 2)     AS avg_happiness_score
FROM v_policy_join
WHERE suicides_per_100k IS NOT NULL
GROUP BY year
ORDER BY year;
