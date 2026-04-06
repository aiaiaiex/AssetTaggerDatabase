CREATE PROCEDURE [dbo].[usp_CreateCompany]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Name NVARCHAR(850),
    @Address NVARCHAR(850),
    @Code NVARCHAR(5),
    @ParentCompanyId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingCompanyPermission BIT = (SELECT HasCreatingCompanyPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasCreatingCompanyPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingCompanyPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Company!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Company] (
        Name,
        Address,
        Code,
        ParentCompanyId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.Code,
        INSERTED.ParentCompanyId,
        INSERTED.CreatedAt
    VALUES (
        @Name,
        @Address,
        @Code,
        @ParentCompanyId
    );
END;
