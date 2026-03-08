CREATE TABLE [dbo].[EndUser] (
    [EndUserID] UNIQUEIDENTIFIER CONSTRAINT [DF_EndUser_EndUserID] DEFAULT (NEWID()) NOT NULL,
    [EndUserName] NVARCHAR(50) NOT NULL,
    [EndUserPasswordHash] NCHAR(32) NOT NULL,
    [EndUserRoleID] UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_EndUser_EndUserName] UNIQUE ([EndUserName]),
    CONSTRAINT [AK_EndUser_EmployeeID] UNIQUE ([EmployeeID]),
    CONSTRAINT [CK_EndUser_EndUserName_MinimumLength] CHECK (LEN([EndUserName]) > 0),
    CONSTRAINT [CK_EndUser_EndUserName_NoWhitespace] CHECK (CHARINDEX(' ', [EndUserName]) = 0),
    CONSTRAINT [PK_EndUser] PRIMARY KEY CLUSTERED ([EndUserID] ASC),
    CONSTRAINT [FK_EndUser_EndUserRole] FOREIGN KEY ([EndUserRoleID]) REFERENCES [dbo].[EndUserRole] ([EndUserRoleID]),
    CONSTRAINT [FK_EndUser_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
);
