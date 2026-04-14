CREATE FUNCTION [dbo].[udf_IsEqualToOrLikeNvarcharMax](
    @Value NVARCHAR(MAX),
    @NvarcharMax NVARCHAR(MAX)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (@NvarcharMax IS NOT DISTINCT FROM @Value)
            OR (@NvarcharMax LIKE @Value)
        )
            THEN 1
        ELSE 0
    END;
END;
