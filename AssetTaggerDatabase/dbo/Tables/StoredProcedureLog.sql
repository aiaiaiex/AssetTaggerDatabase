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

    [EndedAt] DATETIME2(3) NOT NULL,

    [HasExecutedSuccessfully] BIT NOT NULL,

    [Operation] NVARCHAR(6) NOT NULL,
    CONSTRAINT [CK_StoredProcedureLog_Operation] CHECK ([Operation] IN ('Create', 'Read', 'Update', 'Delete')),

    [StartedAt] DATETIME2(3) NOT NULL,

    [TableName] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [CK_StoredProcedureLog_TableName] CHECK ([TableName] IN (
        'Asset',
        'Building',
        'Category',
        'Company',
        'Department',
        'Employee',
        'EndUser',
        'EndUserRole',
        'Location',
        'Manufacturer',
        'Product',
        'ProductSet',
        'Role',
        'StoredProcedureLog',
        'Vendor'
    )),

    -- Nullable columns.
    [EndUserIpAddress] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_StoredProcedureLog_EndUserIpAddress_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([EndUserIpAddress]) = 1),

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
