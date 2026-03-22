CREATE TABLE [dbo].[Asset] (
    [AssetNumber] INT IDENTITY (1, 1),
    [AssetID] UNIQUEIDENTIFIER CONSTRAINT [DF_Asset_AssetID] DEFAULT (NEWID()) NOT NULL,
    [AssetTagDate] DATETIMEOFFSET(3) CONSTRAINT [DF_Asset_AssetTagDate] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,
    [AssetPurchaseDate] DATETIMEOFFSET(3) NULL,
    [AssetPurchasePrice] DECIMAL(15, 4) NULL,
    [AssetSerialNumber] NVARCHAR(842) NULL,
    [AssetWarrantyUnitOfMeasure] NCHAR(2) NULL,
    [AssetWarrantyDuration] INT NULL,
    [AssetWarrantyExpirationDate] AS [dbo].[udf_CalculateWarrantyExpirationDate](AssetWarrantyUnitOfMeasure, AssetWarrantyDuration, AssetPurchaseDate) PERSISTED,
    [AssetUsefulLife] INT NULL,
    [AssetSalvageValue] DECIMAL(15, 4) NULL,
    [AssetAnnualDepreciationExpense] AS [dbo].[udf_CalculateAnnualDepreciationExpense](AssetPurchasePrice, AssetSalvageValue, AssetUsefulLife) PERSISTED,
    [AssetCurrentBookValue] AS [dbo].[udf_CalculateCurrentBookValue](AssetPurchasePrice, AssetSalvageValue, AssetUsefulLife, AssetPurchaseDate),
    [AssetDocumentationURL] NVARCHAR(4000) NULL,
    [ProductID] UNIQUEIDENTIFIER NOT NULL,
    [VendorID] UNIQUEIDENTIFIER NULL,
    [LocationID] UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_Asset_AssetNumber] UNIQUE CLUSTERED ([AssetNumber] ASC),
    CONSTRAINT [PK_Asset] PRIMARY KEY NONCLUSTERED ([AssetID] ASC),
    CONSTRAINT [CK_Asset_AssetSerialNumber_Exclude] CHECK ([AssetSerialNumber] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Asset_AssetSerialNumber_MinimumLength] CHECK (LEN([AssetSerialNumber]) > 0),
    CONSTRAINT [CK_Asset_AssetSerialNumber_NoLeadingAndTrailingWhitespace] CHECK ([AssetSerialNumber] NOT LIKE ' %' AND [AssetSerialNumber] NOT LIKE '% '),
    CONSTRAINT [CK_Asset_AssetUsefulLife] CHECK ([AssetUsefulLife] >= 0),
    CONSTRAINT [CK_Asset_AssetWarrantyDuration] CHECK ([AssetWarrantyDuration] >= 0),
    -- Allowed values of AssetWarrantyUnitOfMeasure are DATEPART abbreviations, specifically yy, mm, ww, and dd.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql
    CONSTRAINT [CK_Asset_AssetWarrantyUnitOfMeasure] CHECK ([AssetWarrantyUnitOfMeasure] IN ('yy', 'mm', 'ww', 'dd')),
    CONSTRAINT [CTK_Asset_AssetWarrantyUnitOfMeasure_AssetWarrantyDuration] CHECK ([AssetWarrantyUnitOfMeasure] IS NOT NULL AND [AssetWarrantyDuration] IS NOT NULL OR [AssetWarrantyUnitOfMeasure] IS NULL AND [AssetWarrantyDuration] IS NULL),
    CONSTRAINT [CK_Asset_AssetDocumentationURL_Exclude] CHECK ([AssetDocumentationURL] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Asset_AssetDocumentationURL_MinimumLength] CHECK (LEN([AssetDocumentationURL]) > 0),
    CONSTRAINT [CK_Asset_AssetDocumentationURL_NoLeadingAndTrailingWhitespace] CHECK ([AssetDocumentationURL] NOT LIKE ' %' AND [AssetDocumentationURL] NOT LIKE '% '),
    CONSTRAINT [FK_Asset_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]),
    CONSTRAINT [FK_Asset_Location] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID]),
    CONSTRAINT [FK_Asset_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [FK_Asset_Vendor] FOREIGN KEY ([VendorID]) REFERENCES [dbo].[Vendor] ([VendorID]),
    CONSTRAINT [CK_Asset_AssetPurchaseDate_Exclude] CHECK ([AssetPurchaseDate] NOT IN (CONVERT(DATETIMEOFFSET(3), '1900-01-01T00:00:00.000Z'), CONVERT(DATETIMEOFFSET(3), '2900-01-01T00:00:00.000Z'))),
    CONSTRAINT [CK_Asset_AssetPurchasePrice_Exclude] CHECK ([AssetPurchasePrice] NOT IN (CONVERT(DECIMAL(15, 4), -99999999999.9999), CONVERT(DECIMAL(15, 4), 99999999999.9999))),
    CONSTRAINT [CK_Asset_AssetSalvageValue_Exclude] CHECK ([AssetSalvageValue] NOT IN (CONVERT(DECIMAL(15, 4), -99999999999.9999), CONVERT(DECIMAL(15, 4), 99999999999.9999))),
    CONSTRAINT [CK_Asset_AssetWarrantyDuration_Exclude] CHECK ([AssetSalvageValue] NOT IN (CONVERT(INT, -2147483648), CONVERT(INT, 2147483647))),
    CONSTRAINT [CK_Asset_AssetUsefulLife_Exclude] CHECK ([AssetUsefulLife] NOT IN (CONVERT(INT, -2147483648), CONVERT(INT, 2147483647))),
    CONSTRAINT [CK_Asset_AssetWarrantyExpirationDate_Exclude] CHECK ([AssetWarrantyExpirationDate] NOT IN (CONVERT(DATETIMEOFFSET(3), '1900-01-01T00:00:00.000Z'), CONVERT(DATETIMEOFFSET(3), '2900-01-01T00:00:00.000Z'))),
    CONSTRAINT [CK_Asset_AssetAnnualDepreciationExpense_Exclude] CHECK ([AssetAnnualDepreciationExpense] NOT IN (CONVERT(DECIMAL(15, 4), -99999999999.9999), CONVERT(DECIMAL(15, 4), 99999999999.9999)))
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Asset_AssetSerialNumber_ProductID]
    ON [dbo].[Asset] ([AssetSerialNumber], [ProductID])
    WHERE [AssetSerialNumber] IS NOT NULL;
