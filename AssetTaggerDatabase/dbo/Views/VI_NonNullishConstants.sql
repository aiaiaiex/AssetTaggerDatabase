CREATE VIEW [dbo].[VI_NonNullishConstants] WITH SCHEMABINDING
AS
SELECT
    -- @NON_NULLISH_UNIQUEIDENTIFIER (11111111-1111-1111-1111-111111111111) will never be equal to NEWID() because NEWID() complies with RFC4122 which should always include the version number in the generated UNIQUEIDENTIFIER which can't be 1 because the version number of random UUIDs is 4.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/newid-transact-sql
    -- https://datatracker.ietf.org/doc/html/rfc4122#section-4.1.3
    CAST('11111111-1111-1111-1111-111111111111' AS UNIQUEIDENTIFIER) AS NON_NULLISH_UNIQUEIDENTIFIER,
    CAST('!' AS NVARCHAR(4000)) AS NON_NULLISH_NVARCHAR,
    CAST('!' AS NCHAR(1)) AS NON_NULLISH_NCHAR,
    CAST('2900-01-01T00:00:00.000Z' AS DATETIMEOFFSET(3)) AS NON_NULLISH_DATETIMEOFFSET,
    CAST(2147483647 AS INT) AS NON_NULLISH_INT,
    CAST(99999999999.9999 AS DECIMAL(15, 4)) AS NON_NULLISH_DECIMAL
