SELECT title
FROM episodes
WHERE SUBSTR(air_date, 6, 2) = '12';
