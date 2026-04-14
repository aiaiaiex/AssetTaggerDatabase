CREATE TABLE [dbo].[Product] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Product_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Product_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Product_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Non-nullable foreign keys.
    [CategoryId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]),

    -- Nullable foreign keys.
    [ManufacturerId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Product_Manufacturer] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]),

    -- Nullable columns.
    [DocumentationUrl] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Product_DocumentationUrl_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([DocumentationUrl]) = 1),
    CONSTRAINT [CK_Product_DocumentationUrl_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([DocumentationUrl]) = 1),

    [ModelNumber] NVARCHAR(834) NULL,
    CONSTRAINT [CK_Product_ModelNumber_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([ModelNumber]) = 1),
    CONSTRAINT [CK_Product_ModelNumber_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([ModelNumber]) = 1),

    [Name] NVARCHAR(834) NULL,
    CONSTRAINT [CK_Product_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Name]) = 1),
    CONSTRAINT [CK_Product_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Name]) = 1)
);
GO

CREATE UNIQUE INDEX [IX_Product_ManufacturerId_ModelNumber_CategoryId]
    ON [dbo].[Product] ([ManufacturerId], [ModelNumber], [CategoryId])
    WHERE [ModelNumber] IS NOT NULL;
GO

CREATE UNIQUE INDEX [IX_Product_ManufacturerId_Name_CategoryId]
    ON [dbo].[Product] ([ManufacturerId], [Name], [CategoryId])
    WHERE [ModelNumber] IS NULL;
