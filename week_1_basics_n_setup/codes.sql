-- Question 3. Count records
select 
    count(*)
from 
    yellow_taxi_data
where 
    tpep_pickup_datetime::date = '2021-01-15'

-- Question 4. Average
select 
    tpep_pickup_datetime::date, 
    max(tip_amount) 
from 
    yellow_taxi_data
group by 
    tpep_pickup_datetime::date
order by 
    max(tip_amount) desc


-- Question 5. Most popular destination
select 
	d."Zone",
	count(*)
from 
	yellow_taxi_data y 
	left join zones z 
		on y."PULocationID" = z."LocationID"
	left join zones d 
		on y."DOLocationID" = d."LocationID"
where 
	y.tpep_pickup_datetime::date = '2021-01-14'
	and z."Zone" = 'Central Park'
group by 
	1
order by 
	2 desc


-- Question 6. 
select 
	z."Zone"||' / ' ||d."Zone",
	avg(total_amount)
from 
	yellow_taxi_data y 
	left join zones z 
		on y."PULocationID" = z."LocationID"
	left join zones d 
		on y."DOLocationID" = d."LocationID"
group by 
	z."Zone"||' / ' ||d."Zone"
order by 
	avg(total_amount) desc
