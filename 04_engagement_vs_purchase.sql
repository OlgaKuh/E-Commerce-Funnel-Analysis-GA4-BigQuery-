with user_session_data as (SELECT user_pseudo_id,
       (select value.int_value from bge.event_params where key = 'ga_session_id') as session_id,
       MAX(IF((select value.string_value from bge.event_params where key = 'session_engaged') = '1', 1, 0)) as session_engagement,
       SUM((select value.int_value from bge.event_params where key = 'engagement_time_msec')) as activity_time_msec,
       MAX(IF(event_name = 'purchase', 1, 0)) as purchase_made
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
GROUP BY user_pseudo_id, session_id)

select CORR(session_engagement, purchase_made) as engagement_purchase_corr,
       CORR(activity_time_msec, purchase_made) as activity_time_purchase_corr
from user_session_data usd;
