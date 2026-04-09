CREATE TABLE [dbo].[Asset] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Asset_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Asset_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Asset] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIMEOFFSET(3) CONSTRAINT [DF_Asset_CreatedAt] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,

    -- Foreign keys.
    [ProductId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Asset_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id]),

    [VendorId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Asset_Vendor] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id]),

    [LocationId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Asset_Location] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Location] ([Id]),

    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Asset_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]),

    -- Nullable columns.
    [PurchasedAt] DATETIMEOFFSET(3) NULL,
    CONSTRAINT [CK_Asset_PurchasedAt_Exclude] CHECK ([PurchasedAt] NOT IN (CAST('1900-01-01T00:00:00.000Z' AS DATETIMEOFFSET(3)), CAST('2900-01-01T00:00:00.000Z' AS DATETIMEOFFSET(3)))),

    [PurchasePrice] DECIMAL(15, 4) NULL,
    CONSTRAINT [CK_Asset_PurchasePrice_Exclude] CHECK ([PurchasePrice] NOT IN (CAST(-99999999999.9999 AS DECIMAL(15, 4)), CAST(99999999999.9999 AS DECIMAL(15, 4)))),

    [SerialNumber] NVARCHAR(842) NULL,
    CONSTRAINT [CK_Asset_SerialNumber_Exclude] CHECK ([SerialNumber] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Asset_SerialNumber_MinimumLength] CHECK (LEN([SerialNumber]) > 0),
    CONSTRAINT [CK_Asset_SerialNumber_NoLeadingAndTrailingWhitespace] CHECK ([SerialNumber] NOT LIKE ' %' AND [SerialNumber] NOT LIKE '% '),

    [WarrantyDuration] INT NULL,
    CONSTRAINT [CK_Asset_WarrantyDuration] CHECK ([WarrantyDuration] >= 0),
    CONSTRAINT [CK_Asset_WarrantyDuration_Exclude] CHECK ([SalvageValue] NOT IN (CAST(-2147483648 AS INT), CAST(2147483647 AS INT))),

    [WarrantyUnitOfMeasure] NCHAR(2) NULL,
    -- Allowed values of WarrantyUnitOfMeasure are DATEPART abbreviations, specifically yy, mm, ww, and dd.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql
    CONSTRAINT [CK_Asset_WarrantyUnitOfMeasure] CHECK ([WarrantyUnitOfMeasure] IN ('YY', 'MM', 'WW', 'DD')),

    [UsefulLife] INT NULL,
    CONSTRAINT [CK_Asset_UsefulLife] CHECK ([UsefulLife] >= 0),
    CONSTRAINT [CK_Asset_UsefulLife_Exclude] CHECK ([UsefulLife] NOT IN (CAST(-2147483648 AS INT), CAST(2147483647 AS INT))),

    [SalvageValue] DECIMAL(15, 4) NULL,
    CONSTRAINT [CK_Asset_SalvageValue_Exclude] CHECK ([SalvageValue] NOT IN (CAST(-99999999999.9999 AS DECIMAL(15, 4)), CAST(99999999999.9999 AS DECIMAL(15, 4)))),

    [DocumentationUrl] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Asset_DocumentationUrl_Exclude] CHECK ([DocumentationUrl] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Asset_DocumentationUrl_MinimumLength] CHECK (LEN([DocumentationUrl]) > 0),
    CONSTRAINT [CK_Asset_DocumentationUrl_NoLeadingAndTrailingWhitespace] CHECK ([DocumentationUrl] NOT LIKE ' %' AND [DocumentationUrl] NOT LIKE '% '),

    -- Computed columns.
    [WarrantyExpirationDate] AS [dbo].[udf_CalculateWarrantyExpirationDate](WarrantyUnitOfMeasure, WarrantyDuration, PurchasedAt) PERSISTED,
    CONSTRAINT [CK_Asset_WarrantyExpirationDate_Exclude] CHECK ([WarrantyExpirationDate] NOT IN (CAST('1900-01-01T00:00:00.000Z' AS DATETIMEOFFSET(3)), CAST('2900-01-01T00:00:00.000Z' AS DATETIMEOFFSET(3)))),

    [AnnualDepreciationExpense] AS [dbo].[udf_CalculateAnnualDepreciationExpense](PurchasePrice, SalvageValue, UsefulLife) PERSISTED,
    CONSTRAINT [CK_Asset_AnnualDepreciationExpense_Exclude] CHECK ([AnnualDepreciationExpense] NOT IN (CAST(-99999999999.9999 AS DECIMAL(15, 4)), CAST(99999999999.9999 AS DECIMAL(15, 4)))),

    [CurrentBookValue] AS [dbo].[udf_CalculateCurrentBookValue](PurchasePrice, SalvageValue, UsefulLife, PurchasedAt),

    -- Composite constraints.
    CONSTRAINT [CTK_Asset_WarrantyUnitOfMeasure_WarrantyDuration] CHECK ([WarrantyUnitOfMeasure] IS NOT NULL AND [WarrantyDuration] IS NOT NULL OR [WarrantyUnitOfMeasure] IS NULL AND [WarrantyDuration] IS NULL)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Asset_SerialNumber_ProductId]
    ON [dbo].[Asset] ([SerialNumber], [ProductId])
    WHERE [SerialNumber] IS NOT NULL;
