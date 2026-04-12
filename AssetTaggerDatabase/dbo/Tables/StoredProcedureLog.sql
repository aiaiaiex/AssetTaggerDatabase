CREATE TABLE [dbo].[StoredProcedureLog] (
    -- Columns with default values.
    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Log_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Log_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Log] PRIMARY KEY NONCLUSTERED ([Id]),

    -- Foreign keys.
    [EndUserId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Log_EndUser] FOREIGN KEY ([EndUserId]) REFERENCES [dbo].[EndUser] ([Id]),

    -- Non-nullable columns.
    [StartedAt] DATETIME2(3) NOT NULL,

    [EndedAt] DATETIME2(3) NOT NULL,

    [HasExecutedSuccessfully] BIT NOT NULL,

    [Name] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [CK_Log_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Name]) = 1),
    CONSTRAINT [CK_Log_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Name]) = 1),

    [Arguments] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT [CK_Log_Arguments_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Arguments]) = 1),
    CONSTRAINT [CK_Log_Arguments_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Arguments]) = 1),

    -- Nullable columns.
    [EndUserIpAddress] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Log_EndUserIpAddress_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([EndUserIpAddress]) = 1),
    CONSTRAINT [CK_Log_EndUserIpAddress_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([EndUserIpAddress]) = 1),

    -- Computed columns.
    [ExecutionTimeInMilliseconds] AS DATEDIFF_BIG(MS, StartedAt, EndedAt) PERSISTED NOT NULL
);
