-- 1. Unique keys (single day sample)
SELECT DISTINCT ep.key
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(event_params) AS ep
ORDER BY 1;

-- 2. Value types and fill rates per key (single day)
SELECT
    ep.key,
    COUNT(*) AS total,
    COUNTIF(ep.value.string_value IS NOT NULL) AS string_filled,
    COUNTIF(ep.value.int_value IS NOT NULL) AS int_filled,
    COUNTIF(ep.value.float_value IS NOT NULL) AS float_filled,
    COUNTIF(ep.value.double_value IS NOT NULL) AS double_filled,
    COUNTIF(
        ep.value.string_value IS NULL
        AND ep.value.int_value IS NULL
        AND ep.value.float_value IS NULL
        AND ep.value.double_value IS NULL
    ) AS all_null
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(event_params) AS ep
GROUP BY ep.key
ORDER BY ep.key;

-- 3. Full scan — confirm 100% NULL keys
SELECT ep.key, COUNT(*) AS total,
    COUNTIF(
        ep.value.string_value IS NULL
        AND ep.value.int_value IS NULL
        AND ep.value.float_value IS NULL
        AND ep.value.double_value IS NULL
    ) AS all_null
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(event_params) AS ep
WHERE ep.key IN ('all_data', 'dclid', 'gclid', 'gclsrc')
GROUP BY ep.key;

-- 4. Mixed type check: session_engaged
SELECT
    COUNTIF(ep.value.string_value IS NOT NULL) AS string_filled,
    COUNTIF(ep.value.int_value IS NOT NULL) AS int_filled,
    COUNT(*) AS total
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(event_params) AS ep
WHERE ep.key = 'session_engaged';
