CREATE TABLE [dbo].[EndUser] (
    [EndUserID]           UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_EndUser_EndUserID] DEFAULT (newid()) NOT NULL,
    [EndUserName]         NVARCHAR (50)    NOT NULL,
    [EndUserPasswordHash] NCHAR (32)       NOT NULL,
    CONSTRAINT [AK_EndUser_EndUserName] UNIQUE ([EndUserName]),
    CONSTRAINT [PK_EndUser] PRIMARY KEY CLUSTERED ([EndUserID] ASC)
);
