CREATE FUNCTION [dbo].[udf_IsLessThanOrEqualToDecimalColumn](
    @Value NVARCHAR(17),
    @ColumnValue DECIMAL(19, 4)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN 1
        WHEN (CAST(@Value AS DECIMAL(19, 4)) <= @ColumnValue)
            THEN 1
        WHEN (@Value IS NULL AND @ColumnValue IS NULL)
            THEN 1
        ELSE 0
    END;
END;
