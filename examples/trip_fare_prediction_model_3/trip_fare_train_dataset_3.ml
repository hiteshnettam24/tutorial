select pickup_datetime, pickup_longitude, pickup_latitude, dropoff_longitude, dropoff_latitude, pickup_zipcode, dropoff_zipcode,
       passenger_count, fare_amount,
       f.hourly_segment, f.is_holiday_or_weekend, f.pickup_geo_area, f.dropoff_geo_area,
       case when f.total_passenger_count_4hr is not null then f.total_passenger_count_4hr else 0 end as total_passenger_count_4hr
from
(
    select pickup_datetime, pickup_longitude, pickup_latitude, dropoff_longitude, dropoff_latitude,
           pickup_zipcode, dropoff_zipcode, passenger_count, fare_amount,
    {{ contextual_feature_fetch_udf('trip_feature_view_3',
                                    'hourly_segment, is_holiday_or_weekend, pickup_geo_area, dropoff_geo_area, total_passenger_count_4hr') }} f
    from
    (
        select from_utc_timestamp(pickup_datetime, "EST") as pickup_datetime,
               cast(hour(from_utc_timestamp(pickup_datetime, "EST")) as bigint) as hour_of_day,
               Date(from_utc_timestamp(pickup_datetime, "EST")) as calendar_day,
               pickup_longitude, pickup_latitude,dropoff_longitude, dropoff_latitude,
               pickup_zipcode, dropoff_zipcode, passenger_count, fare_amount
        from {{ source('mysql','trip_table') }}
    )
) t
