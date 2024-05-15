SELECT username
FROM users
WHERE id = (
    SELECT to_user_id
    FROM messages
    JOIN users ON users.id = messages.to_user_id
    GROUP BY to_user_id
    ORDER BY COUNT(to_user_id) DESC,users.username
    LIMIT 1
);
