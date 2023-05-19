select * from {{ source("kafka", "trip_events") }}
using_elevo_options
(
    {
        "query_type": "featureset",
        "entities": ["pickup_zipcode","dropoff_zipcode","pickup_longitude",
                     "pickup_latitude","dropoff_longitude","dropoff_latitude"],
        "min_aggregation_interval": "1h",
        "aggregations": [
        {
            "entities": ["pickup_zipcode"],
            "max_aggregation_window": "1d",
            "aggregates": [
            {
                "name": "sum_passenger_count",
                "function": "sum",
                "source_expr": "passenger_count"
            }]
        }],
        "timestamp_column": "pickup_datetime",
        "backfill_source":["{{ source("aws", "trip_table") }}"],
        "backfill_start_datetime": "2022-10-15 00:00:00.000"
    }
)
