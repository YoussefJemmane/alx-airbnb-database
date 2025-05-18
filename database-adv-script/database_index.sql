-- Database Indexes for Optimization

-- User Table Indexes
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_role ON users(role);

-- Property Table Indexes
CREATE INDEX idx_property_location ON properties(location);
CREATE INDEX idx_property_price ON properties(pricepernight);
CREATE INDEX idx_property_host ON properties(host_id);

-- Booking Table Indexes
CREATE INDEX idx_booking_dates ON bookings(start_date, end_date);
CREATE INDEX idx_booking_status ON bookings(status);
CREATE INDEX idx_booking_user_property ON bookings(user_id, property_id);

-- Review Table Indexes
CREATE INDEX idx_review_property ON reviews(property_id);
CREATE INDEX idx_review_rating ON reviews(rating);
