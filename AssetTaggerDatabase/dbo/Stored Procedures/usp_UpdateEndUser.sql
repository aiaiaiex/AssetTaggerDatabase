CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    @EndUserID UNIQUEIDENTIFIER,
    @EndUserName NVARCHAR(50) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @NullifyEndUserRoleID BIT = 0,
    @NullifyEmployeeID BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate input.
    IF (@EndUserName IS NULL AND @EndUserRoleID IS NULL AND @EmployeeID IS NULL AND @NullifyEndUserRoleID = 0 AND @NullifyEmployeeID = 0)
        BEGIN
            RAISERROR ('Cannot update row with @EndUserID when no non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END

    IF (@NullifyEndUserRoleID = 1 AND @EndUserRoleID IS NOT NULL)
        BEGIN
            RAISERROR ('Cannot nullify EndUserRoleID when @EndUserRoleID is not null!', 11, 0);
            RETURN -1;
        END

    IF (@NullifyEmployeeID = 1 AND @EmployeeID IS NOT NULL)
        BEGIN
            RAISERROR ('Cannot nullify EmployeeID when @EmployeeID is not null!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.

    UPDATE [dbo].[EndUser]
    SET EndUserName = ISNULL(@EndUserName, EndUserName), EndUserRoleID = IIF(@NullifyEndUserRoleID = 1, NULL, ISNULL(@EndUserRoleID, EndUserRoleID)), EmployeeID = IIF(@NullifyEmployeeID = 1, NULL, ISNULL(@EmployeeID, EmployeeID))
    OUTPUT INSERTED.EndUserID, INSERTED.EndUserName, INSERTED.EndUserRoleID, INSERTED.EmployeeID, DELETED.EndUserName AS OldEndUserName, DELETED.EndUserRoleID AS OldEndUserRoleID, DELETED.EmployeeID AS OldEmployeeID
    FROM [dbo].[EndUser]
    WHERE EndUserID = @EndUserID;
END
