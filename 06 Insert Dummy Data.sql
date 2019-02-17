USE [AdventureWorks2016_EXT]
GO
SELECT Min(BusinessEntityID) AS MinID, Max(BusinessEntityID) AS MaxID
	FROM HumanResources.Employee;
--SELECT DISTINCT BusinessEntityID FROM HumanResources.Employee;
--SELECT  BusinessEntityID FROM HumanResources.Employee;
DECLARE @MaxBusinessEntityID AS INTEGER;
SELECT @MaxBusinessEntityID = Max(BusinessEntityID)
	FROM HumanResources.Employee; -- 290
SELECT @MaxBusinessEntityID;
INSERT INTO [HumanResources].[Employee]
	(	BusinessEntityID, [NationalIDNumber], [LoginID], 
		[OrganizationNode], [JobTitle], [BirthDate], [MaritalStatus], [Gender], [HireDate], [SalariedFlag], [VacationHours], [SickLeaveHours], [CurrentFlag], [rowguid], [Manager])
SELECT	@MaxBusinessEntityID + BusinessEntityID, [NationalIDNumber]+RTRIM(LTRIM(CONVERT(VARCHAR(12), BusinessEntityID))), [LoginID]+RTRIM(LTRIM(CONVERT(VARCHAR(12), BusinessEntityID))), 
		[OrganizationNode], [JobTitle], [BirthDate], [MaritalStatus], [Gender], [HireDate], [SalariedFlag], [VacationHours], [SickLeaveHours], [CurrentFlag], NewID(), [Manager]
  FROM [HumanResources].[Employee];





