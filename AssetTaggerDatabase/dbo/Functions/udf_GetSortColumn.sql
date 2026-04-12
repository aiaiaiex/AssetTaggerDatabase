CREATE FUNCTION [dbo].[udf_GetSortColumn](
    @SortColumn NVARCHAR(4000)
)
RETURNS NVARCHAR(4000) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@SortColumn = '')
            THEN 'RowNumber'
        ELSE @SortColumn
    END;
END;
