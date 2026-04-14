CREATE TABLE [dbo].[EndUser] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_EndUser_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_EndUser_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_EndUser] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_EndUser_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Non-nullable foreign keys.
    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_EndUser_EmployeeId] UNIQUE ([EmployeeId]),
    CONSTRAINT [FK_EndUser_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]),

    [EndUserRoleId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_EndUser_EndUserRole] FOREIGN KEY ([EndUserRoleId]) REFERENCES [dbo].[EndUserRole] ([Id]),

    -- Non-nullable columns.
    [Username] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_EndUser_Username] UNIQUE ([Username]),
    CONSTRAINT [CK_EndUser_Username_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Username]) = 1),
    CONSTRAINT [CK_EndUser_Username_HasNoWhitespace] CHECK ([dbo].[udf_HasNoWhitespaceInNvarchar]([Username]) = 1),

    -- Secret columns.
    [PasswordHash] NVARCHAR(64) NOT NULL,

    [PasswordSalt] UNIQUEIDENTIFIER NOT NULL
);
