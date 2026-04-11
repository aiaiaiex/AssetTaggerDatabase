CREATE FUNCTION [dbo].[udf_IsDatetime2ColumnBetween](
    @FromValue NVARCHAR(24),
    @ColumnValue DATETIME2(3),
    @ToValue NVARCHAR(24)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            [dbo].[udf_IsLessThanOrEqualToDatetime2Column](@FromValue, @ColumnValue) = 1
            AND [dbo].[udf_IsGreaterThanOrEqualToDatetime2Column](@ToValue, @ColumnValue) = 1
        )
            THEN 1
        ELSE 0
    END;
END;
