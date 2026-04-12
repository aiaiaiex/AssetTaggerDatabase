CREATE FUNCTION [dbo].[udf_GetRowOrder](
    @RowOrder NVARCHAR(4) -- ASC or DESC.
)
RETURNS NVARCHAR(4) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@RowOrder = '')
            THEN 'DESC'
        ELSE @RowOrder
    END;
END;
