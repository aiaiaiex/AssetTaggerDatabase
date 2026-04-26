CREATE TABLE [dbo].[Job] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Job_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Job_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Job] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Job_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Non-nullable columns.
    [Title] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Job_Title] UNIQUE ([Title]),
    CONSTRAINT [CK_Job_Title_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Title]) = 1),
    CONSTRAINT [CK_Job_Title_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Title]) = 1)
);
