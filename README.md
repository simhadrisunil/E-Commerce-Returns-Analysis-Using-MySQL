# 📦 E-Commerce Returns Analysis Using MySQL

This project explores return patterns, customer behavior, product issues, and delivery delay impacts in an e-commerce environment. All data processing, modeling, and analysis were done using **pure SQL (MySQL)**.

---

## 🧠 Objective

To answer key business questions like:
- What is the return rate across the business?
- Which products and categories are returned most?
- What reasons are cited for returns?
- How do delivery delays influence return behavior?
- Which customers return the most?

---

## 🧰 Tools Used

- 🛢️ **MySQL**
- 📄 Sample CSV data (manually prepared for the project)
- 💻 MySQL Workbench / CLI

---

## 🧱 Database Schema

Database: `ecommerce_returns`  
Tables created:

- `Customers` – customer info, location, age group
- `Products` – product catalog with brand, category, pricing
- `Orders` – order details with quantity and total price
- `Returns` – return date, reason, and status
- `Delivery` – delivery delay, courier partner, delivery status

---

## 🏗️ Sample SQL Work

### ✅ Create Database & Tables
```sql
CREATE DATABASE ecommerce_returns;
USE ecommerce_returns;

CREATE TABLE Customers (...);
CREATE TABLE Products (...);
CREATE TABLE Orders (...);
CREATE TABLE Returns (...);
CREATE TABLE Delivery (...);

