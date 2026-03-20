CREATE TABLE [dbo].[AssetTransfer] (
    [AssetTransferNumber] INT IDENTITY (1, 1),
    [AssetTransferID] UNIQUEIDENTIFIER CONSTRAINT [DF_AssetTransfer_AssetTransferID] DEFAULT (NEWID()) NOT NULL,
    [AssetTransferDate] DATETIMEOFFSET(3) NOT NULL,
    [AssetTransferPrice] DECIMAL(15, 4) NULL,
    [AssetTransferDocumentationURL] NVARCHAR(4000) NULL,
    [AssetID] UNIQUEIDENTIFIER NOT NULL,
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    [ReceivingCompanyID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_AssetTransfer_AssetTransferNumber] UNIQUE CLUSTERED ([AssetTransferNumber] ASC),
    CONSTRAINT [CK_AssetTransfer_AssetTransferDocumentationURL_Exclude] CHECK ([AssetTransferDocumentationURL] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_AssetTransfer_AssetTransferDocumentationURL_MinimumLength] CHECK (LEN([AssetTransferDocumentationURL]) > 0),
    CONSTRAINT [CK_AssetTransfer_AssetTransferDocumentationURL_NoLeadingAndTrailingWhitespace] CHECK ([AssetTransferDocumentationURL] NOT LIKE ' %' AND [AssetTransferDocumentationURL] NOT LIKE '% '),
    CONSTRAINT [CK_AssetTransfer_AssetTransferPrice_Exclude] CHECK ([AssetTransferPrice] NOT IN (CONVERT(DECIMAL(15, 4), -99999999999.9999), CONVERT(DECIMAL(15, 4), 99999999999.9999))),
    CONSTRAINT [PK_AssetTransfer] PRIMARY KEY NONCLUSTERED ([AssetTransferID] ASC),
    CONSTRAINT [FK_AssetTransfer_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]),
    CONSTRAINT [FK_AssetTransfer_Company_CompanyID] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_AssetTransfer_Company_ReceivingCompanyID] FOREIGN KEY ([ReceivingCompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);
