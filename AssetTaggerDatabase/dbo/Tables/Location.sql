CREATE TABLE [dbo].[Location] (
    [LocationID] UNIQUEIDENTIFIER CONSTRAINT [DF_Location_LocationID] DEFAULT (NEWID()) NOT NULL,
    [LocationAddress] NVARCHAR(50) NOT NULL,
    [BuildingID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_Location_LocationAddress_BuildingID] UNIQUE ([LocationAddress], [BuildingID]),
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationID] ASC),
    CONSTRAINT [FK_Location_Building] FOREIGN KEY ([BuildingID]) REFERENCES [dbo].[Building] ([BuildingID])
);
