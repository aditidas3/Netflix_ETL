SELECT 
    show_id,
    type,
    title,
    coalesce(director, 'Unknown') as director,
    coalesce("cast", 'Unknown') as "cast",
    coalesce(country, 'Unknown') as country,
    date_added,
    release_year,
    rating,
    case when "type"='Movie'
        then try_cast(split_part(duration, ' ', 1) as integer)
    end as time_duration,
    case when "type"='TV Show'
        then try_cast(split_part(duration,' ', 1) as integer)
    end as season_duration,
    listed_in,
    description
FROM {{ source('bronze','netflix_titles') }}