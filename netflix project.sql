CREATE TABLE netflix_titles (
    show_id         TEXT,
    type            TEXT,
    title           TEXT,
    director        TEXT,
    "cast"          TEXT,
    country         TEXT,
    date_added      TEXT,
    release_year    INT,
    rating          TEXT,
    duration        TEXT,
    listed_in       TEXT,
    description     TEXT
);
--create a clean view--
CREATE OR REPLACE VIEW netflix_clean AS
SELECT
    show_id,
    type,
    title,
    director,
    "cast",
    country,
    to_date(date_added, 'Month DD, YYYY') AS date_added,
    release_year,
    rating,
    duration,
    listed_in,
    description
FROM netflix_titles;

--Q1. Count the number of Movies vs TV Shows--
SELECT type, COUNT(*) AS total
FROM netflix_clean
GROUP BY type;

--Q2. Find the most common rating for movies AND for TV shows--
SELECT type, rating, COUNT(*) AS total
FROM netflix_clean
WHERE rating IS NOT NULL
GROUP BY type, rating
ORDER BY type, total DESC;

--Q3. List all movies released in a specific year (example 2020)--
SELECT title, release_year
FROM netflix_clean
WHERE type = 'Movie'
  AND release_year = 2020
ORDER BY title;

--Q4. Top 5 countries with the most content--
WITH c AS (
    SELECT trim(unnest(string_to_array(country, ','))) AS country
    FROM netflix_clean
)
SELECT country, COUNT(*) AS total_titles
FROM c
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;

--Q5. Identify the longest movie--
SELECT title, duration
FROM netflix_clean
WHERE type = 'Movie'
ORDER BY CAST(replace(duration,' min','') AS INT) DESC
LIMIT 1;

--Q6. Find content added in last 5 years--
SELECT *
FROM netflix_clean
WHERE date_added >= CURRENT_DATE - INTERVAL '5 years'
ORDER BY date_added DESC;

--Q7. All content by director “Rajiv Chilaka”--
SELECT *
FROM netflix_clean
WHERE director LIKE '%Rajiv Chilaka%'
ORDER BY release_year DESC;

--Q8. TV shows with more than 5 seasons--
SELECT title, duration
FROM netflix_clean
WHERE type = 'TV Show'
  AND duration ILIKE '%Season%'
  AND CAST(
        replace(
           replace(duration,' Seasons',''),
        ' Season',''
        ) AS INT
      ) > 5
ORDER BY CAST(
        replace(
           replace(duration,' Seasons',''),
        ' Season',''
        ) AS INT
      ) DESC;

--Q9. Count content items in each genre--
WITH g AS (
    SELECT trim(unnest(string_to_array(listed_in, ','))) AS genre
    FROM netflix_clean
)
SELECT genre, COUNT(*) AS total_titles
FROM g
GROUP BY genre
ORDER BY total_titles DESC;

--Q10. top 5 years with highest average monthly releases in India--
WITH india AS (
    SELECT date_trunc('month', date_added) AS ym
    FROM netflix_clean
    WHERE country ILIKE '%India%'
),
monthly AS (
    SELECT EXTRACT(YEAR FROM ym) AS yr, COUNT(*) AS cnt
    FROM india
    GROUP BY ym
),
avg_per_year AS (
    SELECT yr, AVG(cnt) AS avg_monthly
    FROM monthly
    GROUP BY yr
)
SELECT yr, avg_monthly
FROM avg_per_year
ORDER BY avg_monthly DESC
LIMIT 5;

--Q11. List all movies that are documentaries--
SELECT *
FROM netflix_clean
WHERE type = 'Movie'
  AND listed_in LIKE '%Documentaries%';

--Q12. Content without director--
SELECT *
FROM netflix_clean
WHERE director IS NULL OR director = '';

--Q13. How many movies Salman Khan appeared in last 10 years--
SELECT COUNT(*) AS total_salman
FROM netflix_clean
WHERE type = 'Movie'
  AND "cast" LIKE '%Salman Khan%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

--Q14. Top 10 actors who acted in the most Indian movies--
WITH india_movies AS (
    SELECT "cast"
    FROM netflix_clean
    WHERE type = 'Movie' AND country ILIKE '%India%'
),
actors AS (
    SELECT trim(unnest(string_to_array("cast", ','))) AS actor
    FROM india_movies
)
SELECT actor, COUNT(*) AS movie_count
FROM actors
GROUP BY actor
ORDER BY movie_count DESC
LIMIT 10;

--Q15. Categorize content by “kill” or “violence” keywords--
SELECT
    CASE
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS total
FROM netflix_clean
GROUP BY category;







