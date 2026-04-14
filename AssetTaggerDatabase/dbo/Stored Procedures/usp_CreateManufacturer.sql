CREATE PROCEDURE [dbo].[usp_CreateManufacturer]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Manufacturer';

    -- Run actual query.
    INSERT INTO [dbo].[Manufacturer] (
        -- Non-nullable columns.
        Name
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable columns.
        INSERTED.Name
    VALUES (
        -- Non-nullable columns.
        [dbo].[udf_GetDefaultNvarchar](@Name, NULL)
    );
END;
