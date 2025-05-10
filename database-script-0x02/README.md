# Database Seeding Scripts

This directory contains scripts for populating the AirBnB Clone database with sample data.

## 📋 Overview

The `seed.sql` script populates the database with realistic test data including:
- Users (hosts, guests, and admin)
- Property listings
- Bookings and reservations
- Payment records
- Property reviews
- User messages

## 📊 Sample Data Summary

### Users
- 2 Hosts: John Doe, Sarah Wilson
- 2 Guests: Jane Smith, Michael Brown
- 1 Admin: Admin User

### Properties
- Beachfront Villa (Miami Beach) - $299.99/night
- Mountain Cabin (Aspen) - $199.99/night
- City Loft (New York) - $249.99/night
- Desert Oasis (Phoenix) - $179.99/night

### Sample Transactions
- 2 Bookings (confirmed and pending)
- 2 Payment records
- 2 Property reviews
- 2 User messages

## 🔍 Data Relationships

- Properties are linked to host users
- Bookings connect guests to properties
- Payments are associated with specific bookings
- Reviews are tied to properties and users
- Messages maintain sender-recipient relationships

## ⚠️ Important Notes

- All IDs are generated using UUID()
- Passwords are stored as placeholder hashes
- Dates are set in the future (2025)
- All monetary values use DECIMAL(10,2) format
- Foreign key relationships are maintained throughout