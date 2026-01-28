CREATE TABLE [dbo].[EndUserRole] (
    [EndUserRoleID]   UNIQUEIDENTIFIER CONSTRAINT [DF_EndUserRole_EndUserRoleID] DEFAULT (newid()) NOT NULL,
    [EndUserRoleName] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_EndUserRole] PRIMARY KEY CLUSTERED ([EndUserRoleID] ASC),
    CONSTRAINT [AK_EndUserRole_EndUserRoleName] UNIQUE NONCLUSTERED ([EndUserRoleName] ASC)
);

