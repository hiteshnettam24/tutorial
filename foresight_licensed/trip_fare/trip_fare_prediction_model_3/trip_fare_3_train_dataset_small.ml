select pickup_datetime, pickup_zipcode, hour_of_day, calendar_day,
       dropoff_zipcode, passenger_count, fare_amount,
       f.hourly_segment, f.is_holiday_or_weekend, f.pickup_geo_area, f.dropoff_geo_area,
       case when f.total_passenger_count_4hr is not null then f.total_passenger_count_4hr else 0 end as total_passenger_count_4hr
from
(
    select pickup_datetime, pickup_zipcode, hour_of_day, calendar_day, dropoff_zipcode, passenger_count, fare_amount,
    {{ contextual_feature_fetch_udf('trip_fare_3_feature_view',
                                    'hourly_segment, is_holiday_or_weekend, pickup_geo_area, dropoff_geo_area, total_passenger_count_4hr') }} f
    from
    (
        select from_utc_timestamp(pickup_datetime, "EST") as pickup_datetime,
               cast(hour(from_utc_timestamp(pickup_datetime, "EST")) as bigint) as hour_of_day,
               Date(from_utc_timestamp(pickup_datetime, "EST")) as calendar_day,
               pickup_zipcode, dropoff_zipcode, passenger_count, fare_amount
        from {{ source('mysql','trip_table') }} limit 2000
    )
) t
