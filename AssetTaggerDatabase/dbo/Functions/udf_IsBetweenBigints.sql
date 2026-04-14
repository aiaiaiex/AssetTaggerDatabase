CREATE FUNCTION [dbo].[udf_IsBetweenBigints](
    @FromValue NVARCHAR(20),
    @Value BIGINT,
    @ToValue NVARCHAR(20)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            [dbo].[udf_IsLessThanOrEqualToIntColumn](@FromValue, @Value) = 1
            AND [dbo].[udf_IsGreaterThanOrEqualToIntColumn](@ToValue, @Value) = 1
        )
            THEN 1
        ELSE 0
    END;
END;
