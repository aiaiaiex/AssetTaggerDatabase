CREATE PROCEDURE usp_GetAssetsReceivedByCompany
    @ReceivingCompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT AssetID
    FROM [dbo].[AssetTransfer]
    WHERE ReceivingCompanyID = @ReceivingCompanyID;
END
GO

