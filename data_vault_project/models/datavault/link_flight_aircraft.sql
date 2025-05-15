{{ config(
    alias = 'link_flight_aircraft',
    database = 'demo',
    on_schema_change = 'fail'
) }}

SELECT
  md5(
   upper(trim(CAST(flight_id AS CHAR)))
   || '|'
   || upper(trim(aircraft_code))
  ) AS lhk_flight_aircraft
  ,md5(upper(trim(CAST(flight_id AS CHAR)))) AS hk_flight
  ,md5(
    upper(trim(aircraft_code))
  ) AS hk_aircraft
  ,current_timestamp(0) AS ingesttime
  FROM {{ source('staging', 'flights') }}