CREATE TABLE [dbo].[EndUser] (
    [EndUserID]           UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_EndUser_EndUserID] DEFAULT (newid()) NOT NULL,
    [EndUserName]         NVARCHAR (50)    NOT NULL,
    [EndUserPasswordHash] NCHAR (32)       NOT NULL,
    CONSTRAINT [PK_EndUser] PRIMARY KEY CLUSTERED ([EndUserID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_EndUser_EndUserName]
    ON [dbo].[EndUser]([EndUserName] ASC);

