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

    UPDATE [dbo].[EndUser]
    SET EndUserName = ISNULL(@EndUserName, EndUserName), EndUserRoleID = IIF(@NullifyEndUserRoleID = 1, NULL, ISNULL(@EndUserRoleID, EndUserRoleID)), EmployeeID = IIF(@NullifyEmployeeID = 1, NULL, ISNULL(@EmployeeID, EmployeeID))
    OUTPUT INSERTED.EndUserID, INSERTED.EndUserName, INSERTED.EndUserRoleID, INSERTED.EmployeeID, DELETED.EndUserName AS OldEndUserName, DELETED.EndUserRoleID AS OldEndUserRoleID, DELETED.EmployeeID AS OldEmployeeID
    FROM [dbo].[EndUser]
    WHERE EndUserID = @EndUserID AND (@EndUserName IS NOT NULL OR @EndUserRoleID IS NOT NULL OR @EmployeeID IS NOT NULL OR @NullifyEndUserRoleID = 1 OR @NullifyEmployeeID = 1) AND ((@NullifyEndUserRoleID = 1 AND @EndUserRoleID IS NULL) OR (@NullifyEndUserRoleID = 0)) AND ((@NullifyEmployeeID = 1 AND @EmployeeID IS NULL) OR (@NullifyEmployeeID = 0));
END
