CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Username NVARCHAR(850) = NULL,
    @EndUserRoleId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingEndUserPermission BIT = (SELECT HasReadingEndUserPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        Username,
        EndUserRoleId,
        EmployeeId,
        CreatedAt
    FROM
        [dbo].[EndUser]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (Username = COALESCE(@Username, Username) OR Username LIKE @Username)
        AND EndUserRoleId = COALESCE(@EndUserRoleId, EndUserRoleId)
        AND EmployeeId = COALESCE(@EmployeeId, EmployeeId)
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET COALESCE(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of RowNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT COALESCE(@RowsToReturn, 2147483647) ROWS ONLY;
END;
