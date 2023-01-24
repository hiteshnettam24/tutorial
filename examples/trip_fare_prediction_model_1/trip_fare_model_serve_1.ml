select pickup_datetime, pickup_longitude, pickup_latitude, dropoff_longitude, dropoff_latitude,
       pickup_zipcode, dropoff_zipcode, passenger_count
from {{ source("rest", "trip_fare_request_1") }}
using_elevo_options
(
    {
        "query_type": "prediction",
        "models": [
            {
            "name": "trip_fare_model_1",
            "version":  "1"
            }
        ],
        "results": ["fare_amount"],
        "response_source": "{{ source('rest', 'trip_fare_response_1') }}",
        "log_table_name": "{{ source('elevo', 'fare_prediction_log1') }}"
    }
)
