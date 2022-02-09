create or replace external table  `astute-lyceum-338516.trips_data_all.external_fhv_tripdata`
options (
  format = 'parquet',
  uris = ['gs://dtc_data_lake_astute-lyceum-338516/raw/fhv_tripdata_2019-*.parquet']
);


create or replace table `astute-lyceum-338516.trips_data_all.fhv_tripdata` as 
select * from `astute-lyceum-338516.trips_data_all.external_fhv_tripdata`;


select count(*) from `astute-lyceum-338516.trips_data_all.fhv_tripdata`;


select count(distinct dispatching_base_num) from `astute-lyceum-338516.trips_data_all.fhv_tripdata`; 


create or replace table `astute-lyceum-338516.trips_data_all.fhv_tripdata_partitioned_clustered`
partition by date(pickup_datetime)
cluster by dispatching_base_num as
select * from `astute-lyceum-338516.trips_data_all.external_fhv_tripdata`;

select count(*) from `astute-lyceum-338516.trips_data_all.fhv_tripdata_partitioned_clustered`
where date(pickup_datetime) between '2019-01-01' and '2019-03-31'
and dispatching_base_num in ('B00987', 'B02060', 'B02279');


create or replace table `astute-lyceum-338516.trips_data_all.fhv_tripdata_test_clust_part`
partition by RANGE_BUCKET(SR_Flag, GENERATE_ARRAY(0, 45, 1)) 
cluster by dispatching_base_num as
select * from `astute-lyceum-338516.trips_data_all.external_fhv_tripdata`;