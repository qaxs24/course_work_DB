CREATE OR ALTER PROCEDURE dbo.GetPositions
(
    @FilterName     VARCHAR(100) = NULL,
    @SortColumn     VARCHAR(50)  = 'PositionName', -- Допустимі: PositionID, PositionName, SalaryGrade
    @SortDirection  BIT          = 0,             -- 0-ASC, 1-DESC
    @PageNumber     INT          = 1,
    @PageSize       INT          = 10
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT 
        PositionID,
        PositionName,
        SalaryGrade
    FROM Positions
    WHERE (@FilterName IS NULL OR PositionName LIKE '%' + @FilterName + '%')
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'PositionID'   THEN CONVERT(VARCHAR(50), PositionID)
                WHEN 'PositionName' THEN PositionName
                WHEN 'SalaryGrade'  THEN SalaryGrade
                ELSE PositionName
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'PositionID'   THEN CONVERT(VARCHAR(50), PositionID)
                WHEN 'PositionName' THEN PositionName
                WHEN 'SalaryGrade'  THEN SalaryGrade
                ELSE PositionName
            END
        END DESC
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
GO

CREATE OR ALTER PROCEDURE dbo.GetDepartments
(
    @FilterName     VARCHAR(100) = NULL,
    @SortColumn     VARCHAR(50)  = 'DepartmentName', -- Допустимі: DepartmentID, DepartmentName, ManagerID
    @SortDirection  BIT          = 0,                -- 0-ASC, 1-DESC
    @PageNumber     INT          = 1,
    @PageSize       INT          = 10
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT
        DepartmentID,
        DepartmentName,
        ManagerID
    FROM Departments
    WHERE (@FilterName IS NULL OR DepartmentName LIKE '%' + @FilterName + '%')
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'DepartmentID'   THEN CONVERT(VARCHAR(50), DepartmentID)
                WHEN 'DepartmentName' THEN DepartmentName
                WHEN 'ManagerID'      THEN CONVERT(VARCHAR(50), ManagerID)
                ELSE DepartmentName
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'DepartmentID'   THEN CONVERT(VARCHAR(50), DepartmentID)
                WHEN 'DepartmentName' THEN DepartmentName
                WHEN 'ManagerID'      THEN CONVERT(VARCHAR(50), ManagerID)
                ELSE DepartmentName
            END
        END DESC
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
GO

CREATE OR ALTER PROCEDURE dbo.GetClients
(
    @FilterName     VARCHAR(100) = NULL,
    @SortColumn     VARCHAR(50)  = 'CompanyName', -- Допустимі: ClientID, CompanyName, ContactName
    @SortDirection  BIT          = 0,
    @PageNumber     INT          = 1,
    @PageSize       INT          = 10
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT
        ClientID,
        CompanyName,
        ContactName,
        Phone,
        Email,
        Address
    FROM Clients
    WHERE (@FilterName IS NULL OR CompanyName LIKE '%' + @FilterName + '%')
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'ClientID'    THEN CONVERT(VARCHAR(50), ClientID)
                WHEN 'CompanyName' THEN CompanyName
                WHEN 'ContactName' THEN ContactName
                ELSE CompanyName
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'ClientID'    THEN CONVERT(VARCHAR(50), ClientID)
                WHEN 'CompanyName' THEN CompanyName
                WHEN 'ContactName' THEN ContactName
                ELSE CompanyName
            END
        END DESC
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
GO

CREATE OR ALTER PROCEDURE dbo.GetSuppliers
(
    @FilterName     VARCHAR(100) = NULL,
    @SortColumn     VARCHAR(50)  = 'CompanyName', -- Допустимі: SupplierID, CompanyName, ContactName
    @SortDirection  BIT          = 0,
    @PageNumber     INT          = 1,
    @PageSize       INT          = 10
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT
        SupplierID,
        CompanyName,
        ContactName,
        Phone,
        Email,
        Address
    FROM Suppliers
    WHERE (@FilterName IS NULL OR CompanyName LIKE '%' + @FilterName + '%')
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'SupplierID'   THEN CONVERT(VARCHAR(50), SupplierID)
                WHEN 'CompanyName'  THEN CompanyName
                WHEN 'ContactName'  THEN ContactName
                ELSE CompanyName
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'SupplierID'   THEN CONVERT(VARCHAR(50), SupplierID)
                WHEN 'CompanyName'  THEN CompanyName
                WHEN 'ContactName'  THEN ContactName
                ELSE CompanyName
            END
        END DESC
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
GO

CREATE OR ALTER PROCEDURE dbo.GetMaterials
(
    @FilterName     VARCHAR(100) = NULL,
    @SortColumn     VARCHAR(50)  = 'MaterialName', -- Допустимі: MaterialID, MaterialName, UnitPrice
    @SortDirection  BIT          = 0,
    @PageNumber     INT          = 1,
    @PageSize       INT          = 10
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT
        MaterialID,
        MaterialName,
        UnitPrice,
        Unit
    FROM Materials
    WHERE (@FilterName IS NULL OR MaterialName LIKE '%' + @FilterName + '%')
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'MaterialID'   THEN CONVERT(VARCHAR(50), MaterialID)
                WHEN 'MaterialName' THEN MaterialName
                WHEN 'UnitPrice'    THEN CONVERT(VARCHAR(50), UnitPrice)
                ELSE MaterialName
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'MaterialID'   THEN CONVERT(VARCHAR(50), MaterialID)
                WHEN 'MaterialName' THEN MaterialName
                WHEN 'UnitPrice'    THEN CONVERT(VARCHAR(50), UnitPrice)
                ELSE MaterialName
            END
        END DESC
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
GO
