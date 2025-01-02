CREATE OR ALTER PROCEDURE dbo.CreateMonthlyPayrollFromTimesheets
(
    @EmployeeID INT,
    @Year INT,
    @Month INT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @EmployeeID IS NULL OR @Year IS NULL OR @Month IS NULL
        BEGIN
            PRINT 'EmployeeID, Year, and Month are required.';
            RETURN;
        END

        IF @Month < 1 OR @Month > 12
        BEGIN
            PRINT 'Month must be between 1 and 12.';
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
        BEGIN
            PRINT 'Employee not found.';
            RETURN;
        END

        DECLARE @StartDate DATE = CONVERT(DATE,
            CAST(@Year AS CHAR(4)) + '-' + RIGHT('0'+CAST(@Month AS VARCHAR(2)),2) + '-01', 120);
        DECLARE @EndDate DATE = EOMONTH(@StartDate);

        DECLARE @TotalHours DECIMAL(10,2) = (
            SELECT ISNULL(SUM(HoursWorked),0)
            FROM Timesheets
            WHERE EmployeeID = @EmployeeID
              AND WorkDate >= @StartDate
              AND WorkDate <= @EndDate
        );

        IF @TotalHours = 0
        BEGIN
            PRINT 'No hours worked for this employee in the given month.';
            RETURN;
        END

        DECLARE @Salary DECIMAL(10,2) = (
            SELECT Salary
            FROM Employees
            WHERE EmployeeID = @EmployeeID
        );

        IF @Salary IS NULL
        BEGIN
            PRINT 'Employee salary information not found.';
            RETURN;
        END

        DECLARE @GrossPay DECIMAL(10,2) = @Salary;
        DECLARE @Deductions DECIMAL(10,2) = @GrossPay * 0.2; 
        DECLARE @NetPay DECIMAL(10,2) = @GrossPay - @Deductions;

        DECLARE @PayDate DATE = @EndDate;

        DECLARE @PayrollID INT = NULL;

        EXEC dbo.SetPayroll
            @PayrollID = @PayrollID OUTPUT,
            @EmployeeID = @EmployeeID,
            @PayDate = @PayDate,
            @GrossPay = @GrossPay,
            @NetPay = @NetPay,
            @Deductions = @Deductions;

        PRINT 'Payroll created: ID=' + CAST(@PayrollID AS VARCHAR(10))
            + ', Gross=' + CAST(@GrossPay AS VARCHAR(20))
            + ', Net=' + CAST(@NetPay AS VARCHAR(20))
            + ', Ded=' + CAST(@Deductions AS VARCHAR(20)) + '.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.HireNewEmployee
(
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @PositionID INT,
    @DepartmentID INT,
    @HireDate DATE,
    @Salary DECIMAL(10, 2),
    @Phone VARCHAR(20),
    @Email VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @FirstName IS NULL OR @LastName IS NULL OR @PositionID IS NULL
           OR @DepartmentID IS NULL OR @HireDate IS NULL OR @Salary IS NULL
        BEGIN
            PRINT 'All fields are mandatory for hiring a new employee.';
            RETURN;
        END

        DECLARE @EmpID INT = NULL;

        EXEC dbo.SetEmployee
            @EmployeeID = @EmpID OUTPUT,
            @FirstName = @FirstName,
            @LastName = @LastName,
            @PositionID = @PositionID,
            @DepartmentID = @DepartmentID,
            @HireDate = @HireDate,
            @Salary = @Salary,
            @Phone = @Phone,
            @Email = @Email;

        PRINT 'Hired new employee with EmployeeID=' + CAST(@EmpID AS VARCHAR(10));

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.AddMaterialToProject
(
    @ProjectID INT,
    @MaterialID INT,
    @Quantity DECIMAL(10,2)
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @ProjectID IS NULL OR @MaterialID IS NULL OR @Quantity IS NULL
        BEGIN
            PRINT 'ProjectID, MaterialID, and Quantity are required.';
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM Projects WHERE ProjectID=@ProjectID)
        BEGIN
            PRINT 'Project not found.';
            RETURN;
        END

        IF NOT EXISTS(SELECT 1 FROM Materials WHERE MaterialID=@MaterialID)
        BEGIN
            PRINT 'Material not found.';
            RETURN;
        END

        EXEC dbo.SetProjectMaterial
            @ProjectID = @ProjectID,
            @MaterialID = @MaterialID,
            @Quantity = @Quantity;

        PRINT 'Material ' + CAST(@MaterialID AS VARCHAR(10))
            + ' => Project ' + CAST(@ProjectID AS VARCHAR(10))
            + ': quantity=' + CAST(@Quantity AS VARCHAR(20));
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO