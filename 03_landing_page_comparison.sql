/*
  Compares conversion rates across different landing pages
  based on user session start page and corresponding purchases.
*/

-- Step 1: Extract session-level landing page and basic info\
WITH sessions_data AS (
       SELECT 
              user_pseudo_id,
              
              -- Extract session ID
              (SELECT value.int_value FROM bge.event_params WHERE key = 'ga_session_id') AS session_id,
       
              -- Timestamp of first event in session
              MIN(event_timestamp) AS session_start_timestamp,

              -- Count of unique sessions per user on the site
              COUNT (*) AS unique_sessions,

              -- Extract clean landing page path from 'page_location' parameter
              REGEXP_EXTRACT(
                     ARRAY_AGG(
                            (SELECT value.string_value FROM bge.event_params WHERE key = 'page_location') 
                            IGNORE NULLS        
                            ORDER BY event_timestamp
                     )[OFFSET(0)], r"https:\/\/[^\/]+\/([^?]+)"       
              ) AS starting_page
       
       FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
       GROUP BY user_pseudo_id, session_id
),

-- Step 2: Collect purchase event count per session       
purchases_data AS (      
       SELECT 
              user_pseudo_id,
              (SELECT value.int_value FROM bge.event_params WHERE key = 'ga_session_id') AS session_id, 
              event_name,
              COUNT(*) AS purchases      
       FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
       WHERE event_name = 'purchase'
       GROUP BY user_pseudo_id, session_id, event_name
)

-- Step 3: Combine sessions and purchases to analyze conversion rates
SELECT 
       starting_page,
       SUM(sd.unique_sessions) AS total_unique_sessions,
       SUM(pd.purchases) AS total_purchases,
       
       -- Calculate conversion rate per page
       CASE 
        WHEN COUNT(*) = 0 THEN NULL 
        ELSE ROUND(SUM(pd.purchases)/COUNT(*),3) 
       END AS conversions
       
FROM sessions_data sd
LEFT JOIN purchases_data pd 
       ON pd.user_pseudo_id = sd.user_pseudo_id AND pd.session_id = sd.session_id
GROUP BY starting_page
ORDER BY starting_page;
