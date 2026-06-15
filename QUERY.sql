-- =========================================================================
-- Query 1: Champions League-এর 'Available' ম্যাচসমূহ
-- =========================================================================
SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';


-- =========================================================================
-- Query 2: full_name যেগুলো 'Tanvir' দিয়ে শুরু অথবা 'Haque' ধারণ করে
-- Concepts: LIKE, ILIKE (case-insensitive)
-- =========================================================================
SELECT user_id, full_name, email
FROM Users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';


-- =========================================================================
-- Query 3: payment_status NULL → 'Action Required'
-- Concepts: IS NULL, COALESCE
-- =========================================================================
SELECT booking_id,
       user_id,
       match_id,
       COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;


-- =========================================================================
-- Query 4: Booking + User full_name + Match fixture
-- Concepts: INNER JOIN
-- =========================================================================
SELECT b.booking_id,
       u.full_name,
       m.fixture,
       b.total_cost
FROM Bookings b
INNER JOIN Users u   ON b.user_id  = u.user_id
INNER JOIN Matches m ON b.match_id = m.match_id;


-- =========================================================================
-- Query 5: সকল user ও তাদের booking_id (টিকিট না কিনলেও তালিকায় থাকবে)
-- Concepts: LEFT JOIN
-- =========================================================================
SELECT u.user_id,
       u.full_name,
       b.booking_id
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id
ORDER BY u.user_id;


-- =========================================================================
-- Query 6: total_cost যেগুলো গড় (average) total_cost-এর চেয়ে বেশি
-- Concepts: Subquery, Aggregate (AVG)
-- =========================================================================
SELECT booking_id,
       match_id,
       total_cost
FROM Bookings
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);


-- =========================================================================
-- Query 7: সবচেয়ে দামি ম্যাচটি বাদ দিয়ে পরবর্তী টপ ২টি দামি ম্যাচ
-- Concepts: ORDER BY, LIMIT, OFFSET
-- =========================================================================
SELECT match_id,
       fixture,
       base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;










-- =========================================================================
--Beekeper all table create and queryy excutue process
--1st to last create table and insert data then execute the above query one by one
-- =========================================================================



CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  role VARCHAR(50) NOT NULL,
  phone_number VARCHAR(20)
);


CREATE TABLE matches (
  match_id SERIAL PRIMARY KEY,
  fixture VARCHAR(150) NOT NULL,
  tournament_category VARCHAR(100) NOT NULL,
  base_ticket_price NUMERIC(10, 2) NOT NULL,
  match_status VARCHAR(50) NOT NULL
);



CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  match_id INT REFERENCES matches(match_id),
  seat_number VARCHAR(20),
  payment_status VARCHAR(50),
  total_cost NUMERIC(10, 2) NOT NULL
);


INSERT INTO users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80, 'Available');



INSERT INTO bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150),
(502, 1, 102, 'B-04', 'Confirmed', 120),
(503, 2, 101, 'A-13', 'Confirmed', 150),
(504, 2, 101, NULL, NULL, 150),
(505, 3, 102, 'C-20', 'Pending', 120);

select * from matches

SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';


select * from users ;

SELECT user_id, full_name, email
FROM Users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';

select * from bookings ;

SELECT booking_id,
       user_id,
       match_id,
       COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;



SELECT b.booking_id,
       u.full_name,
       m.fixture,
       b.total_cost
FROM Bookings b
INNER JOIN Users u   ON b.user_id  = u.user_id
INNER JOIN Matches m ON b.match_id = m.match_id;


SELECT u.user_id,
       u.full_name,
       b.booking_id
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id
ORDER BY u.user_id;



SELECT booking_id,
       match_id,
       total_cost
FROM Bookings
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);


SELECT match_id,
       fixture,
       base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;