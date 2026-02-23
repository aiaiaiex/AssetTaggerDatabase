CREATE PROCEDURE [dbo].[usp_DeleteEndUser]
    @EndUserID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DELETE [dbo].[EndUser]
    OUTPUT DELETED.EndUserID, DELETED.EndUserName, DELETED.EndUserRoleID, DELETED.EmployeeID
    FROM [dbo].[EndUser]
    WHERE EndUserID = @EndUserID;
END
