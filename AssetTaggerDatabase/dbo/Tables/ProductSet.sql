CREATE TABLE [dbo].[ProductSet] (
    [ProductSetNumber] INT IDENTITY (1, 1),
    [ParentProductID] UNIQUEIDENTIFIER NOT NULL,
    [ProductID] UNIQUEIDENTIFIER NOT NULL,
    [ProductSetInsertDate] DATETIME CONSTRAINT [DF_ProductSet_ProductSetInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_ProductSet_ProductSetNumber] UNIQUE CLUSTERED ([ProductSetNumber] ASC),
    CONSTRAINT [PK_ProductSet] PRIMARY KEY NONCLUSTERED ([ParentProductID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_ProductSet_Product_ParentProductID] FOREIGN KEY ([ParentProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductSet_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [CTK_ProductSet_ParentProductID_ProductID] CHECK ([ParentProductID] != [ProductID])
);
