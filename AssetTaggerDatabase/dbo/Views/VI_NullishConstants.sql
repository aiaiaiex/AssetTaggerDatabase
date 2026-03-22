CREATE VIEW [dbo].[VI_NullishConstants] WITH SCHEMABINDING
AS
SELECT
    -- @NULLISH_UNIQUEIDENTIFIER (00000000-0000-0000-0000-000000000000) will never be equal to NEWID() because NEWID() complies with RFC4122 which should always include the version number in the generated UNIQUEIDENTIFIER which can't be 0 because the version number of random UUIDs is 4.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/newid-transact-sql
    -- https://datatracker.ietf.org/doc/html/rfc4122#section-4.1.3
    CONVERT(UNIQUEIDENTIFIER, '00000000-0000-0000-0000-000000000000') AS NULLISH_UNIQUEIDENTIFIER,
    CONVERT(NVARCHAR(4000), '') AS NULLISH_NVARCHAR,
    CONVERT(NCHAR(1), '') AS NULLISH_NCHAR,
    CONVERT(DATETIMEOFFSET(3), '1900-01-01T00:00:00.000Z') AS NULLISH_DATETIMEOFFSET,
    CONVERT(INT, -2147483648) AS NULLISH_INT,
    CONVERT(DECIMAL(15, 4), -99999999999.9999) AS NULLISH_DECIMAL,
    CONVERT(BIGINT, -9223372036854775808) AS NULLISH_BIGINT
