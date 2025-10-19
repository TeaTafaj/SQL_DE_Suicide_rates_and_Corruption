SELECT 'raw_suicides' AS tbl, COUNT(*) AS rows FROM raw_suicides
UNION ALL
SELECT 'raw_happiness', COUNT(*) FROM raw_happiness;

PRAGMA table_info(raw_suicides);
PRAGMA table_info(raw_happiness);

SELECT 
    s.country,
    h."Country Name",
    s.year,
    h."Life Ladder" AS happiness_score,
    s."suicides/100k pop" AS suicides_per_100k
FROM raw_suicides s
JOIN raw_happiness h
  ON s.country = h."Country Name"
 AND s.year = h."Year"
LIMIT 20;

SELECT COUNT(*) AS joined_rows
FROM raw_suicides s
JOIN raw_happiness h
  ON s.country = h."Country Name"
 AND s.year    = h."Year";

CREATE VIEW v_policy_join AS
SELECT
  s.country,
  CAST(s.year AS INT)                           AS year,
  CAST(s."suicides/100k pop" AS REAL)          AS suicides_per_100k,
  CAST(s."gdp_per_capita ($)" AS REAL)         AS gdp_per_capita_usd,
  CAST(h."Life Ladder" AS REAL)                AS happiness_score
FROM raw_suicides s
JOIN raw_happiness h
  ON s.country = h."Country Name"
 AND s.year    = h."Year";


SELECT *
FROM v_policy_join
LIMIT 10;

