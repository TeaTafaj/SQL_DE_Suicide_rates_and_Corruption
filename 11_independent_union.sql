-- Example: Compare countries with extreme suicide or happiness scores
SELECT country, year, suicides_per_100k AS value, 'High Suicide' AS category
FROM v_policy_clean
WHERE suicides_per_100k > 30

UNION

SELECT country, year, happiness_score AS value, 'High Happiness' AS category
FROM v_policy_clean
WHERE happiness_score > 7
ORDER BY country, year;
