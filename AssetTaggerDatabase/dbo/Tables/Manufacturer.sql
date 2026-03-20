CREATE TABLE [dbo].[Manufacturer] (
    [ManufacturerNumber] INT IDENTITY (1, 1),
    [ManufacturerID] UNIQUEIDENTIFIER CONSTRAINT [DF_Manufacturer_ManufacturerID] DEFAULT (NEWID()) NOT NULL,
    [ManufacturerName] NVARCHAR(850) NOT NULL,
    [ManufacturerInsertDate] DATETIMEOFFSET(3) CONSTRAINT [DF_Manufacturer_ManufacturerInsertDate] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,
    CONSTRAINT [AK_Manufacturer_ManufacturerNumber] UNIQUE CLUSTERED ([ManufacturerNumber] ASC),
    CONSTRAINT [PK_Manufacturer] PRIMARY KEY NONCLUSTERED ([ManufacturerID] ASC),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_Exclude] CHECK ([ManufacturerName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_MinimumLength] CHECK (LEN([ManufacturerName]) > 0),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_NoLeadingAndTrailingWhitespace] CHECK ([ManufacturerName] NOT LIKE ' %' AND [ManufacturerName] NOT LIKE '% '),
    CONSTRAINT [AK_Manufacturer_ManufacturerName] UNIQUE NONCLUSTERED ([ManufacturerName] ASC)
);
