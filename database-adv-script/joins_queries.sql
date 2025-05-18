SELECT b.*, u.first_name, u.last_name, u.email
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;

SELECT p.*, r.review_id, r.rating, r.comment, r.created_at AS review_date
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;

SELECT u.user_id, u.first_name, u.last_name, u.email, 
       b.booking_id, b.property_id, b.start_date, b.end_date, b.status
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id;