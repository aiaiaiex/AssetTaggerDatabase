CREATE FUNCTION [dbo].[udf_IsLessThanOrEqualToDatetime2Column](
    @Value NVARCHAR(24),
    @ColumnValue DATETIME2(3)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN 1
        WHEN (CAST(@Value AS DATETIME2(3)) <= @ColumnValue)
            THEN 1
        WHEN (@Value IS NULL AND @ColumnValue IS NULL)
            THEN 1
        ELSE 0
    END;
END;
