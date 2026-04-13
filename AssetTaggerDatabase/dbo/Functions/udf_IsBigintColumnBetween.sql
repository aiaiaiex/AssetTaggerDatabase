CREATE FUNCTION [dbo].[udf_IsBigintColumnBetween](
    @FromValue NVARCHAR(20),
    @ColumnValue BIGINT,
    @ToValue NVARCHAR(20)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            [dbo].[udf_IsLessThanOrEqualToIntColumn](@FromValue, @ColumnValue) = 1
            AND [dbo].[udf_IsGreaterThanOrEqualToIntColumn](@ToValue, @ColumnValue) = 1
        )
            THEN 1
        ELSE 0
    END;
END;
