-- Transform GDP per capita into tiers and compare suicide rates

CREATE VIEW v_policy_clean_gdp_tiers AS
SELECT
  country,
  year,
  suicides_per_100k,
  gdp_per_capita_usd,
  happiness_score,
  CASE
    WHEN gdp_per_capita_usd >= 30000 THEN 'High income (≥30k)'
    WHEN gdp_per_capita_usd >= 12000 THEN 'Upper-middle (12k–30k)'
    WHEN gdp_per_capita_usd >= 4000  THEN 'Lower-middle (4k–12k)'
    ELSE 'Low income (<4k)'
  END AS gdp_tier
FROM v_policy_clean;
