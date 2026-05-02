CREATE TABLE [dbo].[InHouseUnit] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_InHouseUnit_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_InHouseUnit_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_InHouseUnit] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_InHouseUnit_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Nullable foreign keys.
    [CompanyId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_InHouseUnit_Company] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]),

    [DepartmentId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_InHouseUnit_Department] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Department] ([Id]),

    [EmployeeId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_InHouseUnit_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]),

    -- Composite constraints.
    CONSTRAINT [CTK_InHouseUnit_CompanyId_DepartmentId_EmployeeId] CHECK (
        ([EmployeeId] IS NULL AND ([CompanyId] IS NOT NULL OR [DepartmentId] IS NOT NULL))
        OR ([EmployeeId] IS NOT NULL AND [CompanyId] IS NULL AND [DepartmentId] IS NULL)
    )
);
GO

CREATE UNIQUE INDEX [IX_InHouseUnit_CompanyId_DepartmentId]
    ON [dbo].[InHouseUnit] ([CompanyId], [DepartmentId])
    WHERE [EmployeeId] IS NULL;
GO

CREATE UNIQUE INDEX [IX_InHouseUnit_EmployeeId]
    ON [dbo].[InHouseUnit] ([EmployeeId])
    WHERE [EmployeeId] IS NOT NULL;
