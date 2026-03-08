CREATE TABLE [dbo].[Location] (
    [LocationID] UNIQUEIDENTIFIER CONSTRAINT [DF_Location_LocationID] DEFAULT (NEWID()) NOT NULL,
    [LocationAddress] NVARCHAR(4000) NOT NULL,
    [BuildingID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_Location_LocationAddress_BuildingID] UNIQUE ([LocationAddress], [BuildingID]),
    CONSTRAINT [CK_Location_LocationAddress_MinimumLength] CHECK (LEN([LocationAddress]) > 0),
    CONSTRAINT [CK_Location_LocationAddress_NoTrailingSpace] CHECK ([LocationAddress] NOT LIKE ' %' AND [LocationAddress] NOT LIKE '% '),
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationID] ASC),
    CONSTRAINT [FK_Location_Building] FOREIGN KEY ([BuildingID]) REFERENCES [dbo].[Building] ([BuildingID])
);
