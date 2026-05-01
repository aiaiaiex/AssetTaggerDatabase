CREATE TABLE [dbo].[Log] (
    -- Non-nullable columns with default values.
    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Log_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Log] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Log_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Nullable foreign keys.
    [EndUserId] UNIQUEIDENTIFIER NULL,

    -- Non-nullable columns.
    [Arguments] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT [CK_Log_Arguments_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarcharMax]([Arguments]) = 1),

    [EndedAt] DATETIME2(3) NOT NULL,

    [HasExecutedSuccessfully] BIT NOT NULL,

    [Operation] NVARCHAR(6) NOT NULL,

    [StartedAt] DATETIME2(3) NOT NULL,

    [TableName] NVARCHAR(836) NOT NULL,

    -- Nullable columns.
    [EndUserIpAddress] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Log_EndUserIpAddress_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([EndUserIpAddress]) = 1),

    -- From ERROR_MESSAGE().
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/error-message-transact-sql
    [ErrorMessage] NVARCHAR(4000) NULL,

    -- From ERROR_NUMBER().
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/error-number-transact-sql
    [ErrorNumber] INT NULL,

    -- Computed columns.
    [ExecutionTimeInMilliseconds] AS DATEDIFF_BIG(MS, StartedAt, EndedAt) PERSISTED NOT NULL
);
