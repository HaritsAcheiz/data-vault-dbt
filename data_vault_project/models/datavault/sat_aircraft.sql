{{ config(
	alias = 'sat_aircraft',
	database = 'demo',
	on_schema_change = 'fail'
) }}

SELECT
  md5(
   upper(trim(aircraft_code))
  ) AS hk_aircraft
  ,aircraft_code
  ,model->>'en' AS en_model
  ,model->>'ru' AS ru_model
  ,range
  ,current_timestamp(0) AS ingesttime
FROM {{ source('staging', 'aircrafts_data') }}