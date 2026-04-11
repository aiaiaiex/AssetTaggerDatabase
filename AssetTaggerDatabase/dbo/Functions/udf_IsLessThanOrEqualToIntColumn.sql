CREATE FUNCTION [dbo].[udf_IsLessThanOrEqualToIntColumn](
    @Value NVARCHAR(11),
    @ColumnValue INT
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN 1
        WHEN (CAST(@Value AS INT) <= @ColumnValue)
            THEN 1
        WHEN (@Value IS NULL AND @ColumnValue IS NULL)
            THEN 1
        ELSE 0
    END;
END;
