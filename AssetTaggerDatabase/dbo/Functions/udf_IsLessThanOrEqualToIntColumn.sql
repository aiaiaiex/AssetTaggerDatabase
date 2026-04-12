CREATE FUNCTION [dbo].[udf_IsLessThanOrEqualToIntColumn](
    @Value NVARCHAR(11),
    @ColumnValue INT
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (CAST(@Value AS INT) <= @ColumnValue)
            OR (@Value IS NULL AND @ColumnValue IS NULL)
        )
            THEN 1
        ELSE 0
    END;
END;
