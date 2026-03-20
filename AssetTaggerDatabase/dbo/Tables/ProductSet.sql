CREATE TABLE [dbo].[ProductSet] (
    [ProductSetNumber] INT IDENTITY (1, 1),
    [ParentProductID] UNIQUEIDENTIFIER NOT NULL,
    [ProductID] UNIQUEIDENTIFIER NOT NULL,
    [ProductSetProductQuantity] INT DEFAULT 1 NOT NULL,
    [ProductSetInsertDate] DATETIMEOFFSET(3) CONSTRAINT [DF_ProductSet_ProductSetInsertDate] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,
    CONSTRAINT [AK_ProductSet_ProductSetNumber] UNIQUE CLUSTERED ([ProductSetNumber] ASC),
    CONSTRAINT [PK_ProductSet] PRIMARY KEY NONCLUSTERED ([ParentProductID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_ProductSet_Product_ParentProductID] FOREIGN KEY ([ParentProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductSet_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [CK_ProductSet_ProductSetProductQuantity] CHECK ([ProductSetProductQuantity] > 0),
    CONSTRAINT [CTK_ProductSet_ParentProductID_ProductID] CHECK ([ParentProductID] != [ProductID])
);
