with sessions_data as (select user_pseudo_id,
       (select value.int_value from bge.event_params where key = 'ga_session_id') as session_id,
       min(event_timestamp) as session_start_timestamp,
       count (*) as unique_sessions,
       REGEXP_EXTRACT(ARRAY_AGG((select value.string_value from bge.event_params where key = 'page_location') IGNORE NULLS ORDER BY event_timestamp)[OFFSET(0)], r"https:\/\/[^\/]+\/([^?]+)") AS starting_page
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
group by user_pseudo_id, session_id
),
purchases_data as (select user_pseudo_id,
       (select value.int_value from bge.event_params where key = 'ga_session_id') as session_id, 
       event_name,
       count(*) as purchases      
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` bge
where event_name = 'purchase'
group by user_pseudo_id, session_id, event_name)

select starting_page,
       sum(sd.unique_sessions) as total_unique_sessions,
       sum(pd.purchases) as total_purchases,
       case 
        when count(*) = 0 then NULL 
        else round(sum(pd.purchases)/count(*),3) 
       end as conversions
from sessions_data sd
left join purchases_data pd on pd.user_pseudo_id = sd.user_pseudo_id and  pd.session_id = sd.session_id
group by starting_page
order by starting_page;
