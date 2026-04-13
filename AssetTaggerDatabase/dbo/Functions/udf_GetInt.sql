CREATE FUNCTION [dbo].[udf_GetInt](
    @Value NVARCHAR(11)
)
RETURNS INT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN NULL
        ELSE CAST(@Value AS INT)
    END;
END;
