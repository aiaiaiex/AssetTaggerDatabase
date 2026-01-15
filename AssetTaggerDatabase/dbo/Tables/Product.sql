CREATE TABLE [dbo].[Product] (
    [ProductID]           UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Product_ProductID] DEFAULT (newid()) NOT NULL,
    [ProductName]         NVARCHAR (50)    NULL,
    [ProductModelNumber]  NVARCHAR (50)    NULL,
    [ProductManufacturer] NVARCHAR (50)    NULL,
    [CategoryID]          UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Product_ProductModelNumber_ProductManufacturer]
    ON [dbo].[Product]([ProductModelNumber] ASC, [ProductManufacturer] ASC);

