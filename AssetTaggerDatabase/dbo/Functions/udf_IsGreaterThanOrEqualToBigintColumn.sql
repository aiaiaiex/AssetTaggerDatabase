CREATE FUNCTION [dbo].[udf_IsGreaterThanOrEqualToBigintColumn](
    @Value NVARCHAR(20),
    @ColumnValue BIGINT
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (CAST(@Value AS BIGINT) >= @ColumnValue)
            OR (@Value IS NULL AND @ColumnValue IS NULL)
        )
            THEN 1
        ELSE 0
    END;
END;
