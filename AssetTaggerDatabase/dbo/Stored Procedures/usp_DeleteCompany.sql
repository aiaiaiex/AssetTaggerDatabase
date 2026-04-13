CREATE PROCEDURE [dbo].[usp_DeleteCompany]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
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
        DELETED.Id,
        DELETED.Name,
        DELETED.Address,
        DELETED.Code,
        DELETED.ParentCompanyId,
        DELETED.CreatedAt
    FROM
        [dbo].[Company]
    WHERE
        Id = @Id;
END;
