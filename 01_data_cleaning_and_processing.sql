/* */
select timestamp_micros(event_timestamp) as event_timestamp,
       user_pseudo_id,
       (select value.int_value from bge.event_params where key = 'ga_session_id') as session_id,
       event_name,
       geo.country as country,
       device.category as device_category,
       traffic_source.source as source,
       traffic_source.medium as medium,
       traffic_source.name as campaign
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
where _table_suffix >= '20210101' and _table_suffix <= '20211231' and event_name in ('session_start', 'view_item', 'add_to_cart', 'begin_checkout', 'add_shipping_info', 'add_payment_info', 'purchase');
