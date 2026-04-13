CREATE FUNCTION [dbo].[udf_IsEqualToOrLikeNvarcharMaxColumn](
    @Value NVARCHAR(MAX),
    @ColumnValue NVARCHAR(MAX)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (@ColumnValue IS NOT DISTINCT FROM @Value)
            OR (@ColumnValue LIKE @Value)
        )
            THEN 1
        ELSE 0
    END;
END;
