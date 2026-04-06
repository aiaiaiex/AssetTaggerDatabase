CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserID UNIQUEIDENTIFIER,
    @EndUserName NVARCHAR(850) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingEndUserPermission BIT = (SELECT HasUpdatingEndUserPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Validate input.
    IF (@EndUserName IS NULL AND @EndUserRoleID IS NULL AND @EmployeeID IS NULL)
        BEGIN
            RAISERROR ('Cannot update row with @EndUserID when no non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[EndUser]
    SET
        EndUserName = ISNULL(@EndUserName, EndUserName),
        EndUserRoleID = ISNULL(@EndUserRoleID, EndUserRoleID),
        EmployeeID = ISNULL(@EmployeeID, EmployeeID)
    OUTPUT
        INSERTED.EndUserID,
        INSERTED.EndUserName,
        INSERTED.EndUserRoleID,
        INSERTED.EmployeeID,
        INSERTED.EndUserRegisterDate,
        DELETED.EndUserName AS OldEndUserName,
        DELETED.EndUserRoleID AS OldEndUserRoleID,
        DELETED.EmployeeID AS OldEmployeeID
    FROM
        [dbo].[EndUser]
    WHERE
        EndUserID = @EndUserID;
END;
