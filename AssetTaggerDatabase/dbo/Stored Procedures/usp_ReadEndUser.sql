CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Username NVARCHAR(850) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIMEOFFSET(3) = NULL,
    @ToCreatedAt DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingEndUserPermission BIT = (SELECT HasReadingEndUserPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasReadingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Validate input.
    IF (
        @Id IS NOT NULL
        AND (
            @Username IS NOT NULL
            OR @EndUserRoleID IS NOT NULL
            OR @EmployeeID IS NOT NULL
            OR @FromCreatedAt IS NOT NULL
            OR @ToCreatedAt IS NOT NULL
            OR @RowsToSkip IS NOT NULL
            OR @RowsToReturn IS NOT NULL
        )
    )
        BEGIN
            RAISERROR ('Cannot get row with unique @Id when non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END;

    IF (@Username IN ('', '!', 'NULL'))
        BEGIN
            RAISERROR (N'@Username cannot be ''%s''!', 11, 0, @Username);
            RETURN -1;
        END;

    IF (LEN(@Username) < 1)
        BEGIN
            RAISERROR ('@Username''s length cannot be less than 1!', 11, 0);
            RETURN -1;
        END;

    IF (CHARINDEX(' ', @Username) != 0)
        BEGIN
            RAISERROR ('@Username cannot have whitespace!', 11, 0);
            RETURN -1;
        END;

    IF (@FromCreatedAt > @ToCreatedAt)
        BEGIN
            RAISERROR ('@FromCreatedAt cannot be later than @ToCreatedAt!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        Username,
        EndUserRoleID,
        EmployeeID,
        CreatedAt
    FROM
        [dbo].[EndUser]
    WHERE
        Id = ISNULL(@Id, Id)
        AND (Username = ISNULL(@Username, Username) OR Username LIKE @Username)
        AND EndUserRoleID = ISNULL(@EndUserRoleID, EndUserRoleID)
        AND EmployeeID = ISNULL(@EmployeeID, EmployeeID)
        AND ISNULL(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= ISNULL(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of RowNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
