CREATE FUNCTION [dbo].[udf_IsEqualToOrLikeNvarchar](
    @Value NVARCHAR(4000),
    @Nvarchar NVARCHAR(4000)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (@Nvarchar IS NOT DISTINCT FROM @Value)
            OR (@Nvarchar LIKE @Value)
        )
            THEN 1
        ELSE 0
    END;
END;
