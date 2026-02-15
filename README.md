# GA4 BigQuery Data Profiling and Flattening

## Problem

GA4 BigQuery export stores data in nested and repeated structures (event_params, user_properties, items). This is great inside BigQuery, but most downstream tools (pandas, ML pipelines, many BI tools) expect flat tables. Repeated UNNEST logic in every query is tedious and increases error risk.

This repo shows a practical workflow to profile GA4 export data and build a reproducible flattening query using the public `ga4_obfuscated_sample_ecommerce` dataset.

## Dataset

Public BigQuery dataset: [Google Merchandise Store : Obfuscated GA360 Data](https://console.cloud.google.com/marketplace/product/obfuscated-ga360-data/obfuscated-ga360-data?hl=en)  
BigQuery ID: `bigquery-public-data.ga4_obfuscated_sample_ecommerce`

Period: Nov 2020 to Jan 2021.  
Scale: 92 daily tables, ~4.3M events.



## Contents

- `ga4_bq_profiling_and_flattening.ipynb` - end-to-end: connect to BigQuery, profile schema and nested fields, build and validate a flat events table

## Approach

1. Profile `event_params` - key coverage, NULL rates, type inconsistencies
2. Profile `user_properties` - presence and sparsity
3. Profile `items` - presence and sparsity (ecommerce context)
4. Profile flat event fields - identify fields that are always NULL in this dataset
5. Build flatten query - pivot selected `event_params` keys into columns and keep stable fields
6. Validate - row count parity, date range, event-type distribution

## Key findings (for this dataset)

- 28 `event_params` keys observed, 4 are always NULL, 24 retained in the flat table
- `user_properties` are extremely sparse (present as key-value pairs, not as stable columns)
- `items` are excluded from the final flat table to keep an event-level layout simple (can be expanded later)
- 12 flat fields are always NULL in this dataset and are excluded
- 1 mixed-type key (`session_engaged`) handled via `COALESCE` across value types

## Result

Flat table: 4,295,584 rows x 60 columns, 1:1 with source events (event-level granularity).

## Requirements

- Google Cloud project with BigQuery access
- Python 3
- Packages: `google-cloud-bigquery`, `pandas`
- Colab or local environment (service account if needed)

## Usage

1. Open the notebook in Colab
2. Set `PROJECT_ID` and `DEST_DATASET`
3. Run all cells
