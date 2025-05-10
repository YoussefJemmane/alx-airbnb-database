# AirBnB Clone Database

A MySQL database schema implementation for an AirBnB-like platform.

## 📋 Database Schema Overview

This database supports the core functionalities of a property rental platform, including:
- User management (hosts, guests, admins)
- Property listings
- Bookings
- Payment processing
- Reviews
- Messaging system

### Tables Structure

1. **Users**
   - Manages user accounts and roles
   - Stores personal information and authentication data
   - Supports multiple user roles (guest, host, admin)

2. **Properties**
   - Contains property listings information
   - Links properties to their hosts
   - Stores pricing and location details

3. **Bookings**
   - Handles reservation management
   - Tracks booking status and dates
   - Calculates total pricing

4. **Payments**
   - Records payment transactions
   - Supports multiple payment methods
   - Links payments to specific bookings

5. **Reviews**
   - Stores property reviews and ratings
   - Links reviews to properties and users
   - Implements rating constraints (1-5)

6. **Messages**
   - Facilitates communication between users
   - Supports direct messaging functionality