-- models/marts/catalog_growth_over_time.sql
SELECT
    date_trunc('month', strptime(trim(date_added), '%B %d, %Y')) as month_added,
    extract(year from strptime(trim(date_added), '%B %d, %Y')) as year_added,
    count(*) as titles_added,
    sum(case when type = 'Movie' then 1 else 0 end) as movies_added,
    sum(case when type = 'TV Show' then 1 else 0 end) as tv_shows_added,
    round(avg(release_year), 1) as avg_release_year_of_content
FROM {{ ref('stg_netflix_titles') }}
WHERE date_added IS NOT NULL
GROUP BY 1, 2
ORDER BY 1