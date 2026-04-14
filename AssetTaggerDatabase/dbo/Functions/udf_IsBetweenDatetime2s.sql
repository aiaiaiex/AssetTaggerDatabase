CREATE FUNCTION [dbo].[udf_IsBetweenDatetime2s](
    @FromValue NVARCHAR(24),
    @Value DATETIME2(3),
    @ToValue NVARCHAR(24)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            [dbo].[udf_IsLessThanOrEqualToDatetime2Column](@FromValue, @Value) = 1
            AND [dbo].[udf_IsGreaterThanOrEqualToDatetime2Column](@ToValue, @Value) = 1
        )
            THEN 1
        ELSE 0
    END;
END;
