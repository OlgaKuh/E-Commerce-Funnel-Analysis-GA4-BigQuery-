/*
  Correlation check between user engagement metrics and purchase behavior.
  Measures how session engagement and activity time relate to purchases.
*/

-- Step 1: Aggregate session-level metrics
WITH user_session_data AS (
       SELECT       
              user_pseudo_id,
              (SELECT value.int_value FROM bge.event_params WHERE key = 'ga_session_id') AS session_id,

              -- Whether the session was considered "engaged" (GA4 boolean value as string)
              MAX(IF(
                    (SELECT value.string_value FROM bge.event_params WHERE key = 'session_engaged') = '1', \
                     1, 0    
              )) AS session_engagement,

              -- Total time spent in session (milliseconds)
              SUM((SELECT value.int_value FROM bge.event_params WHERE key = 'engagement_time_msec')) AS activity_time_msec,

               -- Whether a purchase occurred in the session
              MAX(IF(event_name = 'purchase', 1, 0)) AS purchase_made
       
       FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
       GROUP BY user_pseudo_id, session_id
)

-- Step 2: Calculate Pearson correlation between engagement & purchase
SELECT 
       CORR(session_engagement, purchase_made) AS engagement_purchase_corr,
       CORR(activity_time_msec, purchase_made) AS activity_time_purchase_corr
FROM user_session_data usd;
