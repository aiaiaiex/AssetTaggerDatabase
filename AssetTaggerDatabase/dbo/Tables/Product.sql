CREATE TABLE [dbo].[Product] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Product_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Product_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIMEOFFSET(3) CONSTRAINT [DF_Product_CreatedAt] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,

    -- Foreign keys.
    [CategoryId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]),

    [ManufacturerId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Product_Manufacturer] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]),

    -- Nullable columns.
    [Name] NVARCHAR(421) NULL,
    CONSTRAINT [CK_Product_Name_Exclude] CHECK ([Name] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Product_Name_MinimumLength] CHECK (LEN([Name]) > 0),
    CONSTRAINT [CK_Product_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% '),

    [ModelNumber] NVARCHAR(421) NULL,
    CONSTRAINT [CK_Product_ModelNumber_Exclude] CHECK ([ModelNumber] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Product_ModelNumber_MinimumLength] CHECK (LEN([ModelNumber]) > 0),
    CONSTRAINT [CK_Product_ModelNumber_NoLeadingAndTrailingWhitespace] CHECK ([ModelNumber] NOT LIKE ' %' AND [ModelNumber] NOT LIKE '% '),

    [DocumentationUrl] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Asset_DocumentationUrl_Exclude] CHECK ([DocumentationUrl] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Asset_DocumentationUrl_MinimumLength] CHECK (LEN([DocumentationUrl]) > 0),
    CONSTRAINT [CK_Asset_DocumentationUrl_NoLeadingAndTrailingWhitespace] CHECK ([DocumentationUrl] NOT LIKE ' %' AND [DocumentationUrl] NOT LIKE '% ')
);
GO

CREATE UNIQUE INDEX [IX_Product_ModelNumber_ManufacturerId]
    ON [dbo].[Product] ([ModelNumber], [ManufacturerId])
    WHERE [ModelNumber] IS NOT NULL AND [ManufacturerId] IS NOT NULL;
GO

CREATE UNIQUE INDEX [IX_Product_Name_ModelNumber_ManufacturerId_ModelNumberIsNull]
    ON [dbo].[Product] ([Name], [ModelNumber], [ManufacturerId])
    WHERE [ModelNumber] IS NULL AND [ManufacturerId] IS NOT NULL;
GO

CREATE UNIQUE INDEX [IX_Product_Name_ModelNumber_ManufacturerId_ManufacturerIdIsNull]
    ON [dbo].[Product] ([Name], [ModelNumber], [ManufacturerId])
    WHERE [ModelNumber] IS NOT NULL AND [ManufacturerId] IS NULL;
GO

CREATE UNIQUE INDEX [IX_Product_Name_ModelNumber_ManufacturerId_ModelNumberAndManufacturerIdAreNull]
    ON [dbo].[Product] ([Name], [ModelNumber], [ManufacturerId])
    WHERE [ModelNumber] IS NULL AND [ManufacturerId] IS NULL;
