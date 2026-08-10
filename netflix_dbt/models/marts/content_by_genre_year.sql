WITH split_genres AS (
    SELECT type, release_year, 
        trim(unnest(str_split(listed_in, ','))) AS genre
    FROM {{ ref('stg_netflix_titles') }}
)
SELECT genre, release_year, 
    count(*) as total_titles,
    sum(case when type='Movie' then 1 else 0 end) as movies,
    sum(case when type='TV Show' then 1 else 0 end) as tv_shows
FROM split_genres
GROUP BY genre, release_year
ORDER BY release_year DESC, total_titles DESC