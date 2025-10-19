CREATE VIEW v_policy_clean AS
SELECT
  s.country,
  CAST(s.year AS INT)                                     AS year,
  -- aggregate to country–year
  SUM(CAST(s.suicides_no AS REAL))                        AS suicides_no,
  SUM(CAST(s.population  AS REAL))                        AS population,
  ROUND(
    (SUM(CAST(s.suicides_no AS REAL)) / NULLIF(SUM(CAST(s.population AS REAL)), 0)) * 100000
  , 2)                                                    AS suicides_per_100k,
  AVG(CAST(s."gdp_per_capita ($)" AS REAL))               AS gdp_per_capita_usd,
  AVG(CAST(h."Life Ladder"         AS REAL))              AS happiness_score
FROM raw_suicides s
JOIN raw_happiness h
  ON s.country = h."Country Name"
 AND s.year    = h."Year"
GROUP BY s.country, s.year;

