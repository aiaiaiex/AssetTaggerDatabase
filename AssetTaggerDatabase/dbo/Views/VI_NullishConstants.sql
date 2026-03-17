CREATE VIEW [dbo].[VI_NullishConstants] WITH SCHEMABINDING
AS
SELECT
    -- @NULLISH_UNIQUEIDENTIFIER (00000000-0000-0000-0000-000000000000) will never be equal to NEWID() because NEWID() complies with RFC4122 which should always include the version number in the generated UNIQUEIDENTIFIER which can't be 0 because the version number of random UUIDs is 4.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/newid-transact-sql
    -- https://datatracker.ietf.org/doc/html/rfc4122#section-4.1.3
    CAST('00000000-0000-0000-0000-000000000000' AS UNIQUEIDENTIFIER) AS NULLISH_UNIQUEIDENTIFIER,
    CAST('' AS NVARCHAR(4000)) AS NULLISH_NVARCHAR,
    CAST('' AS NCHAR(1)) AS NULLISH_NCHAR,
    CAST('1753-01-01 00:00:00.000' AS DATETIME) AS NULLISH_DATETIME,
    CAST(-2147483648 AS INT) AS NULLISH_INT,
    CAST(-999999999999999.9999 AS DECIMAL(19, 4)) AS NULLISH_DECIMAL
