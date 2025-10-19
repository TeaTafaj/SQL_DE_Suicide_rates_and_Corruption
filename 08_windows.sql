SELECT
  distinct(country),
  year,
  suicides_per_100k,
  RANK() OVER (PARTITION BY year ORDER BY suicides_per_100k DESC) AS rank_in_year
FROM v_policy_clean
WHERE suicides_per_100k IS NOT NULL
ORDER BY year, rank_in_year
LIMIT 20;
