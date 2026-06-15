# ⚽ Football Ticket Booking System

> **Database Design & SQL Queries** — Apollo Level 2 Web Development (Assignment B7A3)

A simplified **Football Ticket Booking System** database that manages football fans,
tournament matches, and individual ticket booking transactions. This project
demonstrates ERD design, relational integrity, and intermediate-to-advanced SQL queries.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [ERD Diagram](#-erd-diagram)
- [Database Schema](#-database-schema)
- [Relationships](#-relationships)
- [SQL Queries](#-sql-queries)
- [Theory Questions](#-theory-questions)
- [Tech Stack](#-tech-stack)
- [How to Run](#-how-to-run)

---

## 🎯 Overview

The system handles three core entities:

| Entity | Description |
|--------|-------------|
| **Users** | Administrative staff and football fans who use the platform. |
| **Matches** | Tournament events, fixtures, and baseline ticket pricing. |
| **Bookings** | Individual ticket purchases linking a user to a match. |

---

## 🗺️ ERD Diagram

📌 **View the full ERD here:**
👉 [Football Ticket Booking System — ERD](https://drive.google.com/file/d/1XtTbVLzv9AvTrdpWfh5QEsz80RoyHbN-/view)

---

## 🧱 Database Schema

### 1️⃣ Users Table
| Field | Description |
|-------|-------------|
| `user_id` (PK) | Unique ID for each registered user. |
| `full_name` | First and last name of the user. |
| `email` (UNIQUE) | Email address used for login. |
| `role` | Access role (`Ticket Manager` / `Football Fan`). |
| `phone_number` | Contact mobile number. |

### 2️⃣ Matches Table
| Field | Description |
|-------|-------------|
| `match_id` (PK) | Unique ID for each match. |
| `fixture` | Competing teams (e.g., Real Madrid vs Barcelona). |
| `tournament_category` | League/cup title. |
| `base_ticket_price` | Foundational price per standard seat. |
| `match_status` | `Available` / `Selling Fast` / `Sold Out` / `Postponed`. |

### 3️⃣ Bookings Table
| Field | Description |
|-------|-------------|
| `booking_id` (PK) | Unique transaction ID for the purchase. |
| `user_id` (FK → Users) | The user who made the booking. |
| `match_id` (FK → Matches) | The match being attended. |
| `seat_number` | Allocated stadium seat (e.g., A-12). |
| `payment_status` | `Pending` / `Confirmed` / `Cancelled` / `Refunded`. |
| `total_cost` | Final invoice price. |

---

## 🔗 Relationships

- **One to Many:** One `User` → Many `Bookings` (a fan can book many matches).
- **Many to One:** Many `Bookings` → One `Match` (a match can have many bookings).
- **One to One (logical):** Each booking row maps exactly one user to one match for a specific seat.

> Foreign keys enforce **referential integrity** — no booking can reference a non-existent user or match.

---

## 💾 SQL Queries

All queries are available in **[`QUERY.sql`](./QUERY.sql)**.

| # | Query Description | Key Concepts |
|---|-------------------|--------------|
| 1 | Champions League matches that are `Available` | `WHERE`, `AND` |
| 2 | Users whose name starts with 'Tanvir' or contains 'Haque' | `LIKE`, `ILIKE` |
| 3 | Bookings with missing payment status → 'Action Required' | `IS NULL`, `COALESCE` |
| 4 | Booking details with user name & fixture | `INNER JOIN` |
| 5 | All users + their bookings (including fans with none) | `LEFT JOIN` |
| 6 | Bookings costing more than the average | Subquery, `AVG()` |
| 7 | Top 2 expensive matches (skipping the highest) | `ORDER BY`, `LIMIT`, `OFFSET` |

---

## 🧠 Theory Questions

Answers to the viva theory questions are demonstrated in the recorded interview video.
*(See submission portal for the video link.)*

---

## 🛠️ Tech Stack

- **Database:** PostgreSQL
- **Language:** SQL (DDL + DML)

---

## ▶️ How to Run

1. Create the database in PostgreSQL.
2. Run the table-creation and data-seeding script.
3. Execute the queries from `QUERY.sql` one by one to verify the expected output.

```bash
psql -U your_username -d your_database -f QUERY.sql
```

---

## ✍️ Author

**Ehtisamul Haque**
Apollo Level 2 — Web Development Batch

---

⭐ *If you found this useful, consider giving the repo a star!*
