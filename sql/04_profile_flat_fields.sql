-- 1. NULL check — single day sample
SELECT
    COUNT(*) AS total,
    COUNTIF(event_previous_timestamp IS NOT NULL) AS event_prev_ts,
    COUNTIF(event_server_timestamp_offset IS NOT NULL) AS event_server_ts_offset,
    COUNTIF(user_id IS NOT NULL) AS user_id,
    COUNTIF(event_value_in_usd IS NOT NULL) AS event_value_usd,
    COUNTIF(privacy_info.analytics_storage IS NOT NULL) AS privacy_analytics,
    COUNTIF(privacy_info.ads_storage IS NOT NULL) AS privacy_ads,
    COUNTIF(privacy_info.uses_transient_token IS NOT NULL) AS privacy_transient,
    COUNTIF(device.mobile_os_hardware_model IS NOT NULL) AS device_hw_model,
    COUNTIF(device.vendor_id IS NOT NULL) AS device_vendor_id,
    COUNTIF(device.advertising_id IS NOT NULL) AS device_ad_id,
    COUNTIF(ecommerce.refund_value_in_usd IS NOT NULL) AS ecom_refund_usd,
    COUNTIF(ecommerce.refund_value IS NOT NULL) AS ecom_refund,
    COUNTIF(ecommerce.shipping_value_in_usd IS NOT NULL) AS ecom_ship_usd,
    COUNTIF(ecommerce.shipping_value IS NOT NULL) AS ecom_ship
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`;

-- 2. Full scan — confirm 100% NULL fields
SELECT
    COUNT(*) AS total,
    COUNTIF(event_previous_timestamp IS NOT NULL) AS event_prev_ts,
    COUNTIF(event_server_timestamp_offset IS NOT NULL) AS event_server_ts_offset,
    COUNTIF(user_id IS NOT NULL) AS user_id,
    COUNTIF(event_value_in_usd IS NOT NULL) AS event_value_usd,
    COUNTIF(privacy_info.analytics_storage IS NOT NULL) AS privacy_analytics,
    COUNTIF(privacy_info.ads_storage IS NOT NULL) AS privacy_ads,
    COUNTIF(device.mobile_os_hardware_model IS NOT NULL) AS device_hw_model,
    COUNTIF(device.vendor_id IS NOT NULL) AS device_vendor_id,
    COUNTIF(device.advertising_id IS NOT NULL) AS device_ad_id,
    COUNTIF(ecommerce.refund_value_in_usd IS NOT NULL) AS ecom_refund_usd,
    COUNTIF(ecommerce.refund_value IS NOT NULL) AS ecom_refund,
    COUNTIF(ecommerce.shipping_value_in_usd IS NOT NULL) AS ecom_ship_usd,
    COUNTIF(ecommerce.shipping_value IS NOT NULL) AS ecom_ship
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;
