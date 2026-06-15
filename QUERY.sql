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