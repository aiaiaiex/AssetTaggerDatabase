CREATE PROCEDURE [dbo].[usp_CreateBuilding]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Name NVARCHAR(850),
    @Address NVARCHAR(850),
    @CompanyID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingBuildingPermission BIT = (SELECT HasCreatingBuildingPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasCreatingBuildingPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingBuildingPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Building] (
        Name,
        Address,
        CompanyID
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CompanyID,
        INSERTED.CreatedAt
    VALUES (
        @Name,
        @Address,
        @CompanyID
    );
END;
