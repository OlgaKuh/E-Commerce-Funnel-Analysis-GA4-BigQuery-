with events_data as (select extract(date FROM timestamp_micros(event_timestamp)) as event_date,
       event_name,
       traffic_source.source as source, 
       traffic_source.medium as medium,
       traffic_source.name as campaign,
       concat(CAST(user_pseudo_id as STRING), cast((select value.int_value from bge.event_params where key = 'ga_session_id') as STRING)) as user_and_session_id
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
where event_name in ('session_start', 'add_to_cart', 'begin_checkout', 'purchase'))
select event_date,
       source,
       medium,
       campaign,
       count(distinct user_and_session_id) as user_sessions_count,
       round(count(distinct if(event_name = "add_to_cart",user_and_session_id, NULL))/count(distinct user_and_session_id),3) as visit_to_cart,
       round(count(distinct if(event_name = "begin_checkout",user_and_session_id, NULL))/count(distinct user_and_session_id),3) as visit_to_checkout,
       round(count(distinct if(event_name = "purchase",user_and_session_id, NULL))/count(distinct user_and_session_id),3) as visit_to_purchase
from events_data
group by event_date, source, medium, campaign;
