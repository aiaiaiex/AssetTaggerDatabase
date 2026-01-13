CREATE PROCEDURE usp_GetAssetsTranseferredByCompany
    @CompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT AssetID
    FROM [dbo].[AssetTransfer]
    WHERE CompanyID = @CompanyID;
END
GO

