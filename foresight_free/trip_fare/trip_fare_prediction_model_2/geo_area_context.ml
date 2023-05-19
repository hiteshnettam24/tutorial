select * from {{ source("aws", "geo_area_context") }}
using_elevo_options
(
    {
        "query_type": "featureset",
        "entities": ["zipcode"]
    }
)
