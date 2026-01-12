CREATE TABLE [dbo].[Employee] (
    [EmployeeID]       UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Employee_EmployeeID] DEFAULT (newid()) NOT NULL,
    [EmployeeFullName] NVARCHAR (50)    NOT NULL,
    [RoleID]           UNIQUEIDENTIFIER NOT NULL,
    [CompanyID]        UNIQUEIDENTIFIER NOT NULL,
    [DepartmentID]     UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [FK_Employee_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_Employee_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID]),
    CONSTRAINT [FK_Employee_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Employee_EmployeeFullName]
    ON [dbo].[Employee]([EmployeeFullName] ASC);

