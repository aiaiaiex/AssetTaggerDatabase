CREATE TABLE [dbo].[ProductSet] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_ProductSet_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [ProductQuantity] INT DEFAULT 1 NOT NULL,
    CONSTRAINT [CK_ProductSet_ProductQuantity] CHECK ([ProductQuantity] > 0),

    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_ProductSet_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Non-nullable foreign keys.
    [ParentProductId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_ProductSet_Product_ParentProductId] FOREIGN KEY ([ParentProductId]) REFERENCES [dbo].[Product] ([Id]),

    [ProductId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_ProductSet_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id]),

    -- Composite constraints.
    CONSTRAINT [CTK_ProductSet_ParentProductId_ProductId] CHECK ([ParentProductId] <> [ProductId]),
    CONSTRAINT [PK_ProductSet] PRIMARY KEY NONCLUSTERED ([ParentProductId], [ProductId])
);
