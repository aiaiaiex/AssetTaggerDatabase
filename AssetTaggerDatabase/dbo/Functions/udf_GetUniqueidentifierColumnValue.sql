CREATE FUNCTION [dbo].[udf_GetUniqueidentifierColumnValue](
    @Value NVARCHAR(36),
    @ColumnValue UNIQUEIDENTIFIER
)
RETURNS UNIQUEIDENTIFIER WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @ColumnValue
        ELSE CAST(@Value AS UNIQUEIDENTIFIER)
    END;
END;
