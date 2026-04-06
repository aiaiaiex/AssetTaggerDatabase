CREATE PROCEDURE [dbo].[usp_UpdateCompany]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CompanyID UNIQUEIDENTIFIER,
    @CompanyName NVARCHAR(850) = NULL,
    @CompanyAddress NVARCHAR(850) = NULL,
    @CompanyCode NVARCHAR(5) = NULL,
    @ParentCompanyID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingCompanyPermission BIT = (SELECT HasUpdatingCompanyPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingCompanyPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingCompanyPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Company!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);

    -- Run actual query.
    UPDATE
        [dbo].[Company]
    SET
        CompanyName = ISNULL(@CompanyName, CompanyName),
        CompanyAddress = ISNULL(@CompanyAddress, CompanyAddress),
        CompanyCode = ISNULL(@CompanyCode, CompanyCode),
        ParentCompanyID = IIF(@ParentCompanyID = @NULLISH_UNIQUEIDENTIFIER, ParentCompanyID, @ParentCompanyID)
    OUTPUT
        INSERTED.CompanyID,
        INSERTED.CompanyName,
        INSERTED.CompanyAddress,
        INSERTED.CompanyCode,
        INSERTED.ParentCompanyID,
        INSERTED.CompanyInsertDate,
        DELETED.CompanyName AS OldCompanyName,
        DELETED.CompanyAddress AS OldCompanyAddress,
        DELETED.CompanyCode AS OldCompanyCode,
        DELETED.ParentCompanyID AS OldParentCompanyID
    FROM
        [dbo].[Company]
    WHERE
        CompanyID = @CompanyID;
END;
