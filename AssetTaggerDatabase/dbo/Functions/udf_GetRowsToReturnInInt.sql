CREATE FUNCTION [dbo].[udf_GetRowsToReturnInInt](
    @RowsToReturnInNvarchar NVARCHAR(10)
)
RETURNS INT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@RowsToReturnInNvarchar = '')
            OR (@RowsToReturnInNvarchar IS NULL)
        )
            -- Fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of RowNumber.
            -- See more:
            -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
            THEN 2147483647
        ELSE CAST(@RowsToReturnInNvarchar AS INT)
    END;
END;
