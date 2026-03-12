CREATE TABLE [dbo].[Product] (
    [ProductNumber] INT IDENTITY (1, 1),
    [ProductID] UNIQUEIDENTIFIER CONSTRAINT [DF_Product_ProductID] DEFAULT (NEWID()) NOT NULL,
    [ProductName] NVARCHAR(4000) NULL,
    [ProductModelNumber] NVARCHAR(4000) NULL,
    [ManufacturerID] UNIQUEIDENTIFIER NULL,
    [CategoryID] UNIQUEIDENTIFIER NOT NULL,
    [ProductInsertDate] DATETIME CONSTRAINT [DF_Product_ProductInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_Product_ProductNumber] UNIQUE CLUSTERED ([ProductNumber] ASC),
    CONSTRAINT [CK_Product_ProductName_Exclude] CHECK ([ProductName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Product_ProductName_MinimumLength] CHECK (LEN([ProductName]) > 0),
    CONSTRAINT [CK_Product_ProductName_NoLeadingAndTrailingWhitespace] CHECK ([ProductName] NOT LIKE ' %' AND [ProductName] NOT LIKE '% '),
    CONSTRAINT [CK_Product_ProductModelNumber_Exclude] CHECK ([ProductModelNumber] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Product_ProductModelNumber_MinimumLength] CHECK (LEN([ProductModelNumber]) > 0),
    CONSTRAINT [CK_Product_ProductModelNumber_NoLeadingAndTrailingWhitespace] CHECK ([ProductModelNumber] NOT LIKE ' %' AND [ProductModelNumber] NOT LIKE '% '),
    CONSTRAINT [PK_Product] PRIMARY KEY NONCLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Product_Manufacturer] FOREIGN KEY ([ManufacturerID]) REFERENCES [dbo].[Manufacturer] ([ManufacturerID]),
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID])
);
GO;

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ProductModelNumber_ManufacturerID]
    ON [dbo].[Product] ([ProductModelNumber], [ManufacturerID])
    WHERE [ProductModelNumber] IS NOT NULL AND [ManufacturerID] IS NOT NULL;
GO;

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ProductName_ProductModelNumber_ManufacturerID_ProductModelNumberIsNull]
    ON [dbo].[Product] ([ProductName], [ProductModelNumber], [ManufacturerID])
    WHERE [ProductModelNumber] IS NULL AND [ManufacturerID] IS NOT NULL;
GO;

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ProductName_ProductModelNumber_ManufacturerID_ManufacturerIDIsNull]
    ON [dbo].[Product] ([ProductName], [ProductModelNumber], [ManufacturerID])
    WHERE [ProductModelNumber] IS NOT NULL AND [ManufacturerID] IS NULL;
GO;

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ProductName_ProductModelNumber_ManufacturerID_ProductModelNumberAndManufacturerIDAreNull]
    ON [dbo].[Product] ([ProductName], [ProductModelNumber], [ManufacturerID])
    WHERE [ProductModelNumber] IS NULL AND [ManufacturerID] IS NULL;
