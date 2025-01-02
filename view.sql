CREATE VIEW View_EmployeeDetails AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    p.PositionName,
    d.DepartmentName,
    e.HireDate,
    e.Salary,
    e.Phone,
    e.Email
FROM 
    Employees e
JOIN 
    Positions p ON e.PositionID = p.PositionID
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;
GO

CREATE VIEW View_ProjectOverview AS
SELECT 
    pr.ProjectID,
    pr.ProjectName,
    pr.StartDate,
    pr.EndDate,
    pr.Budget,
    c.CompanyName AS ClientName,
    pm.FirstName + ' ' + pm.LastName AS ProjectManager,
    pr.Description
FROM 
    Projects pr
JOIN 
    Clients c ON pr.ClientID = c.ClientID
JOIN 
    Employees pm ON pr.ProjectManagerID = pm.EmployeeID;
GO

CREATE VIEW View_TaskAssignments AS
SELECT 
    t.TaskID,
    t.TaskName,
    t.StartDate,
    t.EndDate,
    e.FirstName + ' ' + e.LastName AS AssignedEmployee,
    t.Status,
    t.Description,
    p.ProjectName
FROM 
    Tasks t
JOIN 
    Employees e ON t.AssignedTo = e.EmployeeID
JOIN 
    Projects p ON t.ProjectID = p.ProjectID;
GO

CREATE VIEW View_ProjectMaterialsUsage AS
SELECT 
    pm.ProjectID,
    p.ProjectName,
    m.MaterialID,
    m.MaterialName,
    pm.Quantity
FROM 
    ProjectMaterials pm
JOIN 
    Projects p ON pm.ProjectID = p.ProjectID
JOIN 
    Materials m ON pm.MaterialID = m.MaterialID;
GO

CREATE VIEW View_EmployeeTimesheets AS
SELECT 
    ts.TimesheetID,
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    ts.WorkDate,
    ts.HoursWorked,
    p.ProjectName,
    t.TaskName
FROM 
    Timesheets ts
JOIN 
    Employees e ON ts.EmployeeID = e.EmployeeID
JOIN 
    Projects p ON ts.ProjectID = p.ProjectID
JOIN 
    Tasks t ON ts.TaskID = t.TaskID;
GO

CREATE VIEW View_SupplierMaterials AS
SELECT 
    s.SupplierID,
    s.CompanyName AS SupplierName,
    m.MaterialID,
    m.MaterialName
FROM 
    Suppliers s
JOIN 
    SupplierMaterials sm ON s.SupplierID = sm.SupplierID
JOIN 
    Materials m ON sm.MaterialID = m.MaterialID;
GO

CREATE VIEW View_PayrollDetails AS
SELECT 
    pr.PayrollID,
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    pr.PayDate,
    pr.GrossPay,
    pr.NetPay,
    pr.Deductions
FROM 
    Payroll pr
JOIN 
    Employees e ON pr.EmployeeID = e.EmployeeID;
GO

CREATE VIEW View_InvoicePayments AS
SELECT 
    i.InvoiceID,
    c.CompanyName AS ClientName,
    i.InvoiceDate,
    i.TotalAmount,
    i.DueDate,
    i.Status,
    p.PaymentID,
    p.PaymentDate,
    p.Amount AS PaymentAmount,
    p.PaymentMethod
FROM 
    Invoices i
JOIN 
    Clients c ON i.ClientID = c.ClientID
LEFT JOIN 
    Payments p ON i.InvoiceID = p.InvoiceID;
GO

CREATE VIEW View_EquipmentDetails AS
SELECT 
    eq.EquipmentID,
    eq.EquipmentName,
    eq.PurchaseDate,
    eq.Cost,
    eq.Status,
    p.ProjectName,
    t.TaskName,
    s.CompanyName AS SupplierName
FROM 
    Equipment eq
LEFT JOIN 
    Projects p ON eq.ProjectID = p.ProjectID
LEFT JOIN 
    Tasks t ON eq.TaskID = t.TaskID
LEFT JOIN 
    Suppliers s ON eq.SupplierID = s.SupplierID;
GO

CREATE VIEW View_ContractDetails AS
SELECT 
    c.ContractID,
    p.ProjectName,
    cl.CompanyName AS ClientName,
    c.StartDate,
    c.EndDate,
    c.ContractAmount,
    c.Terms
FROM 
    Contracts c
JOIN 
    Projects p ON c.ProjectID = p.ProjectID
JOIN 
    Clients cl ON c.ClientID = cl.ClientID;
GO

CREATE VIEW View_ProjectFinancials AS
SELECT 
    p.ProjectID,
    p.ProjectName,
    p.Budget,
    SUM(pm.ContractAmount) AS TotalContracts,
    SUM(i.TotalAmount) AS TotalInvoices,
    SUM(py.Amount) AS TotalPayments
FROM 
    Projects p
LEFT JOIN Contracts pm ON p.ProjectID = pm.ProjectID
LEFT JOIN Invoices i ON p.ProjectID = i.ProjectID
LEFT JOIN Payments py ON i.InvoiceID = py.InvoiceID
GROUP BY 
    p.ProjectID,
    p.ProjectName,
    p.Budget;
GO
