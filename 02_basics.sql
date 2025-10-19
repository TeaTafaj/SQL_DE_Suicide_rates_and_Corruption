-- Question: Top 10 countries by average suicide rate (all years with data), require ≥ 8 observations.
SELECT
  country,
  ROUND(AVG(suicides_per_100k), 2) AS avg_suicide_rate,
  COUNT(*) AS n_obs
FROM v_policy_join
WHERE suicides_per_100k IS NOT NULL
GROUP BY country
HAVING COUNT(*) >= 8
ORDER BY avg_suicide_rate DESC
LIMIT 10;
