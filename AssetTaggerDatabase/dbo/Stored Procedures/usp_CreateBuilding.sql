CREATE PROCEDURE [dbo].[usp_CreateBuilding]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Name NVARCHAR(850),
    @Address NVARCHAR(850),
    @CompanyId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingBuildingPermission BIT = (SELECT HasCreatingBuildingPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingBuildingPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingBuildingPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Building] (
        Name,
        Address,
        CompanyId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CompanyId,
        INSERTED.CreatedAt
    VALUES (
        @Name,
        @Address,
        @CompanyId
    );
END;
