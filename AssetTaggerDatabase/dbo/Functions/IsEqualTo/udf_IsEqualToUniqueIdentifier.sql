CREATE FUNCTION [dbo].[udf_IsEqualToUniqueIdentifier](
    @Value NVARCHAR(36),
    @Uniqueidentifier UNIQUEIDENTIFIER
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (@Uniqueidentifier IS NOT DISTINCT FROM CAST(@Value AS UNIQUEIDENTIFIER))
        )
            THEN 1
        ELSE 0
    END;
END;
