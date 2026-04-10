CREATE PROCEDURE [dbo].[usp_ReadEmployee]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @FullName NVARCHAR(850) = NULL,
    @RoleId UNIQUEIDENTIFIER = NULL,
    @CompanyId UNIQUEIDENTIFIER = NULL,
    @DepartmentId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingEmployeePermission BIT = (SELECT HasReadingEmployeePermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingEmployeePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingEmployeePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Employee!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        FullName,
        RoleId,
        CompanyId,
        DepartmentId,
        CreatedAt
    FROM
        [dbo].[Employee]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (FullName = COALESCE(@FullName, FullName) OR FullName LIKE @FullName)
        AND RoleId = COALESCE(@RoleId, RoleId)
        AND CompanyId = COALESCE(@CompanyId, CompanyId)
        AND DepartmentId = COALESCE(@DepartmentId, DepartmentId)
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET COALESCE(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT COALESCE(@RowsToReturn, 2147483647) ROWS ONLY;
END;
