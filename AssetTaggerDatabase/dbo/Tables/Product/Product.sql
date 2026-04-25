CREATE TABLE [dbo].[Product] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Product_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Product_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Product_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Nullable foreign keys.
    [CategoryId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]),

    [ManufacturerId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Product_Manufacturer] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]),

    -- Nullable columns.
    [DocumentationUrl] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Product_DocumentationUrl_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([DocumentationUrl]) = 1),
    CONSTRAINT [CK_Product_DocumentationUrl_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([DocumentationUrl]) = 1),

    [ModelNumber] NVARCHAR(425) NULL,
    CONSTRAINT [CK_Product_ModelNumber_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([ModelNumber]) = 1),
    CONSTRAINT [CK_Product_ModelNumber_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([ModelNumber]) = 1),

    [Name] NVARCHAR(425) NULL,
    CONSTRAINT [CK_Product_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Name]) = 1),
    CONSTRAINT [CK_Product_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Name]) = 1),

    -- Composite constraints.
    CONSTRAINT [CTK_Product_ModelNumber_Name] CHECK ([ModelNumber] IS NOT NULL OR [Name] IS NOT NULL)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ManufacturerId_ModelNumber]
    ON [dbo].[Product] ([ManufacturerId], [ModelNumber])
    WHERE [ModelNumber] IS NOT NULL AND [ManufacturerId] IS NOT NULL;
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ManufacturerId_Name]
    ON [dbo].[Product] ([ManufacturerId], [Name])
    WHERE [ModelNumber] IS NULL AND [ManufacturerId] IS NOT NULL;
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ModelNumber_Name]
    ON [dbo].[Product] ([ModelNumber], [Name])
    WHERE [ManufacturerId] IS NULL;
