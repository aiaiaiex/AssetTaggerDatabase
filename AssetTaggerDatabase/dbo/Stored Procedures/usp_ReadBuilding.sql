CREATE PROCEDURE [dbo].[usp_ReadBuilding]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @BuildingID UNIQUEIDENTIFIER = NULL,
    @BuildingName NVARCHAR(850) = NULL,
    @BuildingAddress NVARCHAR(850) = NULL,
    @CompanyID UNIQUEIDENTIFIER = NULL,
    @FromBuildingInsertDate DATETIME = NULL,
    @ToBuildingInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = 1
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadBuilding BIT = (SELECT ReadBuilding FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadBuilding IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadBuilding = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        BuildingID,
        BuildingName,
        BuildingAddress,
        CompanyID,
        BuildingInsertDate
    FROM
        [dbo].[Building]
    WHERE
        BuildingID = ISNULL(@BuildingID, BuildingID)
        AND (BuildingName = ISNULL(@BuildingName, BuildingName) OR BuildingName LIKE @BuildingName)
        AND (BuildingAddress = ISNULL(@BuildingAddress, BuildingAddress) OR BuildingAddress LIKE @BuildingAddress)
        AND CompanyID = ISNULL(@CompanyID, CompanyID)
        AND ISNULL(@FromBuildingInsertDate, BuildingInsertDate) <= BuildingInsertDate
        AND BuildingInsertDate <= ISNULL(@ToBuildingInsertDate, BuildingInsertDate)
    ORDER BY
        CASE WHEN @NewestRowsFirst = 1 THEN BuildingNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN BuildingNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
