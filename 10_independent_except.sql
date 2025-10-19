WITH s AS (
  SELECT DISTINCT TRIM(country) AS country, CAST(year AS INT) AS year
  FROM raw_suicides
),
h AS (
  SELECT DISTINCT TRIM("Country Name") AS country, CAST("Year" AS INT) AS year
  FROM raw_happiness
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

