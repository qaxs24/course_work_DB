CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    ManagerID INT
);

CREATE TABLE Positions (
    PositionID INT PRIMARY KEY,
    PositionName VARCHAR(100),
    SalaryGrade VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PositionID INT,
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(15, 2),
    ClientID INT,
    ProjectManagerID INT,
    Description VARCHAR(MAX)
);

CREATE TABLE Materials (
    MaterialID INT PRIMARY KEY,
    MaterialName VARCHAR(100),
    UnitPrice DECIMAL(10, 2),
    Unit VARCHAR(20)
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

CREATE TABLE SupplierMaterials (
    SupplierID INT,
    MaterialID INT,
    PRIMARY KEY (SupplierID, MaterialID)
);

CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY,
    EquipmentName VARCHAR(100),
    PurchaseDate DATE,
    Cost DECIMAL(15, 2),
    Status VARCHAR(50),
    ProjectID INT,
    TaskID INT,
    SupplierID INT
);

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    TaskName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    AssignedTo INT,
    Status VARCHAR(50),
    Description VARCHAR(MAX),
    ProjectID INT
);

CREATE TABLE Timesheets (
    TimesheetID INT PRIMARY KEY,
    EmployeeID INT,
    WorkDate DATE,
    HoursWorked DECIMAL(5, 2),
    ProjectID INT,
    TaskID INT
);

CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT,
    PayDate DATE,
    GrossPay DECIMAL(10, 2),
    NetPay DECIMAL(10, 2),
    Deductions DECIMAL(10, 2)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    MaterialID INT,
    Quantity DECIMAL(10, 2),
    Location VARCHAR(100)
);

CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    ClientID INT,
    ProjectID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(15, 2),
    DueDate DATE,
    Status VARCHAR(50)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    PaymentDate DATE,
    Amount DECIMAL(15, 2),
    PaymentMethod VARCHAR(50)
);

CREATE TABLE Contracts (
    ContractID INT PRIMARY KEY,
    ProjectID INT,
    ClientID INT,
    StartDate DATE,
    EndDate DATE,
    ContractAmount DECIMAL(15, 2),
    Terms VARCHAR(MAX)
);

CREATE TABLE ProjectMaterials (
    ProjectID INT,
    MaterialID INT,
    Quantity DECIMAL(10, 2),
    PRIMARY KEY (ProjectID, MaterialID)
);