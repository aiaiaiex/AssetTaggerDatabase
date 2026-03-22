CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserID UNIQUEIDENTIFIER = NULL,
    @EndUserName NVARCHAR(850) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @FromEndUserRegisterDate DATETIMEOFFSET(3) = NULL,
    @ToEndUserRegisterDate DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadEndUser BIT = (SELECT ReadEndUser FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadEndUser IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadEndUser = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Validate input.
    IF (
        @EndUserID IS NOT NULL
        AND (
            @EndUserName IS NOT NULL
            OR @EndUserRoleID IS NOT NULL
            OR @EmployeeID IS NOT NULL
            OR @FromEndUserRegisterDate IS NOT NULL
            OR @ToEndUserRegisterDate IS NOT NULL
            OR @RowsToSkip IS NOT NULL
            OR @RowsToReturn IS NOT NULL
        )
    )
        BEGIN
            RAISERROR ('Cannot get row with unique @EndUserID when non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END;

    IF (@EndUserName IN ('', '!', 'NULL'))
        BEGIN
            RAISERROR (N'@EndUserName cannot be ''%s''!', 11, 0, @EndUserName);
            RETURN -1;
        END;

    IF (LEN(@EndUserName) < 1)
        BEGIN
            RAISERROR ('@EndUserName''s length cannot be less than 1!', 11, 0);
            RETURN -1;
        END;

    IF (CHARINDEX(' ', @EndUserName) != 0)
        BEGIN
            RAISERROR ('@EndUserName cannot have whitespace!', 11, 0);
            RETURN -1;
        END;

    IF (@FromEndUserRegisterDate > @ToEndUserRegisterDate)
        BEGIN
            RAISERROR ('@FromEndUserRegisterDate cannot be later than @ToEndUserRegisterDate!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        EndUserID,
        EndUserName,
        EndUserRoleID,
        EmployeeID,
        EndUserRegisterDate
    FROM
        [dbo].[EndUser]
    WHERE
        EndUserID = ISNULL(@EndUserID, EndUserID)
        AND (EndUserName = ISNULL(@EndUserName, EndUserName) OR EndUserName LIKE @EndUserName)
        AND EndUserRoleID = ISNULL(@EndUserRoleID, EndUserRoleID)
        AND EmployeeID = ISNULL(@EmployeeID, EmployeeID)
        AND ISNULL(@FromEndUserRegisterDate, EndUserRegisterDate) <= EndUserRegisterDate
        AND EndUserRegisterDate <= ISNULL(@ToEndUserRegisterDate, EndUserRegisterDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN EndUserNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN EndUserNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
