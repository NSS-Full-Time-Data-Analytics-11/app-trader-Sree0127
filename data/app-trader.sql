SELECT * FROM app_store_apps limit 100;
SELECT * FROM play_store_apps limit 100;

--SELECT * FROM app_store_apps;
--SELECT * FROM play_store_apps;
---------------------------------------------------------------------------------------------------
-- 3.a. Develop some general recommendations about the price range, genre, content rating, or any other app characteristics that the company should target. --

WITH  app_play_Store_cte as(
 select 
  name as app_name,
  size_bytes as app_size, 
  price::money as app_cost, 
  review_count::int, 
  rating as rating, 
  content_rating as content_rating, 
  primary_genre as genre, 
  'app_store' as store,
  5000::money as app_income,
  (case when price <= 2.5 then 2.5 else price end::money * 10000)::money as app_buying_price,
  1000::money as app_marketing_price,
  ((case when price <= 2.5 then 2.5 else price end::money * 10000) + (1000::money) -  (5000::money))::money as app_total_buying_value
 from app_store_apps
-- where rating >= 4.0
-- and review_count::int >= 10000

 union all
	
select 
 name as app_name,
 size as app_size, 
 price::money as app_cost, 
 review_count, 
 rating, 
 content_rating, 
 genres as genre, 
 'play_store' as store,
 5000::money as app_income,
 ((case when (price::money <= 2.5::money) then (2.5::money) else (price::money) end) * 10000)::money as app_buying_price,
 1000::money as app_marketing_price,
 (((case when (price::money < 2.5::money) then (2.5::money) else (price::money) end) * 10000) + (1000::money) -  (5000::money))::money as app_total_buying_value
from play_store_apps
)

--select min(ac.app_total_buying_value) from app_play_Store_cte ac -- "min" "$21,000.00"

select distinct ac.genre , ac.store 
from app_play_Store_cte ac 
where ac.app_total_buying_value = 21000::money
and rating >= 5.0
and review_count::int >= 10000

---b. Develop a Top 10 List of the apps that App Trader should buy based on profitability/return on investment as the sole priority.
WITH  app_play_Store_cte as(
 select 
  name as app_name,
  size_bytes as app_size, 
  price::money as app_cost, 
  review_count::int, 
  rating as rating, 
  content_rating as content_rating, 
  primary_genre as genre, 
  'app_store' as store,
  5000::money as app_income,
  (case when price <= 2.5 then 2.5 else price end::money * 10000)::money as app_buying_price,
  1000::money as app_marketing_price,
  ((case when price <= 2.5 then 2.5 else price end::money * 10000) + (1000::money) -  (5000::money))::money as app_total_buying_value
 from app_store_apps
-- where rating >= 4.0
-- and review_count::int >= 10000

 union all
	
select 
 name as app_name,
 size as app_size, 
 price::money as app_cost, 
 review_count, 
 rating, 
 content_rating, 
 genres as genre, 
 'play_store' as store,
 5000::money as app_income,
 ((case when (price::money <= 2.5::money) then (2.5::money) else (price::money) end) * 10000)::money as app_buying_price,
 1000::money as app_marketing_price,
 (((case when (price::money < 2.5::money) then (2.5::money) else (price::money) end) * 10000) + (1000::money) -  (5000::money))::money as app_total_buying_value
from play_store_apps
)

--select min(ac.app_total_buying_value) from app_play_Store_cte ac -- "min" "$21,000.00"

select distinct ac.genre , ac.store 
from app_play_Store_cte ac 
where ac.app_total_buying_value = 21000::money
and rating >= 5.0
and review_count::int >= 10000
LIMIT 10
;

----------------------------------------------------------------------------------------------------

--c. Develop a Top 4 list of the apps that App Trader should buy that are profitable but that also are thematically appropriate for the upcoming Halloween themed campaign.

WITH  app_play_Store_cte as(
 select 
  name as app_name,
  size_bytes as app_size, 
  price::money as app_cost, 
  review_count::int, 
  rating as rating, 
  content_rating as content_rating, 
  primary_genre as genre, 
  'app_store' as store,
  5000::money as app_income,
  (case when price <= 2.5 then 2.5 else price end::money * 10000)::money as app_buying_price,
  1000::money as app_marketing_price,
  ((case when price <= 2.5 then 2.5 else price end::money * 10000) + (1000::money) -  (5000::money))::money as app_total_buying_value
 from app_store_apps
-- where rating >= 4.0
-- and review_count::int >= 10000

 union all
	
select 
 name as app_name,
 size as app_size, 
 price::money as app_cost, 
 review_count, 
 rating, 
 content_rating, 
 genres as genre, 
 'play_store' as store,
 5000::money as app_income,
 ((case when (price::money <= 2.5::money) then (2.5::money) else (price::money) end) * 10000)::money as app_buying_price,
 1000::money as app_marketing_price,
 (((case when (price::money < 2.5::money) then (2.5::money) else (price::money) end) * 10000) + (1000::money) -  (5000::money))::money as app_total_buying_value
from play_store_apps
)

--select min(ac.app_total_buying_value) from app_play_Store_cte ac -- "min" "$21,000.00"

select distinct ac.app_name ,ac.app_total_buying_value,ac.rating
from app_play_Store_cte ac 
where 
ac.app_total_buying_value = 21000::money
and rating >= 4.0
--and review_count::int >= 10000
and 
(ac.app_name ilike '%halloween%')
ORDER BY ac.rating DESC
 LIMIT 4
;