-- Complex query that retrieves all bookings with user, property, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.created_at AS booking_created_at,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone,
    
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    p.bedrooms,
    p.bathrooms,
    
    pm.payment_id,
    pm.amount,
    pm.payment_date,
    pm.payment_method,
    pm.status AS payment_status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pm ON b.booking_id = pm.booking_id
ORDER BY 
    b.start_date DESC;
