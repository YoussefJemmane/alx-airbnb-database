INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
(UUID(), 'John', 'Doe', 'john.doe@email.com', 'hash1', '+1234567890', 'host'),
(UUID(), 'Jane', 'Smith', 'jane.smith@email.com', 'hash2', '+1234567891', 'guest'),
(UUID(), 'Admin', 'User', 'admin@airbnb.com', 'hash3', '+1234567892', 'admin'),
(UUID(), 'Sarah', 'Wilson', 'sarah.wilson@email.com', 'hash4', '+1234567893', 'host'),
(UUID(), 'Michael', 'Brown', 'michael.brown@email.com', 'hash5', '+1234567894', 'guest');

INSERT INTO properties (property_id, host_id, name, description, location, pricepernight) VALUES
(UUID(), (SELECT user_id FROM users WHERE email = 'john.doe@email.com'), 
'Beachfront Villa', 'Luxurious villa with ocean view', 'Miami Beach, FL', 299.99),
(UUID(), (SELECT user_id FROM users WHERE email = 'john.doe@email.com'),
'Mountain Cabin', 'Cozy cabin in the woods', 'Aspen, CO', 199.99),
(UUID(), (SELECT user_id FROM users WHERE email = 'sarah.wilson@email.com'),
'City Loft', 'Modern loft in downtown', 'New York, NY', 249.99),
(UUID(), (SELECT user_id FROM users WHERE email = 'sarah.wilson@email.com'),
'Desert Oasis', 'Peaceful retreat with pool', 'Phoenix, AZ', 179.99);

INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
(UUID(), 
(SELECT property_id FROM properties WHERE name = 'Beachfront Villa'),
(SELECT user_id FROM users WHERE email = 'jane.smith@email.com'),
'2025-06-01', '2025-06-07', 1799.94, 'confirmed'),
(UUID(),
(SELECT property_id FROM properties WHERE name = 'Mountain Cabin'),
(SELECT user_id FROM users WHERE email = 'michael.brown@email.com'),
'2025-07-15', '2025-07-20', 999.95, 'pending');

INSERT INTO payments (payment_id, booking_id, amount, payment_method) VALUES
(UUID(),
(SELECT booking_id FROM bookings WHERE user_id = (SELECT user_id FROM users WHERE email = 'jane.smith@email.com')),
1799.94, 'credit_card'),
(UUID(),
(SELECT booking_id FROM bookings WHERE user_id = (SELECT user_id FROM users WHERE email = 'michael.brown@email.com')),
999.95, 'paypal');

INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
(UUID(),
(SELECT property_id FROM properties WHERE name = 'Beachfront Villa'),
(SELECT user_id FROM users WHERE email = 'jane.smith@email.com'),
5, 'Amazing stay! Beautiful ocean views and excellent amenities.'),
(UUID(),
(SELECT property_id FROM properties WHERE name = 'City Loft'),
(SELECT user_id FROM users WHERE email = 'michael.brown@email.com'),
4, 'Great location and modern design. Slightly noisy at night.');

INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
(UUID(),
(SELECT user_id FROM users WHERE email = 'jane.smith@email.com'),
(SELECT user_id FROM users WHERE email = 'john.doe@email.com'),
'Is early check-in possible?'),
(UUID(),
(SELECT user_id FROM users WHERE email = 'john.doe@email.com'),
(SELECT user_id FROM users WHERE email = 'jane.smith@email.com'),
'Yes, you can check in at 2 PM.');