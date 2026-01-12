CREATE TABLE [dbo].[AssetTransfer] (
    [AssetTransferID]                    UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_AssetTransfer_AssetTransferID] DEFAULT (newid()) NOT NULL,
    [AssetTransferReceivingCompanyID]    UNIQUEIDENTIFIER NULL,
    [AssetTransferReceivingSubCompanyID] UNIQUEIDENTIFIER NULL,
    [AssetTransferDate]                  DATETIME         NOT NULL,
    [AssetTransferPrice]                 MONEY            NULL,
    [AssetID]                            UNIQUEIDENTIFIER NOT NULL,
    [CompanyID]                          UNIQUEIDENTIFIER NULL,
    [SubCompanyID]                       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_AssetTransfer] PRIMARY KEY CLUSTERED ([AssetTransferID] ASC),
    CONSTRAINT [CK_AssetTransfer_AssetTransferReceivingSubOrCompanyIDNotNull] CHECK ([AssetTransferReceivingCompanyID] IS NOT NULL OR [AssetTransferReceivingSubCompanyID] IS NOT NULL),
    CONSTRAINT [CK_AssetTransfer_SubORCompanyIDNotNull] CHECK ([CompanyID] IS NOT NULL OR [SubCompanyID] IS NOT NULL),
    CONSTRAINT [FK_AssetTransfer_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]),
    CONSTRAINT [FK_AssetTransfer_Company_AssetTransferReceivingCompanyID] FOREIGN KEY ([AssetTransferReceivingCompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_AssetTransfer_Company_CompanyID] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_AssetTransfer_SubCompany_AssetTransferReceivingSubCompanyID] FOREIGN KEY ([AssetTransferReceivingSubCompanyID]) REFERENCES [dbo].[SubCompany] ([SubCompanyID]),
    CONSTRAINT [FK_AssetTransfer_SubCompany_SubCompanyID] FOREIGN KEY ([SubCompanyID]) REFERENCES [dbo].[SubCompany] ([SubCompanyID])
);

