CREATE FUNCTION [dbo].[udf_IsBetweenBigints](
    @FromValue NVARCHAR(20),
    @Value BIGINT,
    @ToValue NVARCHAR(20)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (
                (@FromValue = '')
                OR (CAST(@FromValue AS BIGINT) <= @Value)
                OR (@FromValue IS NULL AND @Value IS NULL)
            )
            AND
            (
                (@ToValue = '')
                OR (@Value <= CAST(@ToValue AS BIGINT))
                OR (@Value IS NULL AND @ToValue IS NULL)
            )
        )
            THEN 1
        ELSE 0
    END;
END;
