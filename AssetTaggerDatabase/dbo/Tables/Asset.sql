CREATE TABLE [dbo].[Asset] (
    [AssetID]                    UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Asset_AssetID] DEFAULT (newid()) NOT NULL,
    [AssetTagDate]               DATETIME         CONSTRAINT [DEFAULT_Asset_AssetTagDate] DEFAULT (getdate()) NOT NULL,
    [AssetPurchaseDate]          DATETIME         NULL,
    [AssetPurchasePrice]         MONEY            NULL,
    [AssetSerialNumber]          NVARCHAR (50)    NULL,
    [AssetWarrantyUnitOfMeasure] NCHAR (2)        NULL,
    [AssetWarrantyDuration]      INT              NULL,
    [AssetUsefulLife]            INT              NULL,
    [AssetSalvageValue]          MONEY            NULL,
    [ProductID]                  UNIQUEIDENTIFIER NOT NULL,
    [VendorID]                   UNIQUEIDENTIFIER NOT NULL,
    [LocationID]                 UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID]                 UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_Asset] PRIMARY KEY CLUSTERED ([AssetID] ASC),
    CONSTRAINT [CK_Asset_AssetUsefulLife] CHECK ([AssetUsefulLife]>=(0)),
    CONSTRAINT [CK_Asset_AssetWarrantyDuration] CHECK ([AssetWarrantyDuration]>=(0)),
    CONSTRAINT [CK_Asset_AssetWarrantyUnitOfMeasure] CHECK ([AssetWarrantyUnitOfMeasure]='dd' OR [AssetWarrantyUnitOfMeasure]='ww' OR [AssetWarrantyUnitOfMeasure]='mm' OR [AssetWarrantyUnitOfMeasure]='yy'),
    CONSTRAINT [CK_Asset_AssetWarrantyUnitOfMeasure_AssetWarrantyDuration] CHECK ([AssetWarrantyUnitOfMeasure] IS NOT NULL AND [AssetWarrantyDuration] IS NOT NULL OR [AssetWarrantyUnitOfMeasure] IS NULL AND [AssetWarrantyDuration] IS NULL),
    CONSTRAINT [FK_Asset_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]),
    CONSTRAINT [FK_Asset_Location] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID]),
    CONSTRAINT [FK_Asset_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [FK_Asset_Vendor] FOREIGN KEY ([VendorID]) REFERENCES [dbo].[Vendor] ([VendorID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'datepart abbreviation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Asset', @level2type = N'COLUMN', @level2name = N'AssetWarrantyUnitOfMeasure';

