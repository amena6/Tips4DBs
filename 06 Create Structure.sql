USE [AdventureWorks2016_EXT]
GO

/****** Object:  Table [HumanResources].[Employee]    Script Date: 09/12/2018 15:43:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [HumanResources].[EmployeeTest](
	[BusinessEntityID] [int] IDENTITY(1, 1),
	[NationalIDNumber] [nvarchar](15) NOT NULL,
	[LoginID] [nvarchar](256) NOT NULL,
	[OrganizationNode] [hierarchyid] NULL,
	[OrganizationLevel]  AS ([OrganizationNode].[GetLevel]()),
	[JobTitle] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[MaritalStatus] [nchar](1) NOT NULL,
	[Gender] [nchar](1) NOT NULL,
	[HireDate] [date] NOT NULL,
	[SalariedFlag] [dbo].[Flag] NOT NULL,
	[VacationHours] [smallint] NOT NULL,
	[SickLeaveHours] [smallint] NOT NULL,
	[CurrentFlag] [dbo].[Flag] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[Manager] [int] NULL,
 CONSTRAINT [PK_Employee_BusinessEntityIDTest] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
DECLARE @I AS Integer;
SET @I = 1
WHILE @I < 100
	BEGIN
		INSERT INTO [HumanResources].[EmployeeTest]
			(	[NationalIDNumber], [LoginID], ModifiedDate,
				[OrganizationNode], [JobTitle], [BirthDate], [MaritalStatus], [Gender], [HireDate], [SalariedFlag], [VacationHours], [SickLeaveHours], [CurrentFlag], [Manager])
		SELECT	[NationalIDNumber], [LoginID], GETDATE(),
				[OrganizationNode], [JobTitle], [BirthDate], [MaritalStatus], [Gender], [HireDate], [SalariedFlag], [VacationHours], [SickLeaveHours], [CurrentFlag], [Manager]
		  FROM [HumanResources].[Employee];
		SET @I = @I + 1
	END 