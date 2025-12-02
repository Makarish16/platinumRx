-- Q1: For every user, get user_id and last booked room_no
SELECT u.user_id, b.room_no 
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(booking_date) 
    FROM bookings b2 
    WHERE b2.user_id = u.user_id
);

-- Q2: Booking_id and total billing amount for November 2021
SELECT 
    b.booking_id, 
    SUM(bc.item_quantity * i.item_rate) as total_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE b.booking_date BETWEEN '2021-11-01' AND '2021-11-30 23:59:59'
GROUP BY b.booking_id;

-- Q3: Bill_id and amount for bills in October 2021 > 1000
SELECT 
    bc.bill_id, 
    SUM(bc.item_quantity * i.item_rate) as bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date BETWEEN '2021-10-01' AND '2021-10-31 23:59:59'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- Q4: Most and least ordered item of each month of year 2021
WITH ItemCounts AS (
    SELECT 
        MONTH(bc.bill_date) as mth,
        i.item_name,
        COUNT(*) as frequency
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), i.item_name
),
RankedItems AS (
    SELECT 
        mth, 
        item_name, 
        frequency,
        RANK() OVER (PARTITION BY mth ORDER BY frequency DESC) as rank_most,
        RANK() OVER (PARTITION BY mth ORDER BY frequency ASC) as rank_least
    FROM ItemCounts
)
SELECT mth, 'Most Ordered' as type, item_name FROM RankedItems WHERE rank_most = 1
UNION
SELECT mth, 'Least Ordered' as type, item_name FROM RankedItems WHERE rank_least = 1;

-- Q5: Customers with the second highest bill value of each month of 2021
WITH BillTotals AS (
    SELECT 
        MONTH(bc.bill_date) as mth,
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) as total_bill
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), b.user_id, bc.bill_id
),
RankedBills AS (
    SELECT 
        mth, 
        user_id, 
        total_bill,
        DENSE_RANK() OVER (PARTITION BY mth ORDER BY total_bill DESC) as rnk
    FROM BillTotals
)
SELECT mth, user_id, total_bill 
FROM RankedBills 
WHERE rnk = 2;
