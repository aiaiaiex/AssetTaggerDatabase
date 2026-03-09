CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserID UNIQUEIDENTIFIER = NULL,
    @EndUserName NVARCHAR(4000) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadEndUser BIT;
    SELECT @ReadEndUser = (SELECT ReadEndUser FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadEndUser IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@ReadEndUser = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read EndUser!', 11, 0);
            RETURN -1;
        END

    -- Validate input.
    IF (@EndUserID IS NOT NULL AND (@EndUserName IS NOT NULL OR @EndUserRoleID IS NOT NULL OR @EmployeeID IS NOT NULL))
        BEGIN
            RAISERROR ('Cannot get row with unique @EndUserID when non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    SELECT
        EndUserID,
        EndUserName,
        EndUserRoleID,
        EmployeeID
    FROM [dbo].[EndUser]
    WHERE EndUserID = ISNULL(@EndUserID, EndUserID) AND EndUserName = ISNULL(@EndUserName, EndUserName) AND EndUserRoleID = ISNULL(@EndUserRoleID, EndUserRoleID) AND EmployeeID = ISNULL(@EmployeeID, EmployeeID)
    ORDER BY
        EndUserNumber ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END
