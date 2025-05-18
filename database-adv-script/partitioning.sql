-- Booking Table Partitioning (Using MySQL/MariaDB syntax)
-- This script implements horizontal partitioning for the Booking table
-- based on the start_date column, using quarterly (3-month) partitions.

-- Step 1: Create partitioned table (partitioned version of the Booking table)
-- Only partition new table if it doesn't already exist
DROP TABLE IF EXISTS bookings_partitioned;

CREATE TABLE bookings_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) 
PARTITION BY RANGE (TO_DAYS(start_date)) (
    -- 2023 Quarterly Partitions
    PARTITION p_2023_Q1 VALUES LESS THAN (TO_DAYS('2023-04-01')),
    PARTITION p_2023_Q2 VALUES LESS THAN (TO_DAYS('2023-07-01')),
    PARTITION p_2023_Q3 VALUES LESS THAN (TO_DAYS('2023-10-01')),
    PARTITION p_2023_Q4 VALUES LESS THAN (TO_DAYS('2024-01-01')),
    
    -- 2024 Quarterly Partitions
    PARTITION p_2024_Q1 VALUES LESS THAN (TO_DAYS('2024-04-01')),
    PARTITION p_2024_Q2 VALUES LESS THAN (TO_DAYS('2024-07-01')),
    PARTITION p_2024_Q3 VALUES LESS THAN (TO_DAYS('2024-10-01')),
    PARTITION p_2024_Q4 VALUES LESS THAN (TO_DAYS('2025-01-01')),
    
    -- 2025 Quarterly Partitions
    PARTITION p_2025_Q1 VALUES LESS THAN (TO_DAYS('2025-04-01')),
    PARTITION p_2025_Q2 VALUES LESS THAN (TO_DAYS('2025-07-01')),
    PARTITION p_2025_Q3 VALUES LESS THAN (TO_DAYS('2025-10-01')),
    PARTITION p_2025_Q4 VALUES LESS THAN (TO_DAYS('2026-01-01')),
    
    -- Future dates partition
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Step 2: Create the same indexes as in the original Booking table (from database_index.sql)
-- Composite index on start_date and end_date for date range queries
CREATE INDEX idx_booking_dates ON bookings_partitioned(start_date, end_date);

-- Index on status field for filtering by booking status
CREATE INDEX idx_booking_status ON bookings_partitioned(status);

-- Composite index on user_id and property_id for join operations
CREATE INDEX idx_booking_user_property ON bookings_partitioned(user_id, property_id);

-- Step 3: Populate the partitioned table with data from the original table
-- This assumes the original bookings table exists and has data
-- In a production environment, you would typically insert data in batches
-- to avoid locking the table for too long
INSERT INTO bookings_partitioned
SELECT * FROM bookings;

-- Step 4: [OPTIONAL] Rename tables if you want to replace the original table
-- This should be done during a maintenance window
-- RENAME TABLE bookings TO bookings_old, bookings_partitioned TO bookings;

-- Step 5: Add partition maintenance procedure
DELIMITER //

CREATE PROCEDURE add_booking_partition(IN partition_name VARCHAR(50), IN start_date DATE, IN end_date DATE)
BEGIN
    SET @alter_stmt = CONCAT(
        'ALTER TABLE bookings_partitioned ADD PARTITION (PARTITION ', 
        partition_name, 
        ' VALUES LESS THAN (TO_DAYS(\'', 
        end_date, 
        '\'))');
        
    PREPARE stmt FROM @alter_stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SELECT CONCAT('Added partition ', partition_name, ' for dates from ', start_date, ' to ', end_date) AS result;
END //

DELIMITER ;

-- Example of how to use the procedure to add new partitions:
-- CALL add_booking_partition('p_2026_Q1', '2026-01-01', '2026-04-01');

-- Explanation of Partitioning Strategy:
/*
This partition strategy splits the booking table into quarterly chunks based on the start_date.
Benefits:
1. Improves query performance for date-range queries which are common in booking systems
2. Allows for easier archiving of old booking data (can drop old partitions)
3. Maintenance operations like index rebuilds can be done on specific partitions
4. Improves concurrent access as locks may only affect relevant partitions

Each quarter is in its own partition, making date range queries that specify
start_date values much faster, as the database can skip scanning partitions
that don't contain relevant data.

The partitioning key (start_date) was chosen because:
1. It's frequently used in WHERE clauses
2. It has a well-defined natural range (calendar quarters)
3. Data distribution is likely even across time periods

The TO_DAYS function converts dates to day numbers, which works well for RANGE partitioning.

The maintenance procedure (add_booking_partition) makes it easy to add new partitions 
as time progresses. This should be scheduled quarterly to ensure future dates
always have appropriate partitions.
*/

