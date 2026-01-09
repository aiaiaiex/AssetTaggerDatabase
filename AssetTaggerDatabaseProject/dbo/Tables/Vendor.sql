CREATE TABLE [dbo].[Vendor] (
    [VendorID]      UNIQUEIDENTIFIER NOT NULL,
    [VendorAddress] NVARCHAR (50)    NOT NULL,
    [VendorName]    NVARCHAR (50)    NOT NULL
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Vendor_VendorAddress_Name]
    ON [dbo].[Vendor]([VendorAddress] ASC, [VendorName] ASC);
GO

ALTER TABLE [dbo].[Vendor]
    ADD CONSTRAINT [DEFAULT_Vendor_VendorID] DEFAULT (newid()) FOR [VendorID];
GO

ALTER TABLE [dbo].[Vendor]
    ADD CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED ([VendorID] ASC);
GO

