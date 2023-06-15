select * from trip_fare_2_train_dataset limit {{ var('row_limit', 'all') }}
using_foresight_options
(
	{
        "query_type": "training",
        "description": "{{ var("description", "trip fare model training") }}",
        "model": { "name": "trip_fare_2_dl_model", "retrain_run_id": {{ var("retrain_run_id", 0) }}},
        "dl_config": {
            "input_features": [
                     { "name": "pickup_zipcode", "type": "category" },
                     { "name": "dropoff_zipcode", "type": "category" },
                     { "name": "passenger_count", "type": "numerical",
                       "preprocessing": {"normalization":"zscore", "missing_value_strategy":"fill_with_mean"} },
                     { "name": "hourly_segment", "type": "category" },
                     { "name": "is_holiday_or_weekend", "type": "numerical" },
                     { "name": "pickup_geo_area", "type": "category" },
                     { "name": "dropoff_geo_area", "type": "category" }
            ],
            "output_features": [
              { "name": "fare_amount", "type": "numerical",
                "num_fc_layers":4, "fc_size":128, "norm":"batch"}
            ],
            "trainer" : {
                "batch_size": 1024,
                "epochs": 150,
                "early_stop": 10,
                "learning_rate": 0.001,
                "optimizer": {"type": "adam"}
            }
        }
    }
)
