BEGIN TRANSACTION;
	UPDATE Production.Product
		SET ListPrice = ListPrice * 1.05
		OUTPUT	Inserted.ProductID, 
				Inserted.Name, 
				Deleted.ListPrice	AS ListPrice_BeforeChanges, 
				Inserted.ListPrice	AS ListPrice_AfterChanges
		WHERE Name LIKE 'Mountain-500%';
ROLLBACK;
