{{ config(
	alias = 'link_aircraft_seat',
	database = 'demo',
	on_schema_change = 'fail'
) }}

select 
  md5(
   upper(trim(aircraft_code))
   || '|'
   || upper(trim(aircraft_code))
   || '|'
   || upper(trim(seat_no))
  ) AS lhk_aircraft_seat
  ,md5(upper(trim(aircraft_code))) AS hk_aircraft
  ,md5(
   upper(trim(aircraft_code)) 
    || '|'
    || upper(trim(seat_no))
   ) AS hk_seat
  ,current_timestamp(0) AS ingesttime
FROM {{ source('staging', 'seats') }}