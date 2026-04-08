CREATE PROCEDURE [dbo].[usp_ReadEmployee]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @FullName NVARCHAR(850) = NULL,
    @RoleID UNIQUEIDENTIFIER = NULL,
    @CompanyID UNIQUEIDENTIFIER = NULL,
    @DepartmentID UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIMEOFFSET(3) = NULL,
    @ToCreatedAt DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingEmployeePermission BIT = (SELECT HasReadingEmployeePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasReadingEmployeePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingEmployeePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Employee!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        FullName,
        RoleID,
        CompanyID,
        DepartmentID,
        CreatedAt
    FROM
        [dbo].[Employee]
    WHERE
        Id = ISNULL(@Id, Id)
        AND (FullName = ISNULL(@FullName, FullName) OR FullName LIKE @FullName)
        AND RoleID = ISNULL(@RoleID, RoleID)
        AND CompanyID = ISNULL(@CompanyID, CompanyID)
        AND DepartmentID = ISNULL(@DepartmentID, DepartmentID)
        AND ISNULL(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= ISNULL(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
