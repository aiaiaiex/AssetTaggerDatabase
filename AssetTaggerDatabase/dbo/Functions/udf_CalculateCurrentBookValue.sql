CREATE FUNCTION [dbo].[udf_CalculateCurrentBookValue](
    @AssetPurchasePrice DECIMAL(19, 4),
    @AssetSalvageValue DECIMAL(19, 4),
    @AssetUsefulLife INT,
    @AssetPurchaseDate DATETIME
)
RETURNS DECIMAL(19, 4) WITH SCHEMABINDING AS
BEGIN
    DECLARE @YearsPassed INT = DATEDIFF(DD, @AssetPurchaseDate, GETDATE()) / 365;

    IF (@YearsPassed < 0)
        RETURN NULL;

    DECLARE
        @CurrentBookValue DECIMAL(19, 4)
        = @AssetPurchasePrice
        - [dbo].[udf_CalculateAnnualDepreciationExpense](
            @AssetPurchasePrice,
            @AssetSalvageValue,
            @AssetUsefulLife
        )
        * @YearsPassed;

    IF (@CurrentBookValue < @AssetSalvageValue)
        RETURN @AssetSalvageValue;

    RETURN @CurrentBookValue;
END;
