WITH split_countries AS (
    SELECT show_id, type,
        trim(unnest(str_split(country,','))) as country
    FROM {{ ref('stg_netflix_titles')}}
)
SELECT country,count(*) as total_titles,
    sum(case when type='Movie' then 1 else 0 end) as movies,
    sum(case when type='TV Show' then 1 else 0 end) as tv_shows,
FROM split_countries
WHERE country!='Unknown'
GROUP BY country
ORDER BY total_titles DESC