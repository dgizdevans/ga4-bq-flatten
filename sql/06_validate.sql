-- 1. Row count parity
SELECT
    (SELECT COUNT(*) FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`) AS source_events,
    (SELECT COUNT(*) FROM `your-project.your_dataset.flatten_no_item`) AS flat_events;

-- 2. Date range
SELECT
    MIN(event_date) AS date_from,
    MAX(event_date) AS date_to,
    COUNT(DISTINCT event_date) AS unique_dates
FROM `your-project.your_dataset.flatten_no_item`;

-- 3. Event distribution
SELECT event_name, COUNT(*) AS events
FROM `your-project.your_dataset.flatten_no_item`
GROUP BY 1
ORDER BY 2 DESC;
