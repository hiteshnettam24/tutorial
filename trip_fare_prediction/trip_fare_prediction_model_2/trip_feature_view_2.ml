select * from trip_feature_view_2
using_elevo_options
(
    {
        "query_type": "featureview",
        "feature_view": "trip_feature_view_2",
        "serve_mode": "{{ var("serve_mode", "online") }}",
        "features": [
        {
            "feature_name": "is_holiday_or_weekend",
            "featureset_name": "holiday_weekend_context",
            "source_features": ["is_holiday_or_weekend"]
        },
        {
            "feature_name": "hourly_segment",
            "featureset_name": "hour_of_day_context",
            "source_features": ["hourly_segment"]
        },
        {
            "feature_name": "pickup_geo_area",
            "featureset_name": "geo_area_context",
            "source_features": ["geo_area"],
            "entity_key_map": {"pickup_zipcode": "zipcode"}
        },
        {
            "feature_name": "dropoff_geo_area",
            "featureset_name": "geo_area_context",
            "source_features": ["geo_area"],
            "entity_key_map": {"dropoff_zipcode": "zipcode"}
        }]
    }
)
