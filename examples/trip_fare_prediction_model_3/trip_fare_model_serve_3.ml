select pickup_datetime, hour_of_day, calendar_day,
       pickup_longitude, pickup_latitude, dropoff_longitude, dropoff_latitude,
       pickup_zipcode, dropoff_zipcode, passenger_count
from {{ source("rest", "trip_fare_request_2") }}
using_elevo_options
(
    {
        "query_type": "prediction",
        "featureviews": [{
            "feature_view": "trip_feature_view_3",
            "contextual_features": [
                { "name": "hourly_segment",
                  "timestamp_column": "None"
                },
                { "name": "is_holiday_or_weekend",
                  "timestamp_column": "None"
                },
                { "name": "pickup_geo_area",
                  "timestamp_column": "None"
                },
                { "name": "dropoff_geo_area",
                  "timestamp_column": "None"
                },
                { "name": "total_passenger_count_4hr",
                  "timestamp_column": "None"
                }
            ]
        }],
        "models": [
            {
               "name": "trip_fare_model_3",
               "version":  "1"
            }
        ],
        "results": ["fare_amount"],
        "response_source": "{{ source('rest', 'trip_fare_response_3') }}",
        "log_table_name": "{{ source('elevo', 'fare_prediction_log3') }}"
    }
)
