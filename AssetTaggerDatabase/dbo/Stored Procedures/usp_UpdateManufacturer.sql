CREATE PROCEDURE [dbo].[usp_UpdateManufacturer]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingManufacturerPermission BIT = (SELECT HasUpdatingManufacturerPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingManufacturerPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingManufacturerPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Manufacturer!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Manufacturer]
    SET
        Name = COALESCE(@Name, Name)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName
    FROM
        [dbo].[Manufacturer]
    WHERE
        Id = @Id;
END;
