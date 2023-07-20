select * from trip_fare_2_train_dataset limit {{ var('limit', 'all') }}
using_foresight_options
(
	{
        "query_type": "training",
        "description": "{{ var("description", "trip fare model training") }}",
        "model": { "name": "trip_fare_2_ml_model", "retrain_run_id": {{ var("retrain_run_id", 0) }}},
        "ml_config": 
        {
         "setup":
            {
                "type": "regression",
                "high_cardinality_features": ["pickup_zipcode", "dropoff_zipcode"],
                "target": "fare_amount",
                "numeric_features": ["passenger_count","is_holiday_or_weekend"],
                "categorical_features": ["pickup_zipcode","dropoff_zipcode","hourly_segment","pickup_geo_area","dropoff_geo_area"],
                "date_features": ["pickup_datetime"]
            }   
        }
    }
)
