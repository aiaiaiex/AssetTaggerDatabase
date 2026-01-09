CREATE TABLE [dbo].[EndUser] (
    [EndUserID]           UNIQUEIDENTIFIER NOT NULL,
    [EndUserName]         NVARCHAR (50)    NOT NULL,
    [EndUserPasswordHash] NCHAR (32)       NOT NULL
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [Index_EndUser_1]
    ON [dbo].[EndUser]([EndUserName] ASC);
GO

ALTER TABLE [dbo].[EndUser]
    ADD CONSTRAINT [PK_EndUser] PRIMARY KEY CLUSTERED ([EndUserID] ASC);
GO

ALTER TABLE [dbo].[EndUser]
    ADD CONSTRAINT [DEFAULT_EndUser_EndUserID] DEFAULT (newid()) FOR [EndUserID];
GO

