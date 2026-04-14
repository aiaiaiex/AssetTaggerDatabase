CREATE FUNCTION [dbo].[udf_IsBetweenDatetime2s](
    @FromValue NVARCHAR(24),
    @Value DATETIME2(3),
    @ToValue NVARCHAR(24)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (
                (@FromValue = '')
                OR (CAST(@FromValue AS DATETIME2(3)) <= @Value)
                OR (@FromValue IS NULL AND @Value IS NULL)
            )
            AND
            (
                (@ToValue = '')
                OR (@Value <= CAST(@ToValue AS DATETIME2(3)))
                OR (@Value IS NULL AND @ToValue IS NULL)
            )
        )
            THEN 1
        ELSE 0
    END;
END;
