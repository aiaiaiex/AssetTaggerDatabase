CREATE TABLE [dbo].[Manufacturer] (
    [ManufacturerID] UNIQUEIDENTIFIER CONSTRAINT [DF_Manufacturer_ManufacturerID] DEFAULT (NEWID()) NOT NULL,
    [ManufacturerName] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [PK_Manufacturer] PRIMARY KEY CLUSTERED ([ManufacturerID] ASC),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_Exclude] CHECK ([ManufacturerName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_MinimumLength] CHECK (LEN([ManufacturerName]) > 0),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_NoTrailingSpace] CHECK ([ManufacturerName] NOT LIKE ' %' AND [ManufacturerName] NOT LIKE '% '),
    CONSTRAINT [AK_Manufacturer_ManufacturerName] UNIQUE NONCLUSTERED ([ManufacturerName] ASC)
);
