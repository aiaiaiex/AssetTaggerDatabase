CREATE PROCEDURE [dbo].[usp_CreateCompany]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CompanyName NVARCHAR(850),
    @CompanyAddress NVARCHAR(850),
    @CompanyCode NVARCHAR(5),
    @ParentCompanyID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateCompany BIT = (SELECT CreateCompany FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateCompany IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateCompany = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Company!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Company] (
        CompanyName,
        CompanyAddress,
        CompanyCode,
        ParentCompanyID
    )
    OUTPUT
        INSERTED.CompanyID,
        INSERTED.CompanyName,
        INSERTED.CompanyAddress,
        INSERTED.CompanyCode,
        INSERTED.ParentCompanyID,
        INSERTED.CompanyInsertDate
    VALUES (
        @CompanyName,
        @CompanyAddress,
        @CompanyCode,
        @ParentCompanyID
    );
END;
