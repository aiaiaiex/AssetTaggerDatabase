CREATE FUNCTION [dbo].[tvf_GetSubsidiariesOfCompany](
    @ParentCompanyID UNIQUEIDENTIFIER
)
RETURNS @Subsidiary TABLE
(
    [SubsidiaryID] UNIQUEIDENTIFIER
)
AS
BEGIN
    INSERT INTO @Subsidiary
    SELECT CompanyID FROM [dbo].[Company]
    WHERE ParentCompanyID = @ParentCompanyID
    RETURN
END;
