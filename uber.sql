CREATE DATABASE uber;
USE uber;
SHOW TABLES;
-- USERS
CREATE TABLE users(
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(50) UNIQUE,
  phone VARCHAR(15),
  user_type ENUM('rider','driver') NOT NULL,
  rating DECIMAL(2,1) DEFAULT 0
);

-- DRIVERS (Specialization)
CREATE TABLE drivers(
   driver_id INT PRIMARY KEY,
   license_number VARCHAR(50) NOT NULL,
   status ENUM('active','inactive') DEFAULT 'active',
   FOREIGN KEY (driver_id) REFERENCES users(user_id)
);

-- VEHICLES
CREATE TABLE vehicles(
   vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
   vehicle_name VARCHAR(50),
   vehicle_type VARCHAR(50),
   vehicle_color VARCHAR(50),
   vehicle_model VARCHAR(50),
   vehicle_number VARCHAR(50) UNIQUE,
   driver_id INT,
   FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- RIDES
CREATE TABLE rides(
    ride_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_id INT,
    driver_id INT,
    pickup_location VARCHAR(100),
    dropoff_location VARCHAR(100),
    fare DECIMAL(10,2),
    status ENUM('requested','ongoing','completed','cancelled'),
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP NULL,
    FOREIGN KEY (rider_id) REFERENCES users(user_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- PAYMENTS
CREATE TABLE payments(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT UNIQUE,
    amount DECIMAL(10,2),
    payment_method ENUM('cash','online'),
    payment_status ENUM('paid','unpaid') DEFAULT 'unpaid',
    FOREIGN KEY (ride_id) REFERENCES rides(ride_id)
);

-- REVIEWS
CREATE TABLE reviews(
   review_id INT PRIMARY KEY AUTO_INCREMENT,
   ride_id INT,
   reviewer_id INT,
   rating INT CHECK (rating BETWEEN 1 AND 5),
   comments VARCHAR(255),
   FOREIGN KEY (ride_id) REFERENCES rides(ride_id),
   FOREIGN KEY (reviewer_id) REFERENCES users(user_id)
);


## User table

INSERT INTO users (name, email, phone, user_type, rating) VALUES
('Ali Khan', 'ali@gmail.com', '03001234567', 'rider', 4.5),
('Ahmed Raza', 'ahmed@gmail.com', '03111234567', 'driver', 4.8),
('Sara Ali', 'sara@gmail.com', '03221234567', 'rider', 4.2),
('Usman Tariq', 'usman@gmail.com', '03331234567', 'driver', 4.7),
('Hina Noor', 'hina@gmail.com', '03441234567', 'rider', 4.3);

## User

INSERT INTO drivers (driver_id, license_number, status) VALUES
(2, 'LIC12345', 'active'),
(4, 'LIC67890', 'active');

# Vehical
INSERT INTO vehicles (vehicle_name, vehicle_type, vehicle_color, vehicle_model, vehicle_number, driver_id) VALUES
('Suzuki Alto', 'Car', 'White', '2020', 'ABC-123', 2),
('Toyota Corolla', 'Car', 'Black', '2022', 'XYZ-789', 4);

# rider
INSERT INTO rides (rider_id, driver_id, pickup_location, dropoff_location, fare, status) VALUES
(1, 2, 'Rawalpindi Saddar', 'Islamabad F-10', 500.00, 'completed'),
(3, 4, 'Islamabad G-11', 'Rawalpindi Bahria Town', 700.00, 'completed'),
(5, 2, 'Rawalpindi Stadium', 'Islamabad Blue Area', 450.00, 'ongoing');

# payments

INSERT INTO payments (ride_id, amount, payment_method, payment_status) VALUES
(1, 500.00, 'cash', 'paid'),
(2, 700.00, 'online', 'paid'),
(3, 450.00, 'cash', 'unpaid');

# reviews

INSERT INTO reviews (ride_id, reviewer_id, rating, comments) VALUES
(1, 1, 5, 'Great ride, very comfortable'),
(1, 2, 4, 'Good passenger'),
(2, 3, 4, 'Smooth driving'),
(2, 4, 5, 'Excellent rider');

## 

SELECT * FROM rides WHERE status = 'completed';
#Join: Ride + Driver + Rider
SELECT r.ride_id, u1.name AS rider, u2.name AS driver, r.fare
FROM rides r
JOIN users u1 ON r.rider_id = u1.user_id
JOIN users u2 ON r.driver_id = u2.user_id;

# Total earnings per driver
SELECT d.driver_id, u.name, SUM(r.fare) AS total_earnings
FROM drivers d
JOIN users u ON d.driver_id = u.user_id
JOIN rides r ON d.driver_id = r.driver_id
WHERE r.status = 'completed'
GROUP BY d.driver_id;


## Average rating per user
SELECT reviewer_id, AVG(rating) AS avg_rating
FROM reviews
GROUP BY reviewer_id;


# Get all ride
SELECT * FROM users WHERE user_type = 'rider';

# List all rides with rider & driver names

SELECT r.ride_id, u1.name AS rider, u2.name AS driver, r.fare, r.status
FROM rides r
JOIN users u1 ON r.rider_id = u1.user_id
JOIN users u2 ON r.driver_id = u2.user_id;

# Show completed rides with payment status

SELECT r.ride_id, r.fare, p.payment_status
FROM rides r
JOIN payments p ON r.ride_id = p.ride_id
WHERE r.status = 'completed';

-- Get all reviews with reviewer names

SELECT r.review_id, u.name, r.rating, r.comments
FROM reviews r
JOIN users u ON r.reviewer_id = u.user_id;

-- Total earnings of each driver
SELECT u.name, SUM(r.fare) AS total_earnings
FROM rides r
JOIN users u ON r.driver_id = u.user_id
WHERE r.status = 'completed'
GROUP BY r.driver_id;

#Find top-rated drivers
SELECT name, rating
FROM users
WHERE user_type = 'driver'
ORDER BY rating DESC
LIMIT 3;

show tables;