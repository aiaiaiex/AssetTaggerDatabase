CREATE TABLE [dbo].[Product] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Product_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Product_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Product_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Foreign keys.
    [CategoryId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]),

    [ManufacturerId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Product_Manufacturer] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]),

    -- Nullable columns.
    [Name] NVARCHAR(834) NULL,
    CONSTRAINT [CK_Product_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Name]) = 1),
    CONSTRAINT [CK_Product_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% '),

    [ModelNumber] NVARCHAR(834) NULL,
    CONSTRAINT [CK_Product_ModelNumber_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([ModelNumber]) = 1),
    CONSTRAINT [CK_Product_ModelNumber_NoLeadingAndTrailingWhitespace] CHECK ([ModelNumber] NOT LIKE ' %' AND [ModelNumber] NOT LIKE '% '),

    [DocumentationUrl] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Product_DocumentationUrl_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([DocumentationUrl]) = 1),
    CONSTRAINT [CK_Product_DocumentationUrl_NoLeadingAndTrailingWhitespace] CHECK ([DocumentationUrl] NOT LIKE ' %' AND [DocumentationUrl] NOT LIKE '% ')
);
GO

CREATE UNIQUE INDEX [IX_Product_ManufacturerId_ModelNumber_CategoryId]
    ON [dbo].[Product] ([ManufacturerId], [ModelNumber], [CategoryId])
    WHERE [ModelNumber] IS NOT NULL;
GO

CREATE UNIQUE INDEX [IX_Product_ManufacturerId_Name_CategoryId]
    ON [dbo].[Product] ([ManufacturerId], [Name], [CategoryId])
    WHERE [ModelNumber] IS NULL;
