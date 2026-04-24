CREATE FUNCTION [dbo].[udf_CalculateAnnualDepreciationExpense](
    @PurchasePrice DECIMAL(19, 4),
    @SalvageValue DECIMAL(19, 4),
    @UsefulLife INT
)
RETURNS DECIMAL(19, 4) WITH SCHEMABINDING AS
BEGIN
    IF (@UsefulLife <= 0)
        RETURN NULL;

    RETURN (@PurchasePrice - @SalvageValue) / @UsefulLife;

END;
