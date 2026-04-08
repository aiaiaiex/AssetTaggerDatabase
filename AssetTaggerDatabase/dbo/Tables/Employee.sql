CREATE TABLE [dbo].[Employee] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Employee_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Employee_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIMEOFFSET(3) CONSTRAINT [DF_Employee_CreatedAt] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,

    -- Foreign keys.
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Employee_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([Id]),

    [DepartmentID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Employee_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([Id]),

    [RoleID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Employee_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([Id]),

    -- Non-nullable columns.
    [FullName] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Employee_FullName] UNIQUE ([FullName]),
    CONSTRAINT [CK_Employee_FullName_Exclude] CHECK ([FullName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Employee_FullName_MinimumLength] CHECK (LEN([FullName]) > 0),
    CONSTRAINT [CK_Employee_FullName_NoLeadingAndTrailingWhitespace] CHECK ([FullName] NOT LIKE ' %' AND [FullName] NOT LIKE '% ')
);
