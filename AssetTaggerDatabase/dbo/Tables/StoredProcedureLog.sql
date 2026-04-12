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
    CONSTRAINT [CK_Log_Name_Exclude] CHECK ([Name] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Log_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% '),

    [Arguments] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT [CK_Log_Arguments_Exclude] CHECK ([Arguments] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Log_Arguments_NoLeadingAndTrailingWhitespace] CHECK ([Arguments] NOT LIKE ' %' AND [Arguments] NOT LIKE '% '),

    -- Nullable columns.
    [EndUserIpAddress] NVARCHAR(4000) NULL,
    CONSTRAINT [CK_Log_EndUserIpAddress_Exclude] CHECK ([EndUserIpAddress] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Log_EndUserIpAddress_NoLeadingAndTrailingWhitespace] CHECK ([EndUserIpAddress] NOT LIKE ' %' AND [EndUserIpAddress] NOT LIKE '% '),

    -- Computed columns.
    [ExecutionTimeInMilliseconds] AS DATEDIFF_BIG(MS, StartedAt, EndedAt) PERSISTED NOT NULL
);
