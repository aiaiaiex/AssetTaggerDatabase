CREATE PROCEDURE [dbo].[usp_CreateManufacturer]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Name NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateManufacturer BIT = (SELECT CreateManufacturer FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateManufacturer IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateManufacturer = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Manufacturer!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Manufacturer] (
        Name
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt
    VALUES (
        @Name
    );
END;
