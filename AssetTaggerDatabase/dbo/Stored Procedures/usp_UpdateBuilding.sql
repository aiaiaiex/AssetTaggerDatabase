CREATE PROCEDURE [dbo].[usp_UpdateBuilding]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @CompanyID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingBuildingPermission BIT = (SELECT HasUpdatingBuildingPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

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
        Name = ISNULL(@Name, Name),
        Address = ISNULL(@Address, Address),
        CompanyID = ISNULL(@CompanyID, CompanyID)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CompanyID,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName,
        DELETED.Address AS OldAddress,
        DELETED.CompanyID AS OldCompanyID
    FROM
        [dbo].[Building]
    WHERE
        Id = @Id;
END;
