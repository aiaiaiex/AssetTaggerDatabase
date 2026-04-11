CREATE FUNCTION [dbo].[udf_IsEqualToUniqueIdentifierColumn](
    @Value NVARCHAR(36),
    @ColumnValue UNIQUEIDENTIFIER
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN 1
        WHEN (@ColumnValue IS NOT DISTINCT FROM CAST(@Value AS UNIQUEIDENTIFIER))
            THEN 1
        ELSE 0
    END;
END;
