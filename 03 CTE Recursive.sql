WITH CTE
AS
(
	-- Case Base
    SELECT DISTINCT
        E1.BusinessEntityID AS BusinessEntityID,
		E1.LoginID, 
		ISNULL(E1.OrganizationLevel, 0) AS Manager,
		CONVERT(VARCHAR(MAX), E1.JobTitle) AS JobTitle,
        CONVERT(VARCHAR(MAX), '0') AS Manager_Tree
    FROM HumanResources.Employee E1
    WHERE ISNULL(E1.OrganizationLevel, 0) = 0
   UNION ALL
   -- Recursive Branch
    SELECT
        ES.BusinessEntityID,
		ES.LoginID,
		ES.OrganizationLevel,
		CONVERT(VARCHAR(MAX), RTRIM(CONVERT(VARCHAR(100), ES.JobTitle)) + ' | ' + C.JobTitle ),
        CONVERT(VARCHAR(MAX), RTRIM(CONVERT(VARCHAR(100), ES.OrganizationLevel)) + ' | ' + C.Manager_Tree )
    FROM CTE C
    INNER JOIN HumanResources.Employee ES
		ON  C.BusinessEntityID = ES.OrganizationLevel
)
SELECT * 
	FROM CTE 
	ORDER BY BusinessEntityID;
