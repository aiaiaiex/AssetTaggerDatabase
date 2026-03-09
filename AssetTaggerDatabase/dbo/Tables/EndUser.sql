CREATE TABLE [dbo].[EndUser] (
    [EndUserNumber] INT IDENTITY (1, 1),
    [EndUserID] UNIQUEIDENTIFIER CONSTRAINT [DF_EndUser_EndUserID] DEFAULT (NEWID()) NOT NULL,
    [EndUserName] NVARCHAR(4000) NOT NULL,
    [EndUserPasswordHash] NCHAR(64) NOT NULL,
    [EndUserRoleID] UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID] UNIQUEIDENTIFIER NOT NULL,
    [EndUserRegisterDate] DATETIME CONSTRAINT [DF_EndUser_EndUserRegisterDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_EndUser_EndUserNumber] UNIQUE CLUSTERED ([EndUserNumber] ASC),
    CONSTRAINT [AK_EndUser_EndUserName] UNIQUE ([EndUserName]),
    CONSTRAINT [AK_EndUser_EmployeeID] UNIQUE ([EmployeeID]),
    CONSTRAINT [CK_EndUser_EndUserName_Exclude] CHECK ([EndUserName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_EndUser_EndUserName_MinimumLength] CHECK (LEN([EndUserName]) > 0),
    CONSTRAINT [CK_EndUser_EndUserName_NoWhitespace] CHECK (CHARINDEX(' ', [EndUserName]) = 0),
    CONSTRAINT [PK_EndUser] PRIMARY KEY NONCLUSTERED ([EndUserID] ASC),
    CONSTRAINT [FK_EndUser_EndUserRole] FOREIGN KEY ([EndUserRoleID]) REFERENCES [dbo].[EndUserRole] ([EndUserRoleID]),
    CONSTRAINT [FK_EndUser_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
);
