/*
  Conversions calculation per date and traffic channels.
  Calculates session-level conversion rates for add-to-cart, checkout, and purchase
  events segmented by traffic source information.
*/

WITH events_data AS (
-- Step 1: Prepare event data and construct unique session IDs
       SELECT 
              EXTRACT(date FROM timestamp_micros(event_timestamp)) AS event_date,
              event_name,
              traffic_source.source AS source, 
              traffic_source.medium AS medium,
              traffic_source.name AS campaign,

              -- Combine user ID and session ID to define a unique user session
              concat(
                 CAST(user_pseudo_id AS STRING), 
                 CAST((SELECT value.int_value FROM bge.event_params WHERE key = 'ga_session_id') AS STRING)
              ) AS user_and_session_id
       
       FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge

       -- Only include relevant funnel steps
       WHERE event_name IN ('session_start', 'add_to_cart', 'begin_checkout', 'purchase')
)

-- Step 2: Aggregate conversion metrics       
SELECT 
       event_date,
       source,
       medium,
       campaign,

       -- Total number of unique user sessions
       COUNT(DISTINCT user_and_session_id) AS user_sessions_count,

       -- Conversion rates for each funnel step
       ROUND(COUNT(DISTINCT IF(event_name = "add_to_cart",user_and_session_id, NULL))/COUNT(DISTINCT user_and_session_id),3) AS visit_to_cart,
       ROUND(COUNT(DISTINCT IF(event_name = "begin_checkout",user_and_session_id, NULL))/COUNT(DISTINCT user_and_session_id),3) AS visit_to_checkout,
       ROUND(COUNT(DISTINCT IF(event_name = "purchase",user_and_session_id, NULL))/COUNT(DISTINCT user_and_session_id),3) AS visit_to_purchase
       
FROM events_data
GROUP BY event_date, source, medium, campaign;
