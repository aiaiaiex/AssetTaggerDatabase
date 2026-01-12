CREATE TABLE [dbo].[ProductSet] (
    [ParentProductID] UNIQUEIDENTIFIER NOT NULL,
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_ProductSet] PRIMARY KEY CLUSTERED ([ParentProductID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_ProductSet_Product_ParentProductID] FOREIGN KEY ([ParentProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductSet_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID])
);

