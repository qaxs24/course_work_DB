SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    p.PositionName,
    d.DepartmentName
FROM 
    Employees e
JOIN 
    Positions p ON e.PositionID = p.PositionID
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;

SELECT 
    pr.ProjectID,
    pr.ProjectName,
    c.CompanyName AS ClientName,
    pm.FirstName + ' ' + pm.LastName AS ProjectManager
FROM 
    Projects pr
JOIN 
    Clients c ON pr.ClientID = c.ClientID
JOIN 
    Employees pm ON pr.ProjectManagerID = pm.EmployeeID;

SELECT 
    t.TaskID,
    t.TaskName,
    e.FirstName + ' ' + e.LastName AS AssignedEmployee,
    p.ProjectName
FROM 
    Tasks t
JOIN 
    Employees e ON t.AssignedTo = e.EmployeeID
JOIN 
    Projects p ON t.ProjectID = p.ProjectID;

SELECT 
    m.MaterialID,
    m.MaterialName,
    s.SupplierID,
    s.CompanyName AS SupplierName
FROM 
    Materials m
JOIN 
    SupplierMaterials sm ON m.MaterialID = sm.MaterialID
JOIN 
    Suppliers s ON sm.SupplierID = s.SupplierID;

SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    p.ProjectID,
    p.ProjectName,
    SUM(t.HoursWorked) AS TotalHours
FROM 
    Timesheets t
JOIN 
    Employees e ON t.EmployeeID = e.EmployeeID
JOIN 
    Projects p ON t.ProjectID = p.ProjectID
GROUP BY 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    p.ProjectID,
    p.ProjectName;

SELECT 
    eq.EquipmentID,
    eq.EquipmentName,
    eq.Status,
    s.CompanyName AS SupplierName,
    p.ProjectName,
    t.TaskName
FROM 
    Equipment eq
LEFT JOIN 
    Suppliers s ON eq.SupplierID = s.SupplierID
LEFT JOIN 
    Projects p ON eq.ProjectID = p.ProjectID
LEFT JOIN 
    Tasks t ON eq.TaskID = t.TaskID;

SELECT 
    i.InvoiceID,
    c.CompanyName AS ClientName,
    i.InvoiceDate,
    i.TotalAmount,
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

SELECT 
    pm.ProjectID,
    pr.ProjectName,
    m.MaterialID,
    m.MaterialName,
    pm.Quantity
FROM 
    ProjectMaterials pm
JOIN 
    Projects pr ON pm.ProjectID = pr.ProjectID
JOIN 
    Materials m ON pm.MaterialID = m.MaterialID;

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

SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    t.TaskName,
    ts.WorkDate,
    ts.HoursWorked
FROM 
    Timesheets ts
JOIN 
    Employees e ON ts.EmployeeID = e.EmployeeID
JOIN 
    Tasks t ON ts.TaskID = t.TaskID;

SELECT 
    i.InventoryID,
    m.MaterialName,
    i.Quantity,
    i.Location
FROM 
    Inventory i
JOIN 
    Materials m ON i.MaterialID = m.MaterialID;

SELECT 
    p.ProjectID,
    p.ProjectName,
    eq.EquipmentID,
    eq.EquipmentName,
    eq.Status
FROM 
    Projects p
JOIN 
    Equipment eq ON p.ProjectID = eq.ProjectID;

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Phone,
    e.Email,
    d.DepartmentName
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName = 'Engineering';

SELECT 
    s.SupplierID,
    s.CompanyName AS SupplierName,
    m.MaterialName
FROM 
    Suppliers s
JOIN 
    SupplierMaterials sm ON s.SupplierID = sm.SupplierID
JOIN 
    Materials m ON sm.MaterialID = m.MaterialID
ORDER BY 
    s.SupplierID;
GO
