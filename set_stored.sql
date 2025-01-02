CREATE OR ALTER PROCEDURE dbo.SetEmployee
(
    @EmployeeID INT = NULL OUTPUT,
    @FirstName VARCHAR(50) = NULL,
    @LastName VARCHAR(50) = NULL,
    @PositionID INT = NULL,
    @DepartmentID INT = NULL,
    @HireDate DATE = NULL,
    @Salary DECIMAL(10, 2) = NULL,
    @Phone VARCHAR(20) = NULL,
    @Email VARCHAR(100) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @EmployeeID IS NULL
        BEGIN
            IF @FirstName IS NULL OR @LastName IS NULL OR @PositionID IS NULL OR @DepartmentID IS NULL OR @HireDate IS NULL
            BEGIN
                PRINT 'Missing required fields for new Employee.';
                RETURN;
            END

            SELECT @EmployeeID = ISNULL(MAX(EmployeeID),0) + 1 FROM Employees;

            INSERT INTO Employees(EmployeeID, FirstName, LastName, PositionID, DepartmentID, HireDate, Salary, Phone, Email)
            VALUES(@EmployeeID, @FirstName, @LastName, @PositionID, @DepartmentID, @HireDate, ISNULL(@Salary,0), @Phone, @Email);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
            BEGIN
                PRINT 'Employee not found for update.';
                RETURN;
            END

            UPDATE Employees
            SET FirstName = ISNULL(@FirstName, FirstName),
                LastName = ISNULL(@LastName, LastName),
                PositionID = ISNULL(@PositionID, PositionID),
                DepartmentID = ISNULL(@DepartmentID, DepartmentID),
                HireDate = ISNULL(@HireDate, HireDate),
                Salary = ISNULL(@Salary, Salary),
                Phone = ISNULL(@Phone, Phone),
                Email = ISNULL(@Email, Email)
            WHERE EmployeeID = @EmployeeID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

DECLARE @EmpID INT;
EXEC dbo.SetEmployee 
    @EmployeeID = @EmpID OUTPUT,
    @FirstName = 'John',
    @LastName = 'Doe',
    @PositionID = 2,
    @DepartmentID = 1,
    @HireDate = '2024-01-01',
    @Salary = 50000.00,
    @Phone = '555-1234',
    @Email = 'john.doe@example.com';
SELECT @EmpID AS NewEmployeeID;

GO

DECLARE @EmpID INT = 1;
EXEC dbo.SetEmployee 
    @EmployeeID = @EmpID,
    @Phone = '555-9999', 
    @Email = 'new_email@example.com';

GO

CREATE OR ALTER PROCEDURE dbo.SetPosition
(
    @PositionID INT = NULL OUTPUT,
    @PositionName VARCHAR(100) = NULL,
    @SalaryGrade VARCHAR(50) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @PositionID IS NULL
        BEGIN
            IF @PositionName IS NULL
            BEGIN
                PRINT 'Missing required field PositionName.';
                RETURN;
            END

            SELECT @PositionID = ISNULL(MAX(PositionID),0)+1 FROM Positions;

            INSERT INTO Positions(PositionID, PositionName, SalaryGrade)
            VALUES(@PositionID, @PositionName, ISNULL(@SalaryGrade,'Unknown'));
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Positions WHERE PositionID = @PositionID)
            BEGIN
                PRINT 'Position not found.';
                RETURN;
            END

            UPDATE Positions
            SET PositionName = ISNULL(@PositionName, PositionName),
                SalaryGrade = ISNULL(@SalaryGrade, SalaryGrade)
            WHERE PositionID = @PositionID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

DECLARE @PosID INT;
EXEC dbo.SetPosition 
    @PositionID = @PosID OUTPUT,
    @PositionName = 'Safety Officer',
    @SalaryGrade = 'C';
SELECT @PosID AS NewPositionID;

GO

DECLARE @PosID INT = 2;
EXEC dbo.SetPosition 
    @PositionID = @PosID,
    @SalaryGrade = 'A';

GO

CREATE OR ALTER PROCEDURE dbo.SetClient
(
    @ClientID INT = NULL OUTPUT,
    @CompanyName VARCHAR(100) = NULL,
    @ContactName VARCHAR(100) = NULL,
    @Phone VARCHAR(20) = NULL,
    @Email VARCHAR(100) = NULL,
    @Address VARCHAR(200) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @ClientID IS NULL
        BEGIN
            IF @CompanyName IS NULL
            BEGIN
                PRINT 'CompanyName is required for new Client.';
                RETURN;
            END
            SELECT @ClientID = ISNULL(MAX(ClientID),0)+1 FROM Clients;

            INSERT INTO Clients(ClientID, CompanyName, ContactName, Phone, Email, Address)
            VALUES(@ClientID, @CompanyName, @ContactName, @Phone, @Email, @Address);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Clients WHERE ClientID = @ClientID)
            BEGIN
                PRINT 'Client not found.';
                RETURN;
            END

            UPDATE Clients
            SET CompanyName = ISNULL(@CompanyName, CompanyName),
                ContactName = ISNULL(@ContactName, ContactName),
                Phone = ISNULL(@Phone, Phone),
                Email = ISNULL(@Email, Email),
                Address = ISNULL(@Address, Address)
            WHERE ClientID = @ClientID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

DECLARE @ClientID INT;
EXEC dbo.SetClient 
    @ClientID = @ClientID OUTPUT,
    @CompanyName = 'New Client Inc.',
    @ContactName = 'Alice Johnson',
    @Phone = '555-7777',
    @Email = 'alice@newclient.com',
    @Address = '456 New Ave';
SELECT @ClientID AS NewClientID;

GO

DECLARE @ClientID INT = 2;
EXEC dbo.SetClient 
    @ClientID = @ClientID,
    @ContactName = 'Updated Contact';

GO

CREATE OR ALTER PROCEDURE dbo.SetSupplier
(
    @SupplierID INT = NULL OUTPUT,
    @CompanyName VARCHAR(100) = NULL,
    @ContactName VARCHAR(100) = NULL,
    @Phone VARCHAR(20) = NULL,
    @Email VARCHAR(100) = NULL,
    @Address VARCHAR(200) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @SupplierID IS NULL
        BEGIN
            IF @CompanyName IS NULL
            BEGIN
                PRINT 'CompanyName required.';
                RETURN;
            END
            SELECT @SupplierID = ISNULL(MAX(SupplierID),0)+1 FROM Suppliers;
            INSERT INTO Suppliers(SupplierID, CompanyName, ContactName, Phone, Email, Address)
            VALUES(@SupplierID, @CompanyName, @ContactName, @Phone, @Email, @Address);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Suppliers WHERE SupplierID=@SupplierID)
            BEGIN
                PRINT 'Supplier not found.';
                RETURN;
            END
            UPDATE Suppliers
            SET CompanyName = ISNULL(@CompanyName, CompanyName),
                ContactName = ISNULL(@ContactName, ContactName),
                Phone = ISNULL(@Phone, Phone),
                Email = ISNULL(@Email, Email),
                Address = ISNULL(@Address, Address)
            WHERE SupplierID=@SupplierID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetMaterial
(
    @MaterialID INT = NULL OUTPUT,
    @MaterialName VARCHAR(100) = NULL,
    @UnitPrice DECIMAL(10,2)=NULL,
    @Unit VARCHAR(20)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @MaterialID IS NULL
        BEGIN
            IF @MaterialName IS NULL OR @UnitPrice IS NULL OR @Unit IS NULL
            BEGIN
                PRINT 'MaterialName, UnitPrice, Unit are required.';
                RETURN;
            END
            SELECT @MaterialID = ISNULL(MAX(MaterialID),0)+1 FROM Materials;
            INSERT INTO Materials(MaterialID, MaterialName, UnitPrice, Unit)
            VALUES(@MaterialID, @MaterialName, @UnitPrice, @Unit);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Materials WHERE MaterialID=@MaterialID)
            BEGIN
                PRINT 'Material not found.';
                RETURN;
            END
            UPDATE Materials
            SET MaterialName=ISNULL(@MaterialName, MaterialName),
                UnitPrice=ISNULL(@UnitPrice, UnitPrice),
                Unit=ISNULL(@Unit, Unit)
            WHERE MaterialID=@MaterialID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetDepartment
(
    @DepartmentID INT=NULL OUTPUT,
    @DepartmentName VARCHAR(100)=NULL,
    @ManagerID INT=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @DepartmentID IS NULL
        BEGIN
            IF @DepartmentName IS NULL
            BEGIN
                PRINT 'DepartmentName required.';
                RETURN;
            END
            SELECT @DepartmentID=ISNULL(MAX(DepartmentID),0)+1 FROM Departments;
            INSERT INTO Departments(DepartmentID, DepartmentName, ManagerID)
            VALUES(@DepartmentID, @DepartmentName, @ManagerID);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Departments WHERE DepartmentID=@DepartmentID)
            BEGIN
                PRINT 'Department not found.';
                RETURN;
            END
            UPDATE Departments
            SET DepartmentName=ISNULL(@DepartmentName, DepartmentName),
                ManagerID=ISNULL(@ManagerID, ManagerID)
            WHERE DepartmentID=@DepartmentID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetProject
(
    @ProjectID INT=NULL OUTPUT,
    @ProjectName VARCHAR(100)=NULL,
    @StartDate DATE=NULL,
    @EndDate DATE=NULL,
    @Budget DECIMAL(15,2)=NULL,
    @ClientID INT=NULL,
    @ProjectManagerID INT=NULL,
    @Description VARCHAR(MAX)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @ProjectID IS NULL
        BEGIN
            IF @ProjectName IS NULL OR @ClientID IS NULL OR @ProjectManagerID IS NULL
            BEGIN
                PRINT 'ProjectName, ClientID, and ProjectManagerID required.';
                RETURN;
            END
            SELECT @ProjectID=ISNULL(MAX(ProjectID),0)+1 FROM Projects;
            INSERT INTO Projects(ProjectID, ProjectName, StartDate, EndDate, Budget, ClientID, ProjectManagerID, Description)
            VALUES(@ProjectID, @ProjectName, @StartDate, @EndDate, ISNULL(@Budget,0), @ClientID, @ProjectManagerID, @Description);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Projects WHERE ProjectID=@ProjectID)
            BEGIN
                PRINT 'Project not found.';
                RETURN;
            END
            UPDATE Projects
            SET ProjectName=ISNULL(@ProjectName, ProjectName),
                StartDate=ISNULL(@StartDate, StartDate),
                EndDate=ISNULL(@EndDate, EndDate),
                Budget=ISNULL(@Budget, Budget),
                ClientID=ISNULL(@ClientID, ClientID),
                ProjectManagerID=ISNULL(@ProjectManagerID, ProjectManagerID),
                Description=ISNULL(@Description, Description)
            WHERE ProjectID=@ProjectID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetTask
(
    @TaskID INT=NULL OUTPUT,
    @TaskName VARCHAR(100)=NULL,
    @StartDate DATE=NULL,
    @EndDate DATE=NULL,
    @AssignedTo INT=NULL,
    @Status VARCHAR(50)=NULL,
    @Description VARCHAR(MAX)=NULL,
    @ProjectID INT=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @TaskID IS NULL
        BEGIN
            IF @TaskName IS NULL OR @AssignedTo IS NULL OR @ProjectID IS NULL
            BEGIN
                PRINT 'TaskName, AssignedTo, ProjectID required.';
                RETURN;
            END
            SELECT @TaskID=ISNULL(MAX(TaskID),0)+1 FROM Tasks;
            INSERT INTO Tasks(TaskID, TaskName, StartDate, EndDate, AssignedTo, Status, Description, ProjectID)
            VALUES(@TaskID, @TaskName, @StartDate, @EndDate, @AssignedTo, ISNULL(@Status,'New'), @Description, @ProjectID);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Tasks WHERE TaskID=@TaskID)
            BEGIN
                PRINT 'Task not found.';
                RETURN;
            END
            UPDATE Tasks
            SET TaskName=ISNULL(@TaskName, TaskName),
                StartDate=ISNULL(@StartDate, StartDate),
                EndDate=ISNULL(@EndDate, EndDate),
                AssignedTo=ISNULL(@AssignedTo, AssignedTo),
                Status=ISNULL(@Status, Status),
                Description=ISNULL(@Description, Description),
                ProjectID=ISNULL(@ProjectID, ProjectID)
            WHERE TaskID=@TaskID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetEquipment
(
    @EquipmentID INT=NULL OUTPUT,
    @EquipmentName VARCHAR(100)=NULL,
    @PurchaseDate DATE=NULL,
    @Cost DECIMAL(15,2)=NULL,
    @Status VARCHAR(50)=NULL,
    @ProjectID INT=NULL,
    @TaskID INT=NULL,
    @SupplierID INT=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @EquipmentID IS NULL
        BEGIN
            IF @EquipmentName IS NULL
            BEGIN
                PRINT 'EquipmentName required.';
                RETURN;
            END
            SELECT @EquipmentID=ISNULL(MAX(EquipmentID),0)+1 FROM Equipment;
            INSERT INTO Equipment(EquipmentID, EquipmentName, PurchaseDate, Cost, Status, ProjectID, TaskID, SupplierID)
            VALUES(@EquipmentID, @EquipmentName, @PurchaseDate, ISNULL(@Cost,0), ISNULL(@Status,'New'), @ProjectID, @TaskID, @SupplierID);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Equipment WHERE EquipmentID=@EquipmentID)
            BEGIN
                PRINT 'Equipment not found.';
                RETURN;
            END
            UPDATE Equipment
            SET EquipmentName=ISNULL(@EquipmentName,EquipmentName),
                PurchaseDate=ISNULL(@PurchaseDate,PurchaseDate),
                Cost=ISNULL(@Cost,Cost),
                Status=ISNULL(@Status,Status),
                ProjectID=ISNULL(@ProjectID,ProjectID),
                TaskID=ISNULL(@TaskID,TaskID),
                SupplierID=ISNULL(@SupplierID,SupplierID)
            WHERE EquipmentID=@EquipmentID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetTimesheet
(
    @TimesheetID INT=NULL OUTPUT,
    @EmployeeID INT=NULL,
    @WorkDate DATE=NULL,
    @HoursWorked DECIMAL(5,2)=NULL,
    @ProjectID INT=NULL,
    @TaskID INT=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @TimesheetID IS NULL
        BEGIN
            IF @EmployeeID IS NULL OR @WorkDate IS NULL OR @HoursWorked IS NULL OR @ProjectID IS NULL OR @TaskID IS NULL
            BEGIN
                PRINT 'EmployeeID, WorkDate, HoursWorked, ProjectID, TaskID required.';
                RETURN;
            END
            SELECT @TimesheetID=ISNULL(MAX(TimesheetID),0)+1 FROM Timesheets;
            INSERT INTO Timesheets(TimesheetID, EmployeeID, WorkDate, HoursWorked, ProjectID, TaskID)
            VALUES(@TimesheetID, @EmployeeID, @WorkDate, @HoursWorked, @ProjectID, @TaskID);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Timesheets WHERE TimesheetID=@TimesheetID)
            BEGIN
                PRINT 'Timesheet not found.';
                RETURN;
            END
            UPDATE Timesheets
            SET EmployeeID=ISNULL(@EmployeeID,EmployeeID),
                WorkDate=ISNULL(@WorkDate,WorkDate),
                HoursWorked=ISNULL(@HoursWorked,HoursWorked),
                ProjectID=ISNULL(@ProjectID,ProjectID),
                TaskID=ISNULL(@TaskID,TaskID)
            WHERE TimesheetID=@TimesheetID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetPayroll
(
    @PayrollID INT=NULL OUTPUT,
    @EmployeeID INT=NULL,
    @PayDate DATE=NULL,
    @GrossPay DECIMAL(10,2)=NULL,
    @NetPay DECIMAL(10,2)=NULL,
    @Deductions DECIMAL(10,2)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @PayrollID IS NULL
        BEGIN
            IF @EmployeeID IS NULL OR @PayDate IS NULL OR @GrossPay IS NULL OR @NetPay IS NULL
            BEGIN
                PRINT 'EmployeeID, PayDate, GrossPay, NetPay required.';
                RETURN;
            END
            SELECT @PayrollID=ISNULL(MAX(PayrollID),0)+1 FROM Payroll;
            INSERT INTO Payroll(PayrollID, EmployeeID, PayDate, GrossPay, NetPay, Deductions)
            VALUES(@PayrollID, @EmployeeID, @PayDate, @GrossPay, @NetPay, ISNULL(@Deductions,0));
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Payroll WHERE PayrollID=@PayrollID)
            BEGIN
                PRINT 'Payroll record not found.';
                RETURN;
            END
            UPDATE Payroll
            SET EmployeeID=ISNULL(@EmployeeID,EmployeeID),
                PayDate=ISNULL(@PayDate,PayDate),
                GrossPay=ISNULL(@GrossPay,GrossPay),
                NetPay=ISNULL(@NetPay,NetPay),
                Deductions=ISNULL(@Deductions,Deductions)
            WHERE PayrollID=@PayrollID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetInventory
(
    @InventoryID INT=NULL OUTPUT,
    @MaterialID INT=NULL,
    @Quantity DECIMAL(10,2)=NULL,
    @Location VARCHAR(100)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @InventoryID IS NULL
        BEGIN
            IF @MaterialID IS NULL OR @Quantity IS NULL
            BEGIN
                PRINT 'MaterialID and Quantity required.';
                RETURN;
            END
            SELECT @InventoryID=ISNULL(MAX(InventoryID),0)+1 FROM Inventory;
            INSERT INTO Inventory(InventoryID, MaterialID, Quantity, Location)
            VALUES(@InventoryID, @MaterialID, @Quantity, @Location);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Inventory WHERE InventoryID=@InventoryID)
            BEGIN
                PRINT 'Inventory record not found.';
                RETURN;
            END
            UPDATE Inventory
            SET MaterialID=ISNULL(@MaterialID,MaterialID),
                Quantity=ISNULL(@Quantity,Quantity),
                Location=ISNULL(@Location,Location)
            WHERE InventoryID=@InventoryID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetInvoice
(
    @InvoiceID INT=NULL OUTPUT,
    @ClientID INT=NULL,
    @ProjectID INT=NULL,
    @InvoiceDate DATE=NULL,
    @TotalAmount DECIMAL(15,2)=NULL,
    @DueDate DATE=NULL,
    @Status VARCHAR(50)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @InvoiceID IS NULL
        BEGIN
            IF @ClientID IS NULL OR @ProjectID IS NULL OR @InvoiceDate IS NULL OR @TotalAmount IS NULL
            BEGIN
                PRINT 'ClientID, ProjectID, InvoiceDate, TotalAmount required.';
                RETURN;
            END
            SELECT @InvoiceID=ISNULL(MAX(InvoiceID),0)+1 FROM Invoices;
            INSERT INTO Invoices(InvoiceID, ClientID, ProjectID, InvoiceDate, TotalAmount, DueDate, Status)
            VALUES(@InvoiceID, @ClientID, @ProjectID, @InvoiceDate, @TotalAmount, @DueDate, ISNULL(@Status,'Unpaid'));
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Invoices WHERE InvoiceID=@InvoiceID)
            BEGIN
                PRINT 'Invoice not found.';
                RETURN;
            END
            UPDATE Invoices
            SET ClientID=ISNULL(@ClientID,ClientID),
                ProjectID=ISNULL(@ProjectID,ProjectID),
                InvoiceDate=ISNULL(@InvoiceDate,InvoiceDate),
                TotalAmount=ISNULL(@TotalAmount,TotalAmount),
                DueDate=ISNULL(@DueDate,DueDate),
                Status=ISNULL(@Status,Status)
            WHERE InvoiceID=@InvoiceID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetPayment
(
    @PaymentID INT=NULL OUTPUT,
    @InvoiceID INT=NULL,
    @PaymentDate DATE=NULL,
    @Amount DECIMAL(15,2)=NULL,
    @PaymentMethod VARCHAR(50)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @PaymentID IS NULL
        BEGIN
            IF @InvoiceID IS NULL OR @PaymentDate IS NULL OR @Amount IS NULL
            BEGIN
                PRINT 'InvoiceID, PaymentDate, Amount required.';
                RETURN;
            END
            SELECT @PaymentID=ISNULL(MAX(PaymentID),0)+1 FROM Payments;
            INSERT INTO Payments(PaymentID, InvoiceID, PaymentDate, Amount, PaymentMethod)
            VALUES(@PaymentID, @InvoiceID, @PaymentDate, @Amount, ISNULL(@PaymentMethod,'Unknown'));
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Payments WHERE PaymentID=@PaymentID)
            BEGIN
                PRINT 'Payment not found.';
                RETURN;
            END
            UPDATE Payments
            SET InvoiceID=ISNULL(@InvoiceID,InvoiceID),
                PaymentDate=ISNULL(@PaymentDate,PaymentDate),
                Amount=ISNULL(@Amount,Amount),
                PaymentMethod=ISNULL(@PaymentMethod,PaymentMethod)
            WHERE PaymentID=@PaymentID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetContract
(
    @ContractID INT=NULL OUTPUT,
    @ProjectID INT=NULL,
    @ClientID INT=NULL,
    @StartDate DATE=NULL,
    @EndDate DATE=NULL,
    @ContractAmount DECIMAL(15,2)=NULL,
    @Terms VARCHAR(MAX)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @ContractID IS NULL
        BEGIN
            IF @ProjectID IS NULL OR @ClientID IS NULL
            BEGIN
                PRINT 'ProjectID and ClientID required.';
                RETURN;
            END
            SELECT @ContractID=ISNULL(MAX(ContractID),0)+1 FROM Contracts;
            INSERT INTO Contracts(ContractID, ProjectID, ClientID, StartDate, EndDate, ContractAmount, Terms)
            VALUES(@ContractID, @ProjectID, @ClientID, @StartDate, @EndDate, ISNULL(@ContractAmount,0), @Terms);
        END
        ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Contracts WHERE ContractID=@ContractID)
            BEGIN
                PRINT 'Contract not found.';
                RETURN;
            END
            UPDATE Contracts
            SET ProjectID=ISNULL(@ProjectID,ProjectID),
                ClientID=ISNULL(@ClientID,ClientID),
                StartDate=ISNULL(@StartDate,StartDate),
                EndDate=ISNULL(@EndDate,EndDate),
                ContractAmount=ISNULL(@ContractAmount,ContractAmount),
                Terms=ISNULL(@Terms,Terms)
            WHERE ContractID=@ContractID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetSupplierMaterial
(
    @SupplierID INT,
    @MaterialID INT
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @SupplierID IS NULL OR @MaterialID IS NULL
        BEGIN
            PRINT 'SupplierID and MaterialID required.';
            RETURN;
        END

        IF EXISTS(SELECT 1 FROM SupplierMaterials WHERE SupplierID=@SupplierID AND MaterialID=@MaterialID)
        BEGIN
            PRINT 'This Supplier-Material link already exists.';
            RETURN;
        END

        INSERT INTO SupplierMaterials(SupplierID, MaterialID)
        VALUES(@SupplierID,@MaterialID);
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.SetProjectMaterial
(
    @ProjectID INT,
    @MaterialID INT,
    @Quantity DECIMAL(10,2)=NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @ProjectID IS NULL OR @MaterialID IS NULL
        BEGIN
            PRINT 'ProjectID and MaterialID required.';
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM ProjectMaterials WHERE ProjectID=@ProjectID AND MaterialID=@MaterialID)
        BEGIN
            IF @Quantity IS NULL
            BEGIN
                PRINT 'Quantity required for new ProjectMaterial.';
                RETURN;
            END
            INSERT INTO ProjectMaterials(ProjectID, MaterialID, Quantity)
            VALUES(@ProjectID,@MaterialID,@Quantity);
        END
        ELSE
        BEGIN
            -- Update
            UPDATE ProjectMaterials
            SET Quantity=ISNULL(@Quantity,Quantity)
            WHERE ProjectID=@ProjectID AND MaterialID=@MaterialID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO