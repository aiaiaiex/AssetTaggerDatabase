CREATE TABLE [dbo].[EndUser] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_EndUser_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_EndUser_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_EndUser] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIMEOFFSET(3) CONSTRAINT [DF_EndUser_CreatedAt] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,

    -- Foreign keys.
    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_EndUser_EmployeeId] UNIQUE ([EmployeeId]),
    CONSTRAINT [FK_EndUser_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]),

    [EndUserRoleId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_EndUser_EndUserRole] FOREIGN KEY ([EndUserRoleId]) REFERENCES [dbo].[EndUserRole] ([Id]),

    -- Non-nullable columns.
    [Username] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_EndUser_Username] UNIQUE ([Username]),
    CONSTRAINT [CK_EndUser_Username_Exclude] CHECK ([Username] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_EndUser_Username_MinimumLength] CHECK (LEN([Username]) > 0),
    CONSTRAINT [CK_EndUser_Username_NoWhitespace] CHECK (CHARINDEX(' ', [Username]) = 0),

    [PasswordSalt] UNIQUEIDENTIFIER NOT NULL,

    [PasswordHash] NCHAR(64) NOT NULL
);
