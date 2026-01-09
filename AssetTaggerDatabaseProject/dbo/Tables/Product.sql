CREATE TABLE [dbo].[Product] (
    [ProductID]           UNIQUEIDENTIFIER NOT NULL,
    [ProductName]         NVARCHAR (50)    NULL,
    [ProductModelNumber]  NVARCHAR (50)    NULL,
    [ProductManufacturer] NVARCHAR (50)    NULL,
    [CategoryID]          UNIQUEIDENTIFIER NOT NULL
);
GO

ALTER TABLE [dbo].[Product]
    ADD CONSTRAINT [DEFAULT_Product_ProductID] DEFAULT (newid()) FOR [ProductID];
GO

ALTER TABLE [dbo].[Product]
    ADD CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductID] ASC);
GO

ALTER TABLE [dbo].[Product]
    ADD CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID]);
GO

