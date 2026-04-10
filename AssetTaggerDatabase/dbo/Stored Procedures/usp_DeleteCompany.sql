CREATE PROCEDURE [dbo].[usp_DeleteCompany]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingCompanyPermission BIT = (SELECT HasDeletingCompanyPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingCompanyPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingCompanyPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a Company!', 11, 0);
            RETURN -1;
        END;

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
