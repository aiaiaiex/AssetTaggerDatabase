CREATE FUNCTION [dbo].[udf_GetNvarcharColumnValue](
    @Value NVARCHAR(4000),
    @ColumnValue NVARCHAR(4000)
)
RETURNS NVARCHAR(4000) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @ColumnValue
        ELSE @Value
    END;
END;
