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

## 🛠 Tools & Technologies
- SQL (Standard SQL in BigQuery)
- Google Analytics 4 (GA4)
- Google BigQuery
- BI Reporting (e.g., Tableau or Looker Studio — optional mention if used)

## 🧾 Dataset Used

This analysis uses Google’s public GA4 sample dataset:

**`bigquery-public-data.ga4_obfuscated_sample_ecommerce`**

This dataset simulates real-world e-commerce tracking using Google Analytics 4 and is publicly available in Google BigQuery.  
You can explore it [here](https://console.cloud.google.com/marketplace/product/bigquery-public-data/ga4-obfuscated-sample-ecommerce) (requires Google account).


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
