CREATE TABLE [dbo].[Product] (
    [ProductID] UNIQUEIDENTIFIER CONSTRAINT [DF_Product_ProductID] DEFAULT (NEWID()) NOT NULL,
    [ProductName] NVARCHAR(50) NULL,
    [ProductModelNumber] NVARCHAR(50) NULL,
    [ManufacturerID] UNIQUEIDENTIFIER NULL,
    [CategoryID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_Product_ProductModelNumber_ManufacturerID] UNIQUE ([ProductModelNumber], [ManufacturerID]),
    CONSTRAINT [CK_Product_ProductName_MinimumLength] CHECK (LEN([ProductName]) > 0),
    CONSTRAINT [CK_Product_ProductName_NoTrailingSpace] CHECK ([ProductName] NOT LIKE ' %' AND [ProductName] NOT LIKE '% '),
    CONSTRAINT [CK_Product_ProductModelNumber_MinimumLength] CHECK (LEN([ProductModelNumber]) > 0),
    CONSTRAINT [CK_Product_ProductModelNumber_NoTrailingSpace] CHECK ([ProductModelNumber] NOT LIKE ' %' AND [ProductModelNumber] NOT LIKE '% '),
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Product_Manufacturer] FOREIGN KEY ([ManufacturerID]) REFERENCES [dbo].[Manufacturer] ([ManufacturerID]),
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID])
);
