USE AdventureWorks2016;

SELECT	-- BirthDate as in the Database
		BirthDate,	
		-- Today's date in pure DATE format
		CONVERT(DATE, GETDATE()) AS Today,
		-- Difference in Years between Today and the BirthDate
		DATEDIFF(yyyy, BirthDate, GETDATE()) AS Years_Diff,
		-- Same as previous but decreasing in one year if the BirthDate has not been reached
		DATEDIFF(yyyy, BirthDate, GETDATE()) + 
			CASE	WHEN DATEFROMPARTS(DATEPART(yyyy,BirthDate), DATEPART(m, GETDATE()), DATEPART(d, GETDATE())) < BirthDate 
					THEN -1 
					ELSE 0 END
			AS Age,
		-- Age in Days is very easy to calculate with the standard function
		DATEDIFF(d, BirthDate, GETDATE()) AS Age_In_Days,
		-- Age in Months also very easy to calculate
		DATEDIFF(m, BirthDate, GETDATE()) AS Age_In_Months,
		*
	FROM HumanResources.Employee
	ORDER BY MONTH(BirthDate) DESC;