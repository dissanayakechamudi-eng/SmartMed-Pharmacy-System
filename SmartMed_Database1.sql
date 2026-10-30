CREATE DATABASE SmartMedDB1;
GO

USE SmartMedDB1;
GO

-- Users Table
CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL
);

-- Admin Table
CREATE TABLE Admins
(
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15),
    FOREIGN KEY(UserID)
    REFERENCES Users(UserID)
);

-- Customers Table
CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(UserID)
    REFERENCES Users(UserID)
);

-- Suppliers Table
CREATE TABLE Suppliers
(
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactPerson VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- Medicines Table
CREATE TABLE Medicines
(
    MedicineID INT IDENTITY(1,1) PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Dosage VARCHAR(50),
    Description VARCHAR(255),
    UnitPrice DECIMAL(10,2) NOT NULL,
    StockQuantity INT DEFAULT 0,
    ExpiryDate DATE,
    RequiresPrescription BIT DEFAULT 0,
    SupplierID INT,
    FOREIGN KEY(SupplierID)
    REFERENCES Suppliers(SupplierID)
);

-- Discount Table --
CREATE TABLE Discounts
(
    DiscountID INT IDENTITY(1,1) PRIMARY KEY,
    MedicineID INT NOT NULL,
    DiscountPercentage DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY(MedicineID)
    REFERENCES Medicines(MedicineID)
);

-- Orders Table --
CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY(CustomerID)
    REFERENCES Customers(CustomerID)
);

-- order items --
CREATE TABLE OrderItems
(
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    MedicineID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2),
    SubTotal DECIMAL(10,2),
    FOREIGN KEY(OrderID)
    REFERENCES Orders(OrderID),
    FOREIGN KEY(MedicineID)
    REFERENCES Medicines(MedicineID)
);


-- Prescriptions Table
CREATE TABLE Prescriptions
(
    PrescriptionID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderID INT NULL,
    PrescriptionDate DATETIME DEFAULT GETDATE(),
    DoctorName VARCHAR(100),
    FilePath VARCHAR(255),
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY(CustomerID)
    REFERENCES Customers(CustomerID),
    FOREIGN KEY(OrderID)
    REFERENCES Orders(OrderID)
);

-- expiry notification --
CREATE TABLE ExpiryNotifications
(
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    MedicineID INT NOT NULL,
    NotificationDate DATETIME DEFAULT GETDATE(),
    IsRead BIT DEFAULT 0,
    FOREIGN KEY(MedicineID)
    REFERENCES Medicines(MedicineID)
);

-- PurchaseOrders Table
CREATE TABLE PurchaseOrders
(
    PurchaseOrderID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY(SupplierID)
    REFERENCES Suppliers(SupplierID)
);

-- PurchaseOrderItems Table
CREATE TABLE PurchaseOrderItems
(
    PurchaseOrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    PurchaseOrderID INT NOT NULL,
    MedicineID INT NOT NULL,
    Quantity INT,
    UnitCost DECIMAL(10,2),
    FOREIGN KEY(PurchaseOrderID)
    REFERENCES PurchaseOrders(PurchaseOrderID),
    FOREIGN KEY(MedicineID)
    REFERENCES Medicines(MedicineID)
);


-- default admin login --
INSERT INTO Users
(
    Username,
    Password,
    Role
)
VALUES
(
    'admin',
    'admin123',
    'Admin'
);


-- Admin Profile --
INSERT INTO Admins
(
    UserID,
    FullName,
    Email,
    Phone
)
VALUES
(
    1,
    'System Administrator',
    'admin@smartmed.com',
    '0712345678'
);


INSERT INTO Suppliers
(
    SupplierName,
    ContactPerson,
    Phone,
    Email,
    Address
)
VALUES
('ABC Pharma', 'John Silva', '0712345678', 'abc@gmail.com', 'Colombo'),
('MediCare Distributors', 'Nimal Perera', '0723456789', 'medicare@gmail.com', 'Kandy'),
('SL Pharmacy', 'Kamal Attanayake', '0701234567', 'slp@gmail.com', 'Gampola');



SELECT * FROM dbo.Suppliers;

SELECT * FROM Customers;
