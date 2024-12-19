CREATE DATABASE zomato;
USE zomato;

-- USERS TABLE
-- Stores information about the users of the app.

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

-- Stores details of the restaurants listed on the platform.
-- RESTAURANT TABLE
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    rating FLOAT CHECK (rating >= 0 AND rating <= 5),
    cuisine VARCHAR(50),
    contact VARCHAR(15)
);

select * from Restaurants;

-- MENU ITEM TABLE
-- Stores information about the menu items offered by each restaurant.

CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    description TEXT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

-- ORDERS TABLE
-- Manages information about customer orders.

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    restaurant_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    total_price DECIMAL(8, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

-- ORDERS_ITEM
-- Manages individual items in an order (many-to-many relationship between Orders and Menu_Items).

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(8, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id) ON DELETE CASCADE
);

-- REVIEWS TABLE
-- Stores reviews from users for restaurants.

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    restaurant_id INT,
    rating INT CHECK (rating >= 0 AND rating <= 5),
    comments TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

-- USERS DATA
INSERT INTO Users (username, email, phone, address) VALUES 
('Amit Kumar', 'amit@example.com', '9876543210', '123 Lotus St'),
('Priya Singh', 'priya@example.com', '8765432109', '456 Rose St');

-- RESTAURANT DATA
INSERT INTO Restaurants (name, location, rating, cuisine, contact) VALUES 
('Tandoori House', 'Mumbai', 4.5, 'Indian', '9123456789'),
('Chai Point', 'Pune', 4.8, 'Indian', '9876543210');

-- MENU_ITEMS DATA
INSERT INTO Menu_Items (restaurant_id, item_name, price, description) VALUES 
(1, 'Butter Chicken', 299.99, 'Delicious butter chicken with gravy'),
(1, 'Paneer Tikka', 249.99, 'Spicy grilled paneer tikka'),
(2, 'Masala Chai', 49.99, 'Traditional Indian spiced tea'),
(2, 'Samosa', 29.99, 'Crispy fried pastry with spiced filling');

-- ORDERS DATA
INSERT INTO Orders (user_id, restaurant_id, total_price, status) VALUES 
(1, 1, 549.98, 'Completed'),
(2, 2, 79.98, 'Pending');

-- ORDER_ITEMS DATA
INSERT INTO Order_Items (order_id, item_id, quantity, price) VALUES 
(1, 1, 1, 299.99),
(1, 2, 1, 249.99),
(2, 3, 2, 49.99);

-- REVIEWS DATA
INSERT INTO Reviews (user_id, restaurant_id, rating, comments) VALUES 
(1, 1, 5, 'Excellent food and service! Highly recommended.'),
(2, 2, 4, 'Great chai, but a bit crowded.');


-- 1.Get all restaurants and their average rating:
SELECT name, location, AVG(rating) AS average_rating
FROM Restaurants
JOIN Reviews ON Restaurants.restaurant_id = Reviews.restaurant_id
GROUP BY Restaurants.restaurant_id;

-- 2.Find all menu items of a restaurant:
SELECT item_name, price, description 
FROM Menu_Items 
WHERE restaurant_id = 1;

-- 3.Retrieve all orders by a user:
SELECT Orders.order_id, Restaurants.name AS restaurant_name, Orders.total_price, Orders.status
FROM Orders
JOIN Restaurants ON Orders.restaurant_id = Restaurants.restaurant_id
WHERE Orders.user_id = 1;

-- 4. Display all reviews for a restaurant:
SELECT Users.username, Reviews.rating, Reviews.comments
FROM Reviews
JOIN Users ON Reviews.user_id = Users.user_id
WHERE restaurant_id = 2;

-- 5. Calculate total earnings for each restaurant:
SELECT Restaurants.name, SUM(Orders.total_price) AS total_earnings
FROM Orders
JOIN Restaurants ON Orders.restaurant_id = Restaurants.restaurant_id
WHERE Orders.status = 'Completed'
GROUP BY Restaurants.restaurant_id;
