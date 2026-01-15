CREATE TABLE [dbo].[Location] (
    [LocationID]      UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Location_LocationID] DEFAULT (newid()) NOT NULL,
    [LocationAddress] NVARCHAR (50)    NOT NULL,
    [BuildingID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationID] ASC),
    CONSTRAINT [FK_Location_Building] FOREIGN KEY ([BuildingID]) REFERENCES [dbo].[Building] ([BuildingID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Location_LocationAddress_BuildingID]
    ON [dbo].[Location]([LocationAddress] ASC, [BuildingID] ASC);

