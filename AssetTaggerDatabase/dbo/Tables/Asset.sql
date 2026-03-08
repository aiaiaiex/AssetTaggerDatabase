CREATE TABLE [dbo].[Asset] (
    [AssetID] UNIQUEIDENTIFIER CONSTRAINT [DF_Asset_AssetID] DEFAULT (NEWID()) NOT NULL,
    [AssetTagDate] DATETIME CONSTRAINT [DF_Asset_AssetTagDate] DEFAULT (GETDATE()) NOT NULL,
    [AssetPurchaseDate] DATETIME NULL,
    [AssetPurchasePrice] MONEY NULL,
    [AssetSerialNumber] NVARCHAR(4000) NULL,
    -- Allowed values of AssetWarrantyUnitOfMeasure are DATEPART abbreviations, specifically yy, mm, ww, and dd.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql
    [AssetWarrantyUnitOfMeasure] NCHAR(2) NULL,
    [AssetWarrantyDuration] INT NULL,
    [AssetUsefulLife] INT NULL,
    [AssetSalvageValue] MONEY NULL,
    [ProductID] UNIQUEIDENTIFIER NOT NULL,
    [VendorID] UNIQUEIDENTIFIER NULL,
    [LocationID] UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Asset] PRIMARY KEY CLUSTERED ([AssetID] ASC),
    CONSTRAINT [CK_Asset_AssetSerialNumber_MinimumLength] CHECK (LEN([AssetSerialNumber]) > 0),
    CONSTRAINT [CK_Asset_AssetSerialNumber_NoTrailingSpace] CHECK ([AssetSerialNumber] NOT LIKE ' %' AND [AssetSerialNumber] NOT LIKE '% '),
    CONSTRAINT [CK_Asset_AssetUsefulLife] CHECK ([AssetUsefulLife] >= (0)),
    CONSTRAINT [CK_Asset_AssetWarrantyDuration] CHECK ([AssetWarrantyDuration] >= (0)),
    CONSTRAINT [CK_Asset_AssetWarrantyUnitOfMeasure] CHECK ([AssetWarrantyUnitOfMeasure] IN ('yy', 'mm', 'ww', 'dd')),
    CONSTRAINT [CTK_Asset_AssetWarrantyUnitOfMeasure_AssetWarrantyDuration] CHECK ([AssetWarrantyUnitOfMeasure] IS NOT NULL AND [AssetWarrantyDuration] IS NOT NULL OR [AssetWarrantyUnitOfMeasure] IS NULL AND [AssetWarrantyDuration] IS NULL),
    CONSTRAINT [FK_Asset_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]),
    CONSTRAINT [FK_Asset_Location] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID]),
    CONSTRAINT [FK_Asset_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [FK_Asset_Vendor] FOREIGN KEY ([VendorID]) REFERENCES [dbo].[Vendor] ([VendorID])
);
GO;

CREATE UNIQUE NONCLUSTERED INDEX [IX_Asset_AssetSerialNumber_ProductID]
    ON [dbo].[Asset] ([AssetSerialNumber], [ProductID])
    WHERE [AssetSerialNumber] IS NOT NULL;
