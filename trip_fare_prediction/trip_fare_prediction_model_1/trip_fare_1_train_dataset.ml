select from_utc_timestamp(pickup_datetime, "EST") as pickup_datetime,
       pickup_zipcode, dropoff_zipcode, passenger_count, fare_amount
from {{ source('mysql','trip_table') }}
