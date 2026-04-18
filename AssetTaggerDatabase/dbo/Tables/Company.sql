CREATE TABLE [dbo].[Company] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Company_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Company_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Company_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    -- Nullable foreign keys.
    [ParentCompanyId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [CTK_Company_Id_ParentCompanyId] CHECK ([Id] <> [ParentCompanyId]),
    CONSTRAINT [FK_Company_Company] FOREIGN KEY ([ParentCompanyId]) REFERENCES [dbo].[Company] ([Id]),

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Company_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Company_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Name]) = 1),
    CONSTRAINT [CK_Company_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Name]) = 1),

    -- Nullable columns.
    [Address] NVARCHAR(850) NULL,
    CONSTRAINT [CK_Company_Address_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Address]) = 1),
    CONSTRAINT [CK_Company_Address_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Address]) = 1),

    [Code] NVARCHAR(5) NULL,
    CONSTRAINT [CK_Company_Code_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Code]) = 1),
    CONSTRAINT [CK_Company_Code_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Code]) = 1)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Company_Code]
    ON [dbo].[Company] ([Code])
    WHERE [Code] IS NOT NULL;
