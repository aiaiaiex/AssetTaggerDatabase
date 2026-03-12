CREATE TABLE [dbo].[Employee] (
    [EmployeeNumber] INT IDENTITY (1, 1),
    [EmployeeID] UNIQUEIDENTIFIER CONSTRAINT [DF_Employee_EmployeeID] DEFAULT (NEWID()) NOT NULL,
    [EmployeeFullName] NVARCHAR(4000) NOT NULL,
    [RoleID] UNIQUEIDENTIFIER NOT NULL,
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    [DepartmentID] UNIQUEIDENTIFIER NOT NULL,
    [EmployeeInsertDate] DATETIME CONSTRAINT [DF_Employee_EmployeeInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_Employee_EmployeeNumber] UNIQUE CLUSTERED ([EmployeeNumber] ASC),
    CONSTRAINT [AK_Employee_EmployeeFullName] UNIQUE ([EmployeeFullName]),
    CONSTRAINT [CK_Employee_EmployeeFullName_Exclude] CHECK ([EmployeeFullName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Employee_EmployeeFullName_MinimumLength] CHECK (LEN([EmployeeFullName]) > 0),
    CONSTRAINT [CK_Employee_EmployeeFullName_NoTrailingWhitespace] CHECK ([EmployeeFullName] NOT LIKE ' %' AND [EmployeeFullName] NOT LIKE '% '),
    CONSTRAINT [PK_Employee] PRIMARY KEY NONCLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [FK_Employee_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_Employee_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID]),
    CONSTRAINT [FK_Employee_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);
