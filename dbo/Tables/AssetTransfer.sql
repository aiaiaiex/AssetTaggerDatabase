CREATE TABLE [dbo].[AssetTransfer] (
    [AssetTransferID]                 UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_AssetTransfer_AssetTransferID] DEFAULT (newid()) NOT NULL,
    [AssetTransferDate]               DATETIME         NOT NULL,
    [AssetTransferPrice]              MONEY            NULL,
    [AssetID]                         UNIQUEIDENTIFIER NOT NULL,
    [CompanyID]                       UNIQUEIDENTIFIER NOT NULL,
    [AssetTransferReceivingCompanyID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AssetTransfer] PRIMARY KEY CLUSTERED ([AssetTransferID] ASC),
    CONSTRAINT [FK_AssetTransfer_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]),
    CONSTRAINT [FK_AssetTransfer_Company_AssetTransferReceivingCompanyID] FOREIGN KEY ([AssetTransferReceivingCompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_AssetTransfer_Company_CompanyID] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);

