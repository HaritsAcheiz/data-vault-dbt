{{ config(
	alias = 'hub_seat',
	database = 'demo',
	on_schema_change = 'fail'
) }}

select 
   md5(
    upper(trim(aircraft_code)) 
    || '|'
    || upper(trim(seat_no))
   ) AS hk_seat
  ,aircraft_code
  ,seat_no
  ,current_timestamp(0) AS ingesttime
FROM {{ source('staging', 'seats') }}