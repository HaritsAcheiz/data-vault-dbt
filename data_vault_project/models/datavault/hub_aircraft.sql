{{ config(
	alias = 'hub_aircraft',
	database = 'demo',
	on_schema_change = 'fail'
) }}

SELECT
	md5(upper(trim(aircraft_code))) AS hk_aircraft,
	aircraft_code,
	current_timestamp(0) AS ingesttime
FROM {{ source('staging', 'aircrafts_data') }}