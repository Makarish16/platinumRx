CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(20),
    user_id VARCHAR(50)
);

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10, 2)
);

INSERT INTO users VALUES 
('u001', 'John Doe', '9700000000', 'john@example.com', '123 St'),
('u002', 'Jane Smith', '9800000000', 'jane@example.com', '456 Ave');

INSERT INTO bookings VALUES 
('bk-001', '2021-09-23 07:36:48', 'rm-101', 'u001'),
('bk-002', '2021-11-05 10:00:00', 'rm-102', 'u001'),
('bk-003', '2021-10-15 14:00:00', 'rm-205', 'u002'),
('bk-004', '2021-11-12 09:00:00', 'rm-105', 'u002');

INSERT INTO items VALUES 
('itm-001', 'Tawa Paratha', 18.00),
('itm-002', 'Mix Veg', 89.00),
('itm-003', 'Dal Fry', 120.00);

INSERT INTO booking_commercials VALUES 
('comm-001', 'bk-001', 'bl-001', '2021-09-23 12:00:00', 'itm-001', 3),
('comm-002', 'bk-001', 'bl-001', '2021-09-23 12:00:00', 'itm-002', 1),
('comm-003', 'bk-002', 'bl-002', '2021-11-05 12:00:00', 'itm-003', 2),
('comm-004', 'bk-003', 'bl-003', '2021-10-15 15:00:00', 'itm-002', 20),
('comm-005', 'bk-004', 'bl-004', '2021-11-12 10:00:00', 'itm-001', 5);
