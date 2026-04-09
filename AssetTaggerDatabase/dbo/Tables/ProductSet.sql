CREATE TABLE [dbo].[ProductSet] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_ProductSet_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [CreatedAt] DATETIMEOFFSET(3) CONSTRAINT [DF_ProductSet_CreatedAt] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,

    [ProductQuantity] INT DEFAULT 1 NOT NULL,
    CONSTRAINT [CK_ProductSet_ProductQuantity] CHECK ([ProductQuantity] > 0),

    -- Foreign keys.
    [ParentProductID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_ProductSet_Product_ParentProductID] FOREIGN KEY ([ParentProductID]) REFERENCES [dbo].[Product] ([Id]),

    [ProductID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_ProductSet_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([Id]),

    -- Composite constraints.
    CONSTRAINT [CTK_ProductSet_ParentProductID_ProductID] CHECK ([ParentProductID] != [ProductID]),
    CONSTRAINT [PK_ProductSet] PRIMARY KEY NONCLUSTERED ([ParentProductID], [ProductID])
);
