select * from {{ source("mysql", "hour_of_day_context") }}
using_elevo_options
(
    {
        "query_type": "featureset",
        "entities": ["hour_of_day"]
    }
)
