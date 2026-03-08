CREATE PROCEDURE [dbo].[usp_DeleteEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteEndUser BIT;
    SELECT @DeleteEndUser = (SELECT DeleteEndUser FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteEndUser IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@DeleteEndUser = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete an EndUser!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    DELETE [dbo].[EndUser]
    OUTPUT DELETED.EndUserID, DELETED.EndUserName, DELETED.EndUserRoleID, DELETED.EmployeeID
    FROM [dbo].[EndUser]
    WHERE EndUserID = @EndUserID;
END
