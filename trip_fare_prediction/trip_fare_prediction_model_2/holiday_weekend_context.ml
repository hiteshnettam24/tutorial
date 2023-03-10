select * from {{ source("mysql", "holiday_weekend_context") }}
using_elevo_options
(
    {
        "query_type": "featureset",
        "entities": ["calendar_day"]
    }
)
