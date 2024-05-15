WITH PlayerRanks AS (
    SELECT
        players.first_name,
        players.last_name,
        salaries.salary / performances.H AS dollars_per_hit,
        salaries.salary / performances.RBI AS dollars_per_rbi
    FROM
        players
    JOIN
        salaries ON players.id = salaries.player_id
    JOIN
        performances ON players.id = performances.player_id
    WHERE
        performances.year = 2001
        AND performances.H > 0 -- Exclude players with 0 hits
        AND performances.RBI > 0 -- Exclude players with 0 RBIs
)
SELECT
    first_name,
    last_name
FROM
    PlayerRanks
ORDER BY
    dollars_per_hit ASC,
    dollars_per_rbi ASC,
    players.id ASC
LIMIT 10;
