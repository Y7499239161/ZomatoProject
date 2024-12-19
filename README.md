# Zomato SQL Project

# Welcome to the Zomato Management System! This project is a comprehensive SQL-based application designed to manage various aspects of a food delivery system, similar to popular platforms like Zomato. The system allows for efficient handling of user details, restaurant information, menu items, orders, and reviews.

# Features :
User Management: Handle user registration, login, and profile management.
Restaurant Management: Manage restaurant details, including name, location, cuisine, and contact information.
Menu Management: Add, update, and delete menu items with descriptions and prices.
Order Processing: Create and manage orders, including order items and their quantities.
Reviews and Ratings: Allow users to review and rate restaurants.

# Database Schema
The project includes the following tables:

# Users
user_id (INT, Primary Key, Auto Increment)
username (VARCHAR)
email (VARCHAR)
phone (VARCHAR)
address (VARCHAR)

# Restaurants
restaurant_id (INT, Primary Key, Auto Increment)
name (VARCHAR)
location (VARCHAR)
rating (DECIMAL)
cuisine (VARCHAR)
contact (VARCHAR)

# Menu_Items
item_id (INT, Primary Key, Auto Increment)
restaurant_id (INT, Foreign Key)
item_name (VARCHAR)
price (DECIMAL)
description (VARCHAR)

# Orders
order_id (INT, Primary Key, Auto Increment)
user_id (INT, Foreign Key)
restaurant_id (INT, Foreign Key)
order_date (DATETIME)
status (ENUM)
total_price (DECIMAL)

# Order_Items
order_item_id (INT, Primary Key, Auto Increment)
order_id (INT, Foreign Key)
item_id (INT, Foreign Key)
quantity (INT)
price (DECIMAL)

# Reviews
review_id (INT, Primary Key, Auto Increment)
user_id (INT, Foreign Key)
restaurant_id (INT, Foreign Key)
rating (INT)
comments (TEXT)
