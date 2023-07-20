select * from trip_fare_1_train_dataset limit {{ var('limit', 'all') }}
using_foresight_options
(
	{
        "query_type": "training",
        "description": "{{ var("description", "trip fare model training") }}",
        "model": { "name": "trip_fare_1_model", "retrain_run_id": {{ var("retrain_run_id", 0) }}},
        "ml_config": 
        {
         "setup":
            {
                "type": "regression",
                "high_cardinality_features": ["pickup_zipcode", "dropoff_zipcode"],
                "categorical_features": ["pickup_zipcode", "dropoff_zipcode"],
                "target": "fare_amount",
                "numeric_features": ["passenger_count"],
                "date_features": ["pickup_datetime"]
            }   
        }
    }
)
