select * from {{ source("mysql", "holiday_weekend_context") }}
using_elevo_options
(
    {
        "query_type": "featureset",
        "featureset_name": "holiday_weekend_context",
        "entities": ["calendar_day"]
    }
)
