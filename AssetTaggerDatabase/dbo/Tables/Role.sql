CREATE TABLE [dbo].[Role] (
    [RoleNumber] INT IDENTITY (1, 1),
    [RoleID] UNIQUEIDENTIFIER CONSTRAINT [DF_Role_RoleID] DEFAULT (NEWID()) NOT NULL,
    [RoleName] NVARCHAR(4000) NOT NULL,
    [RoleInsertDate] DATETIME CONSTRAINT [DF_Role_RoleInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_Role_RoleNumber] UNIQUE CLUSTERED ([RoleNumber] ASC),
    CONSTRAINT [AK_Role_RoleName] UNIQUE ([RoleName]),
    CONSTRAINT [CK_Role_RoleName_Exclude] CHECK ([RoleName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Role_RoleName_MinimumLength] CHECK (LEN([RoleName]) > 0),
    CONSTRAINT [CK_Role_RoleName_NoTrailingWhitespace] CHECK ([RoleName] NOT LIKE ' %' AND [RoleName] NOT LIKE '% '),
    CONSTRAINT [PK_Role] PRIMARY KEY NONCLUSTERED ([RoleID] ASC)
);
