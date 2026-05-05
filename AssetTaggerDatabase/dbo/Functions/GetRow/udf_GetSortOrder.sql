CREATE FUNCTION [dbo].[udf_GetSortOrder](
    @SortOrder NVARCHAR(4) -- ASC or DESC.
)
RETURNS NVARCHAR(4) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@SortOrder = '')
            THEN 'DESC'
        ELSE @SortOrder
    END;
END;
