USE AdventureWorks2016_Ext;
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT	-- Same as previous but decreasing in one year if the BirthDate has not been reached
		SUM(
		DATEDIFF(yyyy, BirthDate, GETDATE()) + 
			CASE	WHEN DATEFROMPARTS(DATEPART(yyyy,BirthDate), DATEPART(m, GETDATE()), DATEPART(d, GETDATE())) < BirthDate 
					THEN -1 
					ELSE 0 END
					)
			AS Age
 --SQL Server Execution Times:
 --  CPU time = 31 ms,  elapsed time = 24 ms.
		--SUM(
		--dbo.Calculate_Age(BirthDate, GETDATE())) AS Age
 --SQL Server Execution Times:
   --CPU time = 78 ms,  elapsed time = 132 ms.
	FROM HumanResources.EmployeeTest
	--ORDER BY MONTH(BirthDate) DESC;
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
 --SQL Server Execution Times:
 --  CPU time = 0 ms,  elapsed time = 224 ms.
  --SQL Server Execution Times:
  -- CPU time = 0 ms,  elapsed time = 338 ms.
GO
DROP FUNCTION Calculate_Age;
GO
CREATE FUNCTION dbo.Calculate_Age(
					@AgeToCalculate AS DATE,
					@CurrentDate	AS DATE
					)
		RETURNS [INTEGER]
AS
BEGIN
	DECLARE @Age AS INTEGER;
	SELECT @Age = DATEDIFF(yyyy, @AgeToCalculate, @CurrentDate) + 
			CASE	WHEN DATEFROMPARTS(DATEPART(yyyy,@AgeToCalculate), DATEPART(m, @CurrentDate), DATEPART(d, @CurrentDate)) < @AgeToCalculate 
					THEN -1 
					ELSE 0 END
 	RETURN 	@Age
END
GO