CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    @EndUserID UNIQUEIDENTIFIER,
    @EndUserName NVARCHAR(50) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @EmployeeID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
AS
BEGIN
    SET NOCOUNT ON;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER;
    SELECT @NULLISH_UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);

    -- Validate input.
    IF (@EndUserName IS NULL AND @EndUserRoleID = @NULLISH_UNIQUEIDENTIFIER AND @EmployeeID = @NULLISH_UNIQUEIDENTIFIER)
        BEGIN
            RAISERROR ('Cannot update row with @EndUserID when no non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    UPDATE [dbo].[EndUser]
    SET EndUserName = ISNULL(@EndUserName, EndUserName), EndUserRoleID = IIF(@EndUserRoleID = @NULLISH_UNIQUEIDENTIFIER, EndUserRoleID, @EndUserRoleID), EmployeeID = IIF(@EmployeeID = @NULLISH_UNIQUEIDENTIFIER, EmployeeID, @EmployeeID)
    OUTPUT INSERTED.EndUserID, INSERTED.EndUserName, INSERTED.EndUserRoleID, INSERTED.EmployeeID, DELETED.EndUserName AS OldEndUserName, DELETED.EndUserRoleID AS OldEndUserRoleID, DELETED.EmployeeID AS OldEmployeeID
    FROM [dbo].[EndUser]
    WHERE EndUserID = @EndUserID;
END
