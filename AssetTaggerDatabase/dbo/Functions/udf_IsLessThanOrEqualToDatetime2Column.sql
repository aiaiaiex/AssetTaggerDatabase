CREATE FUNCTION [dbo].[udf_IsLessThanOrEqualToDatetime2Column](
    @Value NVARCHAR(24),
    @ColumnValue DATETIME2(3)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (CAST(@Value AS DATETIME2(3)) <= @ColumnValue)
            OR (@Value IS NULL AND @ColumnValue IS NULL)
        )
            THEN 1
        ELSE 0
    END;
END;
