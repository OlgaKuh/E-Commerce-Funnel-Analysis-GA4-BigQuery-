# E-Commerce Funnel Analysis (GA4 + BigQuery)

This project showcases a funnel analysis using SQL and GA4 data stored in Google BigQuery for an e-commerce platform. The goal is to understand user behavior across key steps in the purchase journey and identify opportunities to improve conversion rates.

## 🔍 Project Overview

The analysis includes:

1. **Data Cleaning & Processing**  
   Preparing raw GA4 data for analysis and BI reporting.

2. **Conversions by Date and Traffic Channel**  
   Calculating daily conversion rates segmented by traffic source.

3. **Landing Page Conversion Comparison**  
   Identifying high- and low-performing landing pages based on conversions.

4. **User Engagement vs Purchase Correlation**  
   Measuring the relationship between user activity (views, scrolls, clicks) and purchase behavior.

If you'd like to explore the queries directly in BigQuery UI, you can [open them at this link](https://console.cloud.google.com/bigquery?ws=!1m7!1m6!12m5!1m3!1secomm-ga4-data-analysis!2sus-central1!3sxpj9tvwh5p2y7bd2d9cee39f43cbbfef8525cbfa0348!2e1) (requires Google login and BigQuery registration).

## 🛠 Tools & Technologies
- SQL (Standard SQL in BigQuery)
- Google Analytics 4 (GA4)
- Google BigQuery
- BI Reporting (e.g., Tableau or Looker Studio — optional mention if used)

## 🧾 Dataset Used

This analysis uses Google’s public GA4 sample dataset:

**`bigquery-public-data.ga4_obfuscated_sample_ecommerce`**

This dataset simulates real-world e-commerce tracking using Google Analytics 4 and is publicly available in Google BigQuery.  
You can explore it [here](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=ga4_obfuscated_sample_ecommerce&t=events_20210131&page=table) (requires Google login and BigQuery registration).


## 📁 Files

| File Name | Description |
|-----------|-------------|
| `01_data_cleaning_and_processing.sql` | Cleans and prepares GA4 data for reporting |
| `02_conversions_by_date_and_channel.sql` | Calculates conversion rates by date and traffic channel |
| `03_landing_page_comparison.sql` | Compares conversion performance across landing pages |
| `04_engagement_vs_purchase.sql` | Analyzes engagement metrics and purchase correlation |

## 📈 Outcome & Insights
- Identified top-performing channels and landing pages.
- Found strong correlation between high engagement and increased conversion likelihood.
- Enabled BI team to generate more insightful and automated funnel reports.

---

Feel free to clone this repo or use the queries for similar GA4 funnel analysis in your own BigQuery environment.
