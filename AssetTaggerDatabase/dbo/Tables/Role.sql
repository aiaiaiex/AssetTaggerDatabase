CREATE TABLE [dbo].[Role] (
    [RoleID] UNIQUEIDENTIFIER CONSTRAINT [DF_Role_RoleID] DEFAULT (NEWID()) NOT NULL,
    [RoleName] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [AK_Role_RoleName] UNIQUE ([RoleName]),
    CONSTRAINT [CK_Role_RoleName_Exclude] CHECK ([RoleName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Role_RoleName_MinimumLength] CHECK (LEN([RoleName]) > 0),
    CONSTRAINT [CK_Role_RoleName_NoTrailingSpace] CHECK ([RoleName] NOT LIKE ' %' AND [RoleName] NOT LIKE '% '),
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([RoleID] ASC)
);
