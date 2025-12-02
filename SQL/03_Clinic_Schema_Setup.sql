#Create Tables 
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10, 2),
    datetime DATETIME
);

INSERT INTO clinics VALUES 
('cnc-001', 'Apollo Bandra', 'Mumbai', 'Maharashtra', 'India'),
('cnc-002', 'Fortis Mulund', 'Mumbai', 'Maharashtra', 'India'),
('cnc-003', 'Max Saket', 'New Delhi', 'Delhi', 'India'),
('cnc-004', 'Apollo Delhi', 'New Delhi', 'Delhi', 'India');

INSERT INTO customer VALUES 
('cust-001', 'Jon Doe', '9700000001'),
('cust-002', 'Alice Smith', '9700000002'),
('cust-003', 'Bob Brown', '9700000003');

INSERT INTO clinic_sales VALUES 
('ord-001', 'cust-001', 'cnc-001', 5000, '2021-09-23 12:00:00', 'Online'),
('ord-002', 'cust-002', 'cnc-001', 3000, '2021-09-25 14:00:00', 'WalkIn'),
('ord-003', 'cust-001', 'cnc-002', 12000, '2021-09-26 10:00:00', 'Referral'), 
('ord-004', 'cust-003', 'cnc-003', 7000, '2021-09-28 11:00:00', 'Online'),
('ord-005', 'cust-002', 'cnc-004', 2000, '2021-09-29 09:00:00', 'WalkIn'),
('ord-006', 'cust-001', 'cnc-001', 15000, '2021-10-01 12:00:00', 'Online'),
('ord-007', 'cust-003', 'cnc-002', 4000, '2021-10-05 16:00:00', 'Online');

INSERT INTO expenses VALUES 
('exp-001', 'cnc-001', 'Medical Supplies', 2000, '2021-09-23 08:00:00'),
('exp-002', 'cnc-002', 'Staff Salary', 8000, '2021-09-24 08:00:00'), 
('exp-003', 'cnc-003', 'Rent', 3000, '2021-09-25 09:00:00'),
('exp-004', 'cnc-004', 'Maintenance', 1500, '2021-09-26 10:00:00');
