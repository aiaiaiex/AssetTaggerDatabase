CREATE FUNCTION [dbo].[udf_IsBetweenDecimals](
    @FromValue NVARCHAR(21),
    @Value DECIMAL(19, 4),
    @ToValue NVARCHAR(21)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            [dbo].[udf_IsLessThanOrEqualToDecimalColumn](@FromValue, @Value) = 1
            AND [dbo].[udf_IsGreaterThanOrEqualToDecimalColumn](@ToValue, @Value) = 1
        )
            THEN 1
        ELSE 0
    END;
END;
