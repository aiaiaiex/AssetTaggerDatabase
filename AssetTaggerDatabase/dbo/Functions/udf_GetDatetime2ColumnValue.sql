CREATE FUNCTION [dbo].[udf_GetDatetime2ColumnValue](
    @Value NVARCHAR(24),
    @ColumnValue DATETIME2(3)
)
RETURNS DATETIME2(3) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @ColumnValue
        ELSE CAST(@Value AS DATETIME2(3))
    END;
END;
