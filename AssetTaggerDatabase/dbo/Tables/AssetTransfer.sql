CREATE TABLE [dbo].[AssetTransfer] (
    [AssetTransferNumber] INT IDENTITY (1, 1),
    [AssetTransferID] UNIQUEIDENTIFIER CONSTRAINT [DF_AssetTransfer_AssetTransferID] DEFAULT (NEWID()) NOT NULL,
    [AssetTransferDate] DATETIME NOT NULL,
    [AssetTransferPrice] DECIMAL(19, 4) NULL,
    [AssetID] UNIQUEIDENTIFIER NOT NULL,
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    [ReceivingCompanyID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_AssetTransfer_AssetTransferNumber] UNIQUE CLUSTERED ([AssetTransferNumber] ASC),
    CONSTRAINT [PK_AssetTransfer] PRIMARY KEY NONCLUSTERED ([AssetTransferID] ASC),
    CONSTRAINT [FK_AssetTransfer_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]),
    CONSTRAINT [FK_AssetTransfer_Company_CompanyID] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_AssetTransfer_Company_ReceivingCompanyID] FOREIGN KEY ([ReceivingCompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);
