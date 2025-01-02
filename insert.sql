INSERT INTO Positions (PositionID, PositionName, SalaryGrade)
VALUES
    (1, 'Manager', 'A'),
    (2, 'Engineer', 'B'),
    (3, 'Architect', 'B'),
    (4, 'HR Specialist', 'B'),
    (5, 'Foreman', 'C'),
    (6, 'Laborer', 'D');
GO

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID)
VALUES
    (1, 'Engineering', NULL),
    (2, 'Construction', NULL),
    (3, 'Administration', NULL);
GO

INSERT INTO Employees (EmployeeID, FirstName, LastName, PositionID, DepartmentID, HireDate, Salary, Phone, Email)
VALUES
    (1, 'Ivan', 'Oliinyk',    1, 1, '2006-01-22', 95960.00, '380-7247', 'ivan.oliinyk.23@pnu.edu.ua'),
    (2, 'Pavlo', 'Molytovnyk',2, 1, '2006-04-27', 71050.00, '380-2660', 'pavlomolytovnyk@gmail.com'),
    (3, 'Viktor','Huivaniuk', 3, 1, '2006-03-10', 70425.00, '380-3971', 'viktorhuivaniuk@gmail.com'),
    (4, 'Tetyana','Oliinyk',  4, 3, '2018-06-17', 53780.00, '380-6672', 'tetyanaoliinyk@gmail.com'),
    (5, 'Denys', 'Morys',     5, 2, '2023-06-22', 37210.00, '380-4321', 'denysmorys@gmail.com'),
    (6, 'Oleh',  'Nytsak',    6, 2, '2023-11-22', 21550.00, '380-6789', 'olehnytsak@gmail.com'),
    (7, 'Svitlana','Oliinyk', 1, 3, '2006-10-17', 87500.00, '380-4809', 'svitlanaoliinyk@gmail.com');
GO

UPDATE Departments SET ManagerID = 1 WHERE DepartmentID = 1;
UPDATE Departments SET ManagerID = 5 WHERE DepartmentID = 2;
UPDATE Departments SET ManagerID = 7 WHERE DepartmentID = 3;
GO

INSERT INTO Clients (ClientID, CompanyName, ContactName, Phone, Email, Address)
VALUES
    (1, 'Atmosfera Corp', 'Taras Tarasenko', '555-1111', 'taras.tarasenko@gmail.com', '123 Main St'),
    (2, 'Globex Inc',     'Sara Petrova',    '555-2222', 'sara.petrova@gmail.com',   '456 Elm St'),
    (3, 'Initech',        'Bill Lumbergh',   '555-3333', 'bill.lumbergh@gmail.com',  '789 Oak St');
GO

INSERT INTO Suppliers (SupplierID, CompanyName, ContactName, Phone, Email, Address)
VALUES
    (1, 'Supply Co.',              'Anna Thompson', '555-3333', 'anna.thompson@supplyco.com',       '789 Pine Rd.'),
    (2, 'Building Supplies Ltd.',  'Mark Lee',      '555-4444', 'mark.lee@buildingsupplies.com',    '321 Cedar St.');
GO

INSERT INTO Materials (MaterialID, MaterialName, UnitPrice, Unit)
VALUES
    (1, 'Concrete',      75.00, 'cubic yard'),
    (2, 'Steel Beams',   300.00,'ton'),
    (3, 'Bricks',        0.50,  'unit'),
    (4, 'Glass Panels',  250.00,'unit');
GO

INSERT INTO SupplierMaterials (SupplierID, MaterialID)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 2),
    (2, 4);
GO

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, Budget, ClientID, ProjectManagerID, Description)
VALUES
    (1, 'Office Building',    '2024-01-01', '2025-12-31', 1000000.00, 1, 2, 'Construction of a new office building'),
    (2, 'Bridge Construction','2021-06-01', '2026-05-31', 2000000.00, 2, 2, 'Building a new bridge over the river'),
    (3, 'Road Expansion',     '2021-09-01', '2022-08-31', 1500000.00, 3, 5, 'Expanding the main highway');
