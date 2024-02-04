-- We've given you a sample query below to help get started.
-- Just hit "Run" to run the query and get your results.
with cte1 as 
(
SELECT
  concat(pickup_zip, '-', dropoff_zip) as route,
  AVG(fare_amount) as average_fare
 
  --case when  `Most Popular Hits` = 1 then CONCAT('<td style="background-color: #90EE90">',PagePath , '</td>') else concat('<td>',PagePath,'</td>') end as PagePath
FROM
  `samples`.`nyctaxi`.`trips`
GROUP BY
  1
ORDER BY
  2 DESC
LIMIT 10
),cte2 as (
select *,
 row_number() over(order by average_fare) as rownum
 from cte1
)
select 
case when  rownum %2==0 then CONCAT('<td style="background-color: #90EE90">',route , '</td>') else concat('<td>',route,'</td>') end as route,
case when  rownum %2==0 then CONCAT('<td style="background-color: #90EE90">',average_fare , '</td>') else concat('<td>',average_fare,'</td>') end as average_fare
from cte2