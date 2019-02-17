DECLARE @results 
	AS TABLE (
		ProductID INT NOT NULL, 
		Name NVARCHAR(50) NOT NULL,
		ListPrice_BeforeChanges  Money NOT NULL,
		ListPrice_AfterChanges  Money NOT NULL);

BEGIN TRANSACTION;
	UPDATE Production.Product
		SET ListPrice = ListPrice * 1.05
		OUTPUT	Inserted.ProductID, 
				Inserted.Name, 
				Deleted.ListPrice	AS ListPrice_BeforeChanges, 
				Inserted.ListPrice	AS ListPrice_AfterChanges
		INTO @results
		WHERE Name LIKE 'Mountain-500%';
ROLLBACK;

SELECT * FROM @results;