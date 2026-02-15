-- 1. Single day sample
SELECT up.key, COUNT(*) AS total
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(user_properties) AS up
GROUP BY up.key;

-- 2. Full scan
SELECT COUNT(*) AS total_kv_pairs
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(user_properties) AS up;
