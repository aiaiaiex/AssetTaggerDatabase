CREATE TABLE [dbo].[Employee] (
    [EmployeeID] UNIQUEIDENTIFIER CONSTRAINT [DF_Employee_EmployeeID] DEFAULT (NEWID()) NOT NULL,
    [EmployeeFullName] NVARCHAR(50) NOT NULL,
    [RoleID] UNIQUEIDENTIFIER NOT NULL,
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    [DepartmentID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_Employee_EmployeeFullName] UNIQUE ([EmployeeFullName]),
    CONSTRAINT [CK_Employee_EmployeeFullName_NoTrailingSpace] CHECK ([EmployeeFullName] NOT LIKE ' %' AND [EmployeeFullName] NOT LIKE '% '),
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [FK_Employee_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_Employee_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID]),
    CONSTRAINT [FK_Employee_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);
