CREATE TABLE [dbo].[Asset] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Asset_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Asset_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Asset] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Asset_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Non-nullable foreign keys.
    [ProductId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Asset_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id]),

    -- Nullable foreign keys.
    [EmployeeId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Asset_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]),

    [LocationId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Asset_Location] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Location] ([Id]),

    [VendorId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Asset_Vendor] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id]),

    -- Nullable columns.
    [DocumentationUrl] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Asset_DocumentationUrl_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([DocumentationUrl]) = 1),
    CONSTRAINT [CK_Asset_DocumentationUrl_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([DocumentationUrl]) = 1),

    [PurchasedAt] DATETIME2(3) NULL,

    [PurchasePrice] DECIMAL(19, 4) NULL,

    [SalvageValue] DECIMAL(19, 4) NULL,

    [SerialNumber] NVARCHAR(842) NULL,
    CONSTRAINT [CK_Asset_SerialNumber_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([SerialNumber]) = 1),
    CONSTRAINT [CK_Asset_SerialNumber_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([SerialNumber]) = 1),

    [UsefulLife] INT NULL,
    CONSTRAINT [CK_Asset_UsefulLife] CHECK ([UsefulLife] >= 0),

    [WarrantyDuration] INT NULL,
    CONSTRAINT [CK_Asset_WarrantyDuration] CHECK ([WarrantyDuration] >= 0),

    [WarrantyUnitOfMeasure] NVARCHAR(2) NULL,
    -- Allowed values of WarrantyUnitOfMeasure are DATEPART abbreviations, specifically yy, mm, ww, and dd.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql
    CONSTRAINT [CK_Asset_WarrantyUnitOfMeasure] CHECK ([WarrantyUnitOfMeasure] IN ('YY', 'MM', 'WW', 'DD')),

    -- Computed columns.
    [AnnualDepreciationExpense] AS [dbo].[udf_CalculateAnnualDepreciationExpense](PurchasePrice, SalvageValue, UsefulLife) PERSISTED,

    [CurrentBookValue] AS [dbo].[udf_CalculateCurrentBookValue](PurchasePrice, SalvageValue, UsefulLife, PurchasedAt),

    [WarrantyExpirationDate] AS [dbo].[udf_CalculateWarrantyExpirationDate](WarrantyUnitOfMeasure, WarrantyDuration, PurchasedAt) PERSISTED,

    -- Composite constraints.
    CONSTRAINT [CTK_Asset_WarrantyDuration_WarrantyUnitOfMeasure] CHECK (
        ([WarrantyDuration] IS NOT NULL AND [WarrantyUnitOfMeasure] IS NOT NULL)
        OR ([WarrantyDuration] IS NULL AND [WarrantyUnitOfMeasure] IS NULL)
    )
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Asset_ProductId_SerialNumber]
    ON [dbo].[Asset] ([ProductId], [SerialNumber])
    WHERE [SerialNumber] IS NOT NULL;
