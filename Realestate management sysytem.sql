CREATE DATABASE REALESTATE_MANAGEMENT_SYSTEM;
USE REALESTATE_MANAGEMENT_SYSTEM;

CREATE TABLE Agents (
    AgentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    JoinDate DATE,
    CommissionRate DECIMAL(5,2),
    Status ENUM('Active', 'Inactive') DEFAULT 'Active'
);

CREATE TABLE Clients (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    ClientType ENUM('Buyer', 'Seller', 'Tenant', 'Landlord'),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Properties (
    PropertyID INT AUTO_INCREMENT PRIMARY KEY,
    AgentID INT,
    OwnerID INT, -- References ClientID of the owner
    Title VARCHAR(100),
    PropertyType ENUM('Apartment', 'House', 'Commercial', 'Land'),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Price DECIMAL(15,2),
    Status ENUM('Available', 'Sold', 'Rented') DEFAULT 'Available',
    SizeSqFt DECIMAL(10,2),
    Bedrooms INT,
    Bathrooms INT,
    Description TEXT,
    DateListed DATETIME DEFAULT CURRENT_TIMESTAMP ,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
    FOREIGN KEY (OwnerID) REFERENCES Clients(ClientID)
);

CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT,
    BuyerTenantID INT,
    AgentID INT,
    TransactionType ENUM('Sale', 'Rent'),
    TransactionDate DATE,
    Amount DECIMAL(15,2),
    PaymentStatus ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (BuyerTenantID) REFERENCES Clients(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    TransactionID INT,
    PaymentDate DATE,
    AmountPaid DECIMAL(15,2),
    PaymentMethod ENUM('Cash', 'Bank Transfer', 'Credit Card', 'Online'),
    Remarks VARCHAR(255),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

desc Agents;
desc Clients;
desc Properties;
desc Transactions;
desc Payments;

INSERT INTO Agents (FirstName, LastName, Email, Phone, JoinDate, CommissionRate, Status)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@realestate.com', '9876543210', '2023-01-15', 2.50, 'Active'),
('Priya', 'Mehta', 'priya.mehta@realestate.com', '9876501234', '2023-02-10', 3.00, 'Active'),
('Amit', 'Patel', 'amit.patel@realestate.com', '9876123456', '2023-03-05', 2.75, 'Active'),
('Sneha', 'Kumar', 'sneha.kumar@realestate.com', '9876789012', '2023-03-20', 3.50, 'Active'),
('Rohan', 'Verma', 'rohan.verma@realestate.com', '9876345678', '2023-04-15', 2.25, 'Active'),
('Neha', 'Singh', 'neha.singh@realestate.com', '9876987654', '2023-05-01', 3.20, 'Inactive'),
('Karan', 'Joshi', 'karan.joshi@realestate.com', '9876456789', '2023-06-18', 2.90, 'Active'),
('Pooja', 'Reddy', 'pooja.reddy@realestate.com', '9876321456', '2023-07-22', 3.10, 'Active'),
('Vikas', 'Gupta', 'vikas.gupta@realestate.com', '9876765432', '2023-08-30', 2.80, 'Active'),
('Anita', 'Nair', 'anita.nair@realestate.com', '9876098765', '2023-09-12', 3.00, 'Inactive');

INSERT INTO Clients (FirstName, LastName, Email, Phone, Address, ClientType)
VALUES
('Aarav', 'Patel', 'aarav.patel@gmail.com', '9876001122', '12 MG Road, Mumbai', 'Buyer'),
('Kavya', 'Shah', 'kavya.shah@yahoo.com', '9876001133', '45 Nehru Nagar, Ahmedabad', 'Seller'),
('Rohit', 'Verma', 'rohit.verma@outlook.com', '9876001144', '78 Park Street, Kolkata', 'Tenant'),
('Ananya', 'Rao', 'ananya.rao@gmail.com', '9876001155', '23 Residency Road, Bengaluru', 'Landlord'),
('Vivek', 'Singh', 'vivek.singh@gmail.com', '9876001166', '9 Civil Lines, Delhi', 'Buyer'),
('Meera', 'Nair', 'meera.nair@gmail.com', '9876001177', '56 MG Road, Kochi', 'Seller'),
('Aditya', 'Joshi', 'aditya.joshi@gmail.com', '9876001188', '88 FC Road, Pune', 'Tenant'),
('Sneha', 'Gupta', 'sneha.gupta@gmail.com', '9876001199', '34 Sector 21, Noida', 'Buyer'),
('Riya', 'Menon', 'riya.menon@gmail.com', '9876001200', '14 Brigade Road, Bengaluru', 'Landlord'),
('Manish', 'Kumar', 'manish.kumar@gmail.com', '9876001211', '102 Hill View, Chandigarh', 'Seller');

INSERT INTO Properties 
(AgentID, OwnerID, Title, PropertyType, Address, City, State, Price, Status, SizeSqFt, Bedrooms, Bathrooms, Description)
VALUES
(1, 2, '2BHK Modern Apartment', 'Apartment', '12 MG Road', 'Mumbai', 'Maharashtra', 8500000.00, 'Available', 950.00, 2, 2, 'Spacious 2BHK apartment near metro station.'),
(2, 4, 'Luxury Villa with Garden', 'House', '45 Residency Road', 'Bengaluru', 'Karnataka', 25000000.00, 'Available', 3200.00, 4, 3, 'Premium villa with private garden and parking space.'),
(3, 6, 'Commercial Office Space', 'Commercial', '78 Park Street', 'Kolkata', 'West Bengal', 18000000.00, 'Available', 5000.00, 0, 2, 'Office space in the heart of business district.'),
(4, 10, '3BHK Family Home', 'House', '23 Civil Lines', 'Delhi', 'Delhi', 12500000.00, 'Sold', 1600.00, 3, 2, 'Beautifully maintained family home in quiet neighborhood.'),
(5, 1, 'Luxury Penthouse', 'Apartment', '9 FC Road', 'Pune', 'Maharashtra', 32000000.00, 'Available', 2800.00, 4, 4, 'Top-floor penthouse with city view and private terrace.'),
(6, 3, 'Retail Shop Space', 'Commercial', '56 MG Road', 'Kochi', 'Kerala', 9500000.00, 'Rented', 1500.00, 0, 1, 'Ground floor retail shop near main market area.'),
(7, 5, '2 Acre Open Land', 'Land', 'Plot No. 23, Ring Road', 'Ahmedabad', 'Gujarat', 12000000.00, 'Available', 87120.00, 0, 0, 'Open plot suitable for warehouse or small industry.'),
(8, 7, '3BHK Apartment', 'Apartment', '88 Sector 21', 'Noida', 'Uttar Pradesh', 9500000.00, 'Available', 1350.00, 3, 2, 'Apartment in gated society with clubhouse and pool.'),
(9, 8, '5BHK Bungalow', 'House', '14 Brigade Road', 'Bengaluru', 'Karnataka', 30000000.00, 'Rented', 4000.00, 5, 4, 'Large bungalow suitable for families or guest house.'),
(10, 9, 'Office Building Plot', 'Land', '102 Hill View', 'Chandigarh', 'Chandigarh', 15000000.00, 'Available', 6000.00, 0, 0, 'Commercial land for office development.');

INSERT INTO Transactions (PropertyID, BuyerTenantID, AgentID, TransactionType, TransactionDate, Amount, PaymentStatus)
VALUES
(1, 1, 1, 'Sale', '2023-02-15', 8500000.00, 'Completed'),
(2, 5, 2, 'Sale', '2023-04-10', 25000000.00, 'Completed'),
(3, 3, 3, 'Rent', '2023-06-05', 200000.00, 'Completed'),
(4, 8, 4, 'Sale', '2023-07-20', 12500000.00, 'Completed'),
(5, 9, 5, 'Sale', '2023-08-25', 32000000.00, 'Pending'),
(6, 7, 6, 'Rent', '2023-09-01', 180000.00, 'Completed'),
(7, 2, 7, 'Sale', '2023-09-15', 12000000.00, 'Cancelled'),
(8, 10, 8, 'Rent', '2023-10-05', 150000.00, 'Completed'),
(9, 4, 9, 'Rent', '2023-10-12', 250000.00, 'Pending'),
(10, 6, 10, 'Sale', '2023-10-25', 15000000.00, 'Completed');

INSERT INTO Payments (TransactionID, PaymentDate, AmountPaid, PaymentMethod, Remarks)
VALUES
(1, '2023-02-16', 8500000.00, 'Bank Transfer', 'Full payment received for apartment purchase'),
(2, '2023-04-11', 25000000.00, 'Bank Transfer', 'Luxury villa payment cleared'),
(3, '2023-06-06', 200000.00, 'Online', 'First month rent received'),
(4, '2023-07-21', 12500000.00, 'Credit Card', 'Payment completed for 3BHK home'),
(5, '2023-08-28', 15000000.00, 'Bank Transfer', 'Advance 50% payment received, balance pending'),
(6, '2023-09-02', 180000.00, 'Cash', 'Rent paid for commercial shop'),
(7, '2023-09-17', 0.00, 'Cash', 'Transaction cancelled, refund pending'),
(8, '2023-10-06', 150000.00, 'Online', 'First rent payment from tenant'),
(9, '2023-10-13', 125000.00, 'Credit Card', 'Partial payment for rental'),
(10, '2023-10-26', 15000000.00, 'Bank Transfer', 'Full payment completed for office land sale');


SELECT * FROM Agents;
SELECT * FROM Clients;
SELECT * FROM Properties;
SELECT * FROM Transactions;
SELECT * FROM Payments;

-- view(JOIN)
CREATE VIEW view_property_sales AS
SELECT 
    p.property_id,
    p.address,
    p.city,
    a.agent_name,
    c.client_name,
    t.sale_price,
    t.transaction_date,
    t.commission_earned
FROM Transactions t
JOIN Properties p ON t.property_id = p.property_id
JOIN Agents a ON t.agent_id = a.agent_id
JOIN Clients c ON t.client_id = c.client_id;

SELECT * FROM view_property_sales;


-- JOINS (List of sold properties with agent and client details)
SELECT 
    p.address, p.city, a.agent_name, c.client_name, t.sale_price
FROM Properties p
JOIN Transactions t ON p.property_id = t.property_id
JOIN Agents a ON a.agent_id = t.agent_id
JOIN Clients c ON c.client_id = t.client_id;


-- Fetch properties that cost more than the average property price(SUBQUERY)

SELECT * FROM Properties
WHERE price > (SELECT AVG(price) FROM Properties);


-- STORED PROCEDURE

DELIMITER $$
CREATE PROCEDURE CountPropertiesByCity()
BEGIN
    SELECT city, COUNT(*) AS total_properties
    FROM Properties
    GROUP BY city;
END$$
DELIMITER ;

-- TRIGGER

DELIMITER $$
CREATE TRIGGER trg_after_transaction_insert
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    UPDATE Properties
    SET status = 'Sold'
    WHERE property_id = NEW.property_id;
END$$
DELIMITER ;

