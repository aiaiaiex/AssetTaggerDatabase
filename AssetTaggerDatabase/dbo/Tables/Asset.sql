CREATE TABLE [dbo].[Asset] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Asset_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Asset_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Asset] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Asset_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

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
    [PurchasedAt] DATETIME2(3) NULL,

    [PurchasePrice] DECIMAL(19, 4) NULL,

    [SerialNumber] NVARCHAR(842) NULL,
    CONSTRAINT [CK_Asset_SerialNumber_Exclude] CHECK ([SerialNumber] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Asset_SerialNumber_NoLeadingAndTrailingWhitespace] CHECK ([SerialNumber] NOT LIKE ' %' AND [SerialNumber] NOT LIKE '% '),

    [WarrantyDuration] INT NULL,
    CONSTRAINT [CK_Asset_WarrantyDuration] CHECK ([WarrantyDuration] >= 0),

    [WarrantyUnitOfMeasure] NVARCHAR(2) NULL,
    -- Allowed values of WarrantyUnitOfMeasure are DATEPART abbreviations, specifically yy, mm, ww, and dd.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql
    CONSTRAINT [CK_Asset_WarrantyUnitOfMeasure] CHECK ([WarrantyUnitOfMeasure] IN ('YY', 'MM', 'WW', 'DD')),

    [UsefulLife] INT NULL,
    CONSTRAINT [CK_Asset_UsefulLife] CHECK ([UsefulLife] >= 0),

    [SalvageValue] DECIMAL(19, 4) NULL,

    [DocumentationUrl] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Asset_DocumentationUrl_Exclude] CHECK ([DocumentationUrl] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Asset_DocumentationUrl_NoLeadingAndTrailingWhitespace] CHECK ([DocumentationUrl] NOT LIKE ' %' AND [DocumentationUrl] NOT LIKE '% '),

    -- Computed columns.
    [WarrantyExpirationDate] AS [dbo].[udf_CalculateWarrantyExpirationDate](WarrantyUnitOfMeasure, WarrantyDuration, PurchasedAt) PERSISTED,

    [AnnualDepreciationExpense] AS [dbo].[udf_CalculateAnnualDepreciationExpense](PurchasePrice, SalvageValue, UsefulLife) PERSISTED,

    [CurrentBookValue] AS [dbo].[udf_CalculateCurrentBookValue](PurchasePrice, SalvageValue, UsefulLife, PurchasedAt),

    -- Composite constraints.
    CONSTRAINT [CTK_Asset_WarrantyUnitOfMeasure_WarrantyDuration] CHECK ([WarrantyUnitOfMeasure] IS NOT NULL AND [WarrantyDuration] IS NOT NULL OR [WarrantyUnitOfMeasure] IS NULL AND [WarrantyDuration] IS NULL)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Asset_SerialNumber_ProductId]
    ON [dbo].[Asset] ([SerialNumber], [ProductId])
    WHERE [SerialNumber] IS NOT NULL;
