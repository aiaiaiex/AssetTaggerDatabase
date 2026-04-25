CREATE TABLE [dbo].[Employee] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Employee_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Employee_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Employee_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Nullable foreign keys.
    [CompanyId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Employee_Company] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]),

    [DepartmentId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Employee_Department] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Department] ([Id]),

    [RoleId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Employee_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([Id]),

    -- Non-nullable columns.
    [FullName] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Employee_FullName] UNIQUE ([FullName]),
    CONSTRAINT [CK_Employee_FullName_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([FullName]) = 1),
    CONSTRAINT [CK_Employee_FullName_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([FullName]) = 1)
);
