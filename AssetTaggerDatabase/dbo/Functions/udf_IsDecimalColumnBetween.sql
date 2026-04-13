CREATE FUNCTION [dbo].[udf_IsDecimalColumnBetween](
    @FromValue NVARCHAR(21),
    @ColumnValue INT,
    @ToValue NVARCHAR(21)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            [dbo].[udf_IsLessThanOrEqualToDecimalColumn](@FromValue, @ColumnValue) = 1
            AND [dbo].[udf_IsGreaterThanOrEqualToDecimalColumn](@ToValue, @ColumnValue) = 1
        )
            THEN 1
        ELSE 0
    END;
END;
