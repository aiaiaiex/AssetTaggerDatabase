CREATE FUNCTION [dbo].[udf_IsEqualToOrLikeNvarcharColumn](
    @Value NVARCHAR(4000),
    @ColumnValue NVARCHAR(4000)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN 1
        WHEN (@ColumnValue IS NOT DISTINCT FROM @Value)
            THEN 1
        WHEN (@ColumnValue LIKE @Value)
            THEN 1
        ELSE 0
    END;
END;
