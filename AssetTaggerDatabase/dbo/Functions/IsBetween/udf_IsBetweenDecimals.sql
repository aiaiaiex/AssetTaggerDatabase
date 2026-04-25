CREATE FUNCTION [dbo].[udf_IsBetweenDecimals](
    @FromValue NVARCHAR(17),
    @Value DECIMAL(15, 4),
    @ToValue NVARCHAR(17)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (
                (@FromValue = '')
                OR (CAST(@FromValue AS DECIMAL(15, 4)) <= @Value)
                OR (@FromValue IS NULL AND @Value IS NULL)
            )
            AND
            (
                (@ToValue = '')
                OR (@Value <= CAST(@ToValue AS DECIMAL(15, 4)))
                OR (@Value IS NULL AND @ToValue IS NULL)
            )
        )
            THEN 1
        ELSE 0
    END;
END;
