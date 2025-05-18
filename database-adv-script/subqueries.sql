SELECT p.*
FROM properties p
WHERE 4.0 < (
    SELECT AVG(r.rating)
    FROM reviews r
    WHERE r.property_id = p.property_id
);

SELECT u.*
FROM users u
WHERE 3 < (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
);