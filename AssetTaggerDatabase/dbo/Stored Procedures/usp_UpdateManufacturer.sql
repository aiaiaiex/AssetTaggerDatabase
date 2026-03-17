CREATE PROCEDURE [dbo].[usp_UpdateManufacturer]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ManufacturerID UNIQUEIDENTIFIER,
    @ManufacturerName NVARCHAR(850) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateManufacturer BIT;
    SELECT @UpdateManufacturer = (SELECT UpdateManufacturer FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateManufacturer IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@UpdateManufacturer = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Manufacturer!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    UPDATE [dbo].[Manufacturer]
    SET ManufacturerName = ISNULL(@ManufacturerName, ManufacturerName)
    OUTPUT INSERTED.ManufacturerID, INSERTED.ManufacturerName, INSERTED.ManufacturerInsertDate, DELETED.ManufacturerName AS OldManufacturerName
    FROM [dbo].[Manufacturer]
    WHERE ManufacturerID = @ManufacturerID;
END
