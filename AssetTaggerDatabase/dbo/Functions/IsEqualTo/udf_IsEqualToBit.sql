CREATE FUNCTION [dbo].[udf_IsEqualToBit](
    @Value NVARCHAR(1),
    @Bit BIT
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (@Bit IS NOT DISTINCT FROM CAST(@Value AS BIT))
        )
            THEN 1
        ELSE 0
    END;
END;
