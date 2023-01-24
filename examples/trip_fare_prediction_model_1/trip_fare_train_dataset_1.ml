select from_utc_timestamp(pickup_datetime, "EST") as pickup_datetime,
       pickup_longitude, pickup_latitude, dropoff_longitude, dropoff_latitude,
       pickup_zipcode, dropoff_zipcode, passenger_count, fare_amount
from {{ source('mysql','trip_table') }}
