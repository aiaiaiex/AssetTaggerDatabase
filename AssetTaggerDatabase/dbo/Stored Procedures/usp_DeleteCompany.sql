CREATE PROCEDURE [dbo].[usp_DeleteCompany]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CompanyID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingCompanyPermission BIT = (SELECT HasDeletingCompanyPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingCompanyPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingCompanyPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Company!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Company]
    OUTPUT
        DELETED.CompanyID,
        DELETED.CompanyName,
        DELETED.CompanyAddress,
        DELETED.CompanyCode,
        DELETED.ParentCompanyID,
        DELETED.CompanyInsertDate
    FROM
        [dbo].[Company]
    WHERE
        CompanyID = @CompanyID;
END;
