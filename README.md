# 🚗 Ride Sharing System Database (Uber/Careem Clone)

## 📌 Project Overview

This project is a **relational database design** for a Ride Sharing System similar to Uber or Careem.
It demonstrates real-world database concepts including:

* Entity-Relationship Design (ERD)
* Normalization
* Foreign Key Constraints
* Joins & Complex Queries
* Real-world data simulation

---

## 🧱 Database Schema

The database consists of the following tables:

### 👤 Users

Stores all users (riders & drivers)

* `user_id` (Primary Key)
* `name`
* `email`
* `phone`
* `user_type` (rider/driver)
* `rating`

---

### 🚘 Drivers

Specialized table for drivers

* `driver_id` (PK, FK → users.user_id)
* `license_number`
* `status`

---

### 🚗 Vehicles

Stores vehicle details of drivers

* `vehicle_id` (Primary Key)
* `vehicle_name`
* `vehicle_type`
* `vehicle_color`
* `vehicle_model`
* `vehicle_number`
* `driver_id` (FK)

---

### 🛣️ Rides

Stores ride details

* `ride_id` (Primary Key)
* `rider_id` (FK → users)
* `driver_id` (FK → drivers)
* `pickup_location`
* `dropoff_location`
* `fare`
* `status`
* `start_time`
* `end_time`

---

### 💳 Payments

Stores payment information

* `payment_id` (Primary Key)
* `ride_id` (FK)
* `amount`
* `payment_method`
* `payment_status`

---

### ⭐ Reviews

Stores ratings and feedback

* `review_id` (Primary Key)
* `ride_id` (FK)
* `reviewer_id` (FK → users)
* `rating`
* `comments`

---

## 🛠️ Setup Instructions

### 1️⃣ Create Database

```sql
CREATE DATABASE uber;
USE uber;
```

### 2️⃣ Run Table Creation Script

Execute all `CREATE TABLE` queries provided in the SQL file.

### 3️⃣ Insert Sample Data

Run all `INSERT INTO` queries to populate the database.

---

## 📊 Sample Data Included

The dataset includes:

* 5 Users (Riders & Drivers)
* 2 Drivers
* 2 Vehicles
* 3 Rides
* Payments & Reviews

---

## 🔍 Example Queries

### ✅ Get Completed Rides

```sql
SELECT * FROM rides WHERE status = 'completed';
```

---

### 🔗 Join: Rider & Driver Details

```sql
SELECT r.ride_id, u1.name AS rider, u2.name AS driver, r.fare
FROM rides r
JOIN users u1 ON r.rider_id = u1.user_id
JOIN users u2 ON r.driver_id = u2.user_id;
```

---

### 💰 Total Earnings per Driver

```sql
SELECT u.name, SUM(r.fare) AS total_earnings
FROM rides r
JOIN users u ON r.driver_id = u.user_id
WHERE r.status = 'completed'
GROUP BY r.driver_id;
```

---

### ⭐ Average Rating per User

```sql
SELECT reviewer_id, AVG(rating) AS avg_rating
FROM reviews
GROUP BY reviewer_id;
```

---

### 🏆 Top Rated Drivers

```sql
SELECT name, rating
FROM users
WHERE user_type = 'driver'
ORDER BY rating DESC
LIMIT 3;
```

---

## 🚀 Advanced Features (Conceptual)

This project can be extended with:

* 🔁 Transactions (Ride booking consistency)
* ⚡ Triggers (Auto-update ratings)
* 📍 Geolocation (latitude/longitude)
* 📈 Reports (monthly revenue, active users)
* 🔐 Authentication system (backend integration)

---

## 🎯 Learning Outcomes

By working on this project, you will understand:

* Database normalization
* One-to-Many relationships
* Foreign key constraints
* SQL joins and aggregations
* Real-world database design

---

## 🧠 Future Improvements

* Add indexes for performance
* Implement stored procedures
* Build REST API (Node.js / Django)
* Connect with frontend (React)

---

## 👨‍💻 Author

**Your Name Here**

---

## ⭐ Support

If you found this project helpful:

* ⭐ Star this repo
* 🍴 Fork it
* 🧑‍💻 Contribute improvements

---