GO

INSERT INTO Contracts (ContractID, ProjectID, ClientID, StartDate, EndDate, ContractAmount, Terms)
VALUES
    (1, 1, 1, '2024-01-01', '2025-12-31', 1000000.00, 'Standard terms for office building construction'),
    (2, 2, 2, '2021-06-01', '2023-05-31', 2000000.00, 'Standard terms for bridge construction'),
    (3, 3, 3, '2021-09-01', '2022-08-31', 1500000.00, 'Standard terms for road expansion');
GO

INSERT INTO Tasks (TaskID, TaskName, StartDate, EndDate, AssignedTo, Status, Description, ProjectID)
VALUES
    (1, 'Foundation Work',            '2024-01-01', '2024-03-31', 1, 'In Progress', 'Laying the foundation',             1),
    (2, 'Steel Framework Construction','2024-04-01', '2024-06-30', 4, 'Not Started', 'Building the steel framework',      1),
    (3, 'Electrical Wiring',          '2021-07-01', '2021-09-30', 1, 'Not Started', 'Installing electrical systems',     2),
    (4, 'Inspection',                 '2025-12-01', '2025-12-15', 5, 'Not Started', 'Final inspection of the building',  1);
GO

INSERT INTO ProjectMaterials (ProjectID, MaterialID, Quantity)
VALUES
    (1, 1,  250.00),
    (1, 2,  100.00),
    (2, 3,  5000.00),
    (2, 4,  50.00);
GO

INSERT INTO Equipment (EquipmentID, EquipmentName, PurchaseDate, Cost, Status, ProjectID, TaskID, SupplierID)
VALUES
    (1, 'Crane',     '2020-01-01', 500000.00, 'Operational',       1, 1, 1),
    (2, 'Bulldozer', '2019-06-15', 300000.00, 'Under Maintenance', 2, 3, 2);
GO

INSERT INTO Inventory (InventoryID, MaterialID, Quantity, Location)
VALUES
    (1, 1,  250.00, 'Warehouse A'),
    (2, 2,  150.00, 'Warehouse B'),
    (3, 3,  5000.00,'Warehouse A'),
    (4, 4,  50.00,  'Warehouse B');
GO

INSERT INTO Invoices (InvoiceID, ClientID, ProjectID, InvoiceDate, TotalAmount, DueDate, Status)
VALUES
    (1, 1, 1, '2024-02-01', 500000.00, '2024-03-01', 'Unpaid'),
    (2, 2, 2, '2021-02-15', 750000.00, '2021-03-15', 'Unpaid');
GO

INSERT INTO Payments (PaymentID, InvoiceID, PaymentDate, Amount, PaymentMethod)
VALUES
    (1, 1, '2024-02-20', 500000.00, 'Bank Transfer'),
    (2, 2, '2021-03-10', 750000.00, 'Bank Transfer');
GO

UPDATE Invoices SET Status = 'Paid' WHERE InvoiceID IN (1, 2);
GO

INSERT INTO Timesheets (TimesheetID, EmployeeID, WorkDate, HoursWorked, ProjectID, TaskID)
VALUES
    (1, 5, '2024-01-05', 8.00, 1, 1),
    (2, 6, '2024-01-05', 8.00, 1, 1),
    (3, 5, '2024-01-06', 8.00, 1, 1),
    (4, 6, '2024-01-06', 8.00, 1, 1);
GO

INSERT INTO Payroll (PayrollID, EmployeeID, PayDate, GrossPay, NetPay, Deductions)
VALUES
    (1, 5, '2024-01-31', 3000.00, 2400.00, 600.00),
    (2, 6, '2024-01-31', 2500.00, 2000.00, 500.00),
    (3, 1, '2024-01-31', 8000.00, 6400.00, 1600.00),
    (4, 2, '2024-01-31', 7000.00, 5600.00, 1400.00);
GO