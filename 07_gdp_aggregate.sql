SELECT
  gdp_tier,
  COUNT(*)                         AS n_rows,
  COUNT(DISTINCT country)          AS n_countries,
  ROUND(AVG(suicides_per_100k),2)  AS avg_suicide_rate,
  ROUND(MAX(suicides_per_100k),2)  AS max_suicide_rate
FROM v_policy_clean_gdp_tiers
GROUP BY gdp_tier
HAVING COUNT(*) >= 50
ORDER BY avg_suicide_rate DESC;
