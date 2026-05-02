CREATE TABLE [dbo].[Role] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Role_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Role_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Role_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Role_Name] UNIQUE ([Name] ASC),
    CONSTRAINT [CK_Role_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Name]) = 1),
    CONSTRAINT [CK_Role_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Name]) = 1)
);
