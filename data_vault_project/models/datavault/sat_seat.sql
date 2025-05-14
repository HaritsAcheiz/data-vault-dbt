{{ config(
	alias = 'sat_seat',
	database = 'demo',
	on_schema_change = 'fail'
) }}

SELECT
  md5(
   upper(trim(aircraft_code)) 
    || '|'
    || upper(trim(seat_no))
   )
  ,current_timestamp(0) AS ingesttime
  ,fare_conditions  
FROM {{ source('staging', 'seats') }}