{{ config(
    alias = 'dm_seat_allocation_enhancement',
    database = 'demo',
    on_schema_change = 'fail'
) }}

SELECT
    -- Link information as the fact
    las.lhk_aircraft_seat AS aircraft_seat_key,
    las.ingesttime AS configuration_time,
    
    -- Aircraft dimensions
    a.aircraft_code,
    sa.en_model AS aircraft_model,
    sa.ru_model AS aircraft_model_ru,
    sa.range AS aircraft_range,
    
    -- Seat dimensions
    s.seat_no,
    ss.fare_conditions,
    
    -- Derived metrics
    (SELECT COUNT(*) FROM {{ ref('link_aircraft_seat') }} 
     WHERE hk_aircraft = a.hk_aircraft) AS total_seats_in_aircraft,

    -- Flight utilization (can be joined later if needed)
    (SELECT COUNT(DISTINCT lfa.hk_flight) 
     FROM {{ ref('link_flight_aircraft') }} AS lfa
     WHERE lfa.hk_aircraft = a.hk_aircraft) AS total_flights_using_aircraft

FROM {{ ref('link_aircraft_seat') }} las
JOIN {{ ref('hub_aircraft') }} a ON las.hk_aircraft = a.hk_aircraft
JOIN {{ ref('sat_aircraft') }} sa ON a.hk_aircraft = sa.hk_aircraft
JOIN {{ ref('hub_seat') }} s ON las.hk_seat = s.hk_seat
JOIN {{ ref('sat_seat') }} ss ON s.hk_seat = ss.hk_seat