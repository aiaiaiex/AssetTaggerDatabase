CREATE TABLE [dbo].[StoredProcedureLog] (
    -- Non-nullable columns with default values.
    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Log_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_StoredProcedureLog] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_StoredProcedureLog_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Nullable foreign keys.
    [EndUserId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_StoredProcedureLog_EndUser] FOREIGN KEY ([EndUserId]) REFERENCES [dbo].[EndUser] ([Id]),

    -- Non-nullable columns.
    [Arguments] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT [CK_StoredProcedureLog_Arguments_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarcharMax]([Arguments]) = 1),
    CONSTRAINT [CK_StoredProcedureLog_Arguments_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarcharMax]([Arguments]) = 1),

    [EndedAt] DATETIME2(3) NOT NULL,

    [HasExecutedSuccessfully] BIT NOT NULL,

    [Name] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [CK_StoredProcedureLog_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Name]) = 1),
    CONSTRAINT [CK_StoredProcedureLog_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Name]) = 1),

    [StartedAt] DATETIME2(3) NOT NULL,

    -- Nullable columns.
    [EndUserIpAddress] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_StoredProcedureLog_EndUserIpAddress_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([EndUserIpAddress]) = 1),
    CONSTRAINT [CK_StoredProcedureLog_EndUserIpAddress_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([EndUserIpAddress]) = 1),

    -- Computed columns.
    [ExecutionTimeInMilliseconds] AS DATEDIFF_BIG(MS, StartedAt, EndedAt) PERSISTED NOT NULL,
    CONSTRAINT [CK_StoredProcedureLog_ExecutionTimeInMilliseconds] CHECK ([ExecutionTimeInMilliseconds] >= 0)
);
