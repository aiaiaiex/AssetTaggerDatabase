CREATE VIEW [dbo].[VI_NonNullishConstants] WITH SCHEMABINDING
AS
SELECT
    -- @NON_NULLISH_UNIQUEIDENTIFIER (11111111-1111-1111-1111-111111111111) will never be equal to NEWID() because NEWID() complies with RFC4122 which should always include the version number in the generated UNIQUEIDENTIFIER which can't be 1 because the version number of random UUIDs is 4.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/newid-transact-sql
    -- https://datatracker.ietf.org/doc/html/rfc4122#section-4.1.3
    CONVERT(UNIQUEIDENTIFIER, '11111111-1111-1111-1111-111111111111') AS NON_NULLISH_UNIQUEIDENTIFIER,
    CONVERT(NVARCHAR(4000), '!') AS NON_NULLISH_NVARCHAR,
    CONVERT(NCHAR(1), '!') AS NON_NULLISH_NCHAR,
    CONVERT(DATETIMEOFFSET(3), '2900-01-01T00:00:00.000Z') AS NON_NULLISH_DATETIMEOFFSET,
    CONVERT(INT, 2147483647) AS NON_NULLISH_INT,
    CONVERT(DECIMAL(15, 4), 99999999999.9999) AS NON_NULLISH_DECIMAL
