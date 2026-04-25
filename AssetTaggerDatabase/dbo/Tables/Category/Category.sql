CREATE TABLE [dbo].[Category] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Category_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Category_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Category_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Category_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Category_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Name]) = 1),
    CONSTRAINT [CK_Category_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Name]) = 1)
);
