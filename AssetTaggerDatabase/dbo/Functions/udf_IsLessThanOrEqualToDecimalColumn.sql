CREATE FUNCTION [dbo].[udf_IsLessThanOrEqualToDecimalColumn](
    @Value NVARCHAR(17),
    @ColumnValue DECIMAL(19, 4)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (CAST(@Value AS DECIMAL(19, 4)) <= @ColumnValue)
            OR (@Value IS NULL AND @ColumnValue IS NULL)
        )
            THEN 1
        ELSE 0
    END;
END;
