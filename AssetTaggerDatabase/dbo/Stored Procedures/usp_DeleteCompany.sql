CREATE PROCEDURE [dbo].[usp_DeleteCompany]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Company';

    -- Run actual query.
    DELETE [dbo].[Company]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Nullable foreign keys.
        DELETED.ParentCompanyId,
        -- Non-nullable columns.
        DELETED.Address,
        DELETED.Code,
        DELETED.Name
    FROM
        [dbo].[Company]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
