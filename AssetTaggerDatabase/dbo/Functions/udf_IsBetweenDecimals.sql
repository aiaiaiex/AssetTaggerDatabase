CREATE FUNCTION [dbo].[udf_IsBetweenDecimals](
    @FromValue NVARCHAR(21),
    @Value DECIMAL(19, 4),
    @ToValue NVARCHAR(21)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (
                (@FromValue = '')
                OR (CAST(@FromValue AS DECIMAL(19, 4)) <= @Value)
                OR (@FromValue IS NULL AND @Value IS NULL)
            )
            AND
            (
                (@ToValue = '')
                OR (@Value <= CAST(@ToValue AS DECIMAL(19, 4)))
                OR (@Value IS NULL AND @ToValue IS NULL)
            )
        )
            THEN 1
        ELSE 0
    END;
END;
