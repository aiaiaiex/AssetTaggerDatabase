CREATE FUNCTION [dbo].[tvf_GetSubsidiariesOfCompany] (
    @ParentCompanyID UNIQUEIDENTIFIER
)
RETURNS @SubCompanyIDs TABLE
(
    [SubCompanyID] UNIQUEIDENTIFIER
)
AS
BEGIN
    INSERT INTO @SubCompanyIDs
    SELECT CompanyID FROM [dbo].[SubCompany] WHERE ParentCompanyID = @ParentCompanyID
    RETURN
END;
GO

