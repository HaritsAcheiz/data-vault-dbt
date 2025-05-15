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
  ) AS hk_seat
  ,aircraft_code
  ,seat_no
  ,fare_conditions
  ,current_timestamp(0) AS ingesttime
FROM {{ source('staging', 'seats') }}