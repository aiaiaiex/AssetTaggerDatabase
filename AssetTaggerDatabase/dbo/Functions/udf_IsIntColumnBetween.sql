CREATE FUNCTION [dbo].[udf_IsIntColumnBetween](
    @FromValue NVARCHAR(11),
    @ColumnValue INT,
    @ToValue NVARCHAR(11)
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
