-- 1. Items fields and fill rates (single day)
SELECT
    COUNT(*) AS total_items,
    COUNTIF(item_id IS NOT NULL) AS item_id_filled,
    COUNTIF(item_name IS NOT NULL) AS item_name_filled,
    COUNTIF(item_brand IS NOT NULL) AS item_brand_filled,
    COUNTIF(item_variant IS NOT NULL) AS item_variant_filled,
    COUNTIF(item_category IS NOT NULL) AS item_category_filled,
    COUNTIF(item_category2 IS NOT NULL) AS item_category2_filled,
    COUNTIF(item_category3 IS NOT NULL) AS item_category3_filled,
    COUNTIF(item_category4 IS NOT NULL) AS item_category4_filled,
    COUNTIF(item_category5 IS NOT NULL) AS item_category5_filled,
    COUNTIF(price IS NOT NULL) AS price_filled,
    COUNTIF(quantity IS NOT NULL) AS quantity_filled,
    COUNTIF(item_revenue IS NOT NULL) AS item_revenue_filled,
    COUNTIF(coupon IS NOT NULL) AS coupon_filled,
    COUNTIF(affiliation IS NOT NULL) AS affiliation_filled,
    COUNTIF(location_id IS NOT NULL) AS location_id_filled,
    COUNTIF(item_list_name IS NOT NULL) AS item_list_name_filled,
    COUNTIF(item_list_index IS NOT NULL) AS item_list_index_filled,
    COUNTIF(promotion_id IS NOT NULL) AS promotion_id_filled,
    COUNTIF(promotion_name IS NOT NULL) AS promotion_name_filled,
    COUNTIF(creative_name IS NOT NULL) AS creative_name_filled,
    COUNTIF(creative_slot IS NOT NULL) AS creative_slot_filled
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(items);

-- 2. Items per event by event_name (single day)
SELECT
    event_name,
    COUNT(*) AS events_with_items,
    SUM(ARRAY_LENGTH(items)) AS total_items,
    ROUND(AVG(ARRAY_LENGTH(items)), 1) AS avg_items_per_event
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
WHERE ARRAY_LENGTH(items) > 0
GROUP BY 1
ORDER BY 2 DESC;

-- 3. Fill rates across full dataset (quantity, item_revenue)
SELECT
    COUNTIF(quantity IS NOT NULL) AS quantity_filled,
    COUNTIF(item_revenue IS NOT NULL) AS item_revenue_filled,
    COUNT(*) AS total
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items);
