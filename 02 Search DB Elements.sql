/*
==========================================================================
	This view shows all user elements for the current database
	Set the two variables to filter by Database Element or Column name
==========================================================================
*/
DECLARE @DBElement	AS VARCHAR(100) = '%OrganizationNode%',
		@Column		AS VARCHAR(100) = '%%';

SELECT 
	SO.Name AS Table_Name,
	CASE 	
				WHEN SO.XType = 'U'		THEN 'Table' 
				WHEN SO.XType = 'V'		THEN 'View'
				WHEN SO.XType = 'P'		THEN 'Stored Procedure'
				WHEN SO.XType = 'FN'	THEN 'Function'
				ELSE 'Other'
	END AS 'Type_Table', 
	crdate as Creation_Date,
	CASE 	
		WHEN SO.XType = 'U' THEN 1 
		WHEN SO.XType = 'V' THEN 2
		WHEN SO.XType = 'P' THEN 3
		WHEN SO.XType = 'FN' THEN 4 
		ELSE 5					
	END AS 'Order_By'
FROM SYSOBJECTS SO 
WHERE xtype IN ('U', 'V', 'P', 'FN')  
  AND NOT (SO.XType = 'P' and SO.Name LIKE 'dt_%')
  AND NOT (SO.XType = 'U' and SO.Name LIKE 'sys%')
  AND NOT (SO.XType = 'V' and SO.Name LIKE 'sys%')
  AND SO.Name LIKE @DBElement;

SELECT T.Name as Table_Name, 
	C.Name as Column_Name, 
	T.ID, T.xType, 
	crdate as Creation_Date, 
	Collation,
CASE 
		WHEN C.xType = 127 THEN 'Number'  -- : bigint
		WHEN C.xType = 173 THEN 'Binary'  -- :  binary
		WHEN C.xType = 104 THEN 'Number'  -- :  bit
		WHEN C.xType = 175 THEN 'String'  -- :  char
		WHEN C.xType = 61  THEN 'Date'  -- :  datetime
		WHEN C.xType = 106 THEN 'Number'  -- :  decimal
		WHEN C.xType = 62  THEN 'Number'  -- :  float
		WHEN C.xType = 34  THEN 'Other'  -- :  image
		WHEN C.xType = 56  THEN 'Number'  -- :  int
		WHEN C.xType = 60  THEN 'Number'  -- :  money
		WHEN C.xType = 239 THEN 'String'  -- :  nchar
		WHEN C.xType = 99  THEN 'String'  -- :  ntext
		WHEN C.xType = 108 THEN 'Number'  -- :  numeric
		WHEN C.xType = 231 THEN 'String'  -- :  nvarchar
		WHEN C.xType = 59  THEN 'Number'  -- :  real
		WHEN C.xType = 58  THEN 'Date'  -- :  smalldatetime
		WHEN C.xType = 52  THEN 'Number'  -- :  smallint
		WHEN C.xType = 122 THEN 'Number'  -- :  smallmoney
		WHEN C.xType = 98  THEN 'Other'  -- :  sql_variant
		WHEN C.xType = 231 THEN 'Other'  --  :  sysname
		WHEN C.xType = 35  THEN 'String'  -- :  text
		WHEN C.xType = 189 THEN 'Date'  -- :  timestamp
		WHEN C.xType = 48  THEN 'Number'  -- :  tinyint
		WHEN C.xType = 36  THEN 'String'  -- :  uniqueidentifier
		WHEN C.xType = 165 THEN 'Other'  -- :  varbinary
		WHEN C.xType = 167 THEN 'String'  -- :  varchar
		ELSE 'Other' 
	END AS Data_Type,
	C.Length
FROM sysobjects T 
INNER JOIN syscolumns C
  ON T.ID = C.ID
WHERE C.Name LIKE @Column
  AND T.Name LIKE @DBElement;


