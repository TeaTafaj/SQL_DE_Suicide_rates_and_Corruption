SELECT
  CASE WHEN h."Country Name" IS NULL THEN 'no_match' ELSE 'match' END AS join_status,
  COUNT(*) AS n_rows
FROM raw_suicides s
LEFT JOIN raw_happiness h
  ON s.country = h."Country Name"
 AND s.year    = h."Year"
GROUP BY join_status
ORDER BY join_status;
