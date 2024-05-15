SELECT
    performances.year,
    performances.HR
FROM
    performances
JOIN
    players ON players.id = performances.player_id
WHERE
    (players.first_name = 'Ken' AND players.last_name = 'Griffey' AND players.birth_year = 1969)
    OR
    (performances.player_id = (
        SELECT
            id
        FROM
            players
        WHERE
            first_name = 'Ken' AND last_name = 'Griffey' AND birth_year = 1969
    ))
ORDER BY
    performances.year DESC;
