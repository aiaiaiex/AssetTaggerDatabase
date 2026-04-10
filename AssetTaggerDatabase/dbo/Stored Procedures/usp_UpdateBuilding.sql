CREATE PROCEDURE [dbo].[usp_UpdateBuilding]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @CompanyId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingBuildingPermission BIT = (SELECT HasUpdatingBuildingPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingBuildingPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingBuildingPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Building]
    SET
        Name = COALESCE(@Name, Name),
        Address = COALESCE(@Address, Address),
        CompanyId = COALESCE(@CompanyId, CompanyId)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CompanyId,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName,
        DELETED.Address AS OldAddress,
        DELETED.CompanyId AS OldCompanyId
    FROM
        [dbo].[Building]
    WHERE
        Id = @Id;
END;
