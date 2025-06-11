/*
  Extracts user event data from GA4 sample e-commerce dataset in BigQuery,
  focusing on key funnel steps for the entire year of 2021.

  Events filtered: session_start, view_item, add_to_cart, begin_checkout,
                   add_shipping_info, add_payment_info, purchase.

  The query selects relevant fields for session, user, device, geography, and campaign.
*/

SELECT 
       -- Convert event timestamp from microseconds to readable timestamp
       timestamp_micros(event_timestamp) as event_timestamp, 
       
       -- Anonymous user identifier
       user_pseudo_id, 
       
       -- Extract session ID from nested event_params
       (SELECT value.int_value FROM bge.event_params WHERE key = 'ga_session_id') AS session_id,  
       
       -- GA4 event name (e.g., session_start, view_item, purchase, etc.)
       event_name, 
       
       -- Country of the user based on IP
       geo.country AS country, 
       
       -- Device category (e.g., desktop, mobile, tablet)
       device.category AS device_category, 
       
       -- Traffic source details
       traffic_source.source AS source,        -- E.g., google, direct, etc.
       traffic_source.medium AS medium,        -- E.g., organic, referral, etc.
       traffic_source.name AS campaign         -- Campaign name (if set in UTM parameters)
       
FROM 
       `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
       
-- Limit data to events from January to December 2021
WHERE _table_suffix >= '20210101' and _table_suffix <= '20211231' 
-- Filter only relevant events for funnel analysis
       AND event_name IN ('session_start', 
                           'view_item', 
                           'add_to_cart', 
                           'begin_checkout', 
                           'add_shipping_info', 
                           'add_payment_info', 
                           'purchase');
